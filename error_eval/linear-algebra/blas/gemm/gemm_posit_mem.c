/**
 * This version is stamped on May 10, 2016
 *
 * Contact:
 *   Louis-Noel Pouchet <pouchet.ohio-state.edu>
 *   Tomofumi Yuki <tomofumi.yuki.fr>
 *
 * Web address: http://polybench.sourceforge.net
 */
/* gemm.c: this file is part of PolyBench/C */

#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include <math.h>

/* Include polybench common header. */
#include <polybench.h>

/* Include benchmark-specific header. */
#include "gemm.h"

/* Array initialization. */
static void init_array(int ni, int nj, int nk,
					   MEM_TYPE *alpha_mem,
					   MEM_TYPE *beta_mem,
					   MEM_TYPE POLYBENCH_2D(C_MEM, NI, NJ, ni, nj),
					   MEM_TYPE POLYBENCH_2D(A_MEM, NI, NK, ni, nk),
					   MEM_TYPE POLYBENCH_2D(B_MEM, NK, NJ, nk, nj),
					   DATA_TYPE *alpha,
					   DATA_TYPE *beta,
					   DATA_TYPE POLYBENCH_2D(C, NI, NJ, ni, nj),
					   DATA_TYPE POLYBENCH_2D(A, NI, NK, ni, nk),
					   DATA_TYPE POLYBENCH_2D(B, NK, NJ, nk, nj))
{
	int i, j;

	*alpha_mem = 1.5;
	*beta_mem = 1.2;
	*alpha = (DATA_TYPE)(*alpha_mem);
	*beta = (DATA_TYPE)(*beta_mem);
	for (i = 0; i < ni; i++)
		for (j = 0; j < nj; j++)
		{
			C_MEM[i][j] = (MEM_TYPE)((i * j + 1) % ni) / ni;
			C[i][j] = (DATA_TYPE)(C_MEM[i][j]);
		}
	for (i = 0; i < ni; i++)
		for (j = 0; j < nk; j++)
		{
			A_MEM[i][j] = (MEM_TYPE)(i * (j + 1) % nk) / nk;
			A[i][j] = (DATA_TYPE)(A_MEM[i][j]);
		}
	for (i = 0; i < nk; i++)
		for (j = 0; j < nj; j++)
		{
			B_MEM[i][j] = (MEM_TYPE)(i * (j + 2) % nj) / nj;
			B[i][j] = (DATA_TYPE)(B_MEM[i][j]);
		}
}

/* DCE code. Must scan the entire live-out data.
   Can be used also to check the correctness of the output. */
static void print_array(int ni, int nj,
						MEM_TYPE POLYBENCH_2D(C_MEM, NI, NJ, ni, nj))
{
	int i, j;

	POLYBENCH_DUMP_START;
	POLYBENCH_DUMP_BEGIN("C");
	for (i = 0; i < ni; i++)
		for (j = 0; j < nj; j++)
		{
			if ((i * ni + j) % 20 == 0)
				fprintf (POLYBENCH_DUMP_TARGET, "\n");
#ifdef DATA_TYPE_IS_POSIT
			std::cout << hex_format(C_MEM[i][j]) << " ";
#else
			fprintf (POLYBENCH_DUMP_TARGET, DATA_PRINTF_MODIFIER, C_MEM[i][j]);
#endif
		}
	POLYBENCH_DUMP_END("C");
	POLYBENCH_DUMP_FINISH;
}

/* Main computational kernel. The whole function will be timed,
   including the call and return. */
static void kernel_gemm(int ni, int nj, int nk,
						DATA_TYPE alpha,
						DATA_TYPE beta,
						DATA_TYPE POLYBENCH_2D(C, NI, NJ, ni, nj),
						DATA_TYPE POLYBENCH_2D(A, NI, NK, ni, nk),
						DATA_TYPE POLYBENCH_2D(B, NK, NJ, nk, nj))
{
	int i, j, k;

// BLAS PARAMS
// TRANSA = 'N'
// TRANSB = 'N'
//  => Form C := alpha*A*B + beta*C,
// A is NIxNK
// B is NKxNJ
// C is NIxNJ
#pragma scop
	for (i = 0; i < _PB_NI; i++)
	{
		for (j = 0; j < _PB_NJ; j++)
			C[i][j] *= beta;
		for (k = 0; k < _PB_NK; k++)
		{
			for (j = 0; j < _PB_NJ; j++)
				C[i][j] += alpha * A[i][k] * B[k][j];
		}
	}
#pragma endscop
}

int main(int argc, char **argv)
{
	/* Retrieve problem size. */
	int ni = NI;
	int nj = NJ;
	int nk = NK;

	/* Variable declaration/allocation. */
	MEM_TYPE alpha_mem;
	MEM_TYPE beta_mem;
	POLYBENCH_2D_ARRAY_DECL(C_MEM, MEM_TYPE, NI, NJ, ni, nj);
	POLYBENCH_2D_ARRAY_DECL(A_MEM, MEM_TYPE, NI, NK, ni, nk);
	POLYBENCH_2D_ARRAY_DECL(B_MEM, MEM_TYPE, NK, NJ, nk, nj);
	DATA_TYPE alpha;
	DATA_TYPE beta;
	POLYBENCH_2D_ARRAY_DECL(C, DATA_TYPE, NI, NJ, ni, nj);
	POLYBENCH_2D_ARRAY_DECL(A, DATA_TYPE, NI, NK, ni, nk);
	POLYBENCH_2D_ARRAY_DECL(B, DATA_TYPE, NK, NJ, nk, nj);

	/* Initialize array(s). */
	init_array(ni, nj, nk, 
			   &alpha_mem, &beta_mem,
			   POLYBENCH_ARRAY(C_MEM),
			   POLYBENCH_ARRAY(A_MEM),
			   POLYBENCH_ARRAY(B_MEM),
			   &alpha, &beta,
			   POLYBENCH_ARRAY(C),
			   POLYBENCH_ARRAY(A),
			   POLYBENCH_ARRAY(B));

	/* Start timer. */
	polybench_start_instruments;

	/* Run kernel. */
	kernel_gemm(ni, nj, nk,
				alpha, beta,
				POLYBENCH_ARRAY(C),
				POLYBENCH_ARRAY(A),
				POLYBENCH_ARRAY(B));

	/* Stop and print timer. */
	polybench_stop_instruments;
	polybench_print_instruments;

	/* Prevent dead-code elimination. All live-out data must be printed
		by the function call in argument. */
	/* Convert result to original format */
	for (int i = 0; i < ni; i++)
		for (int j = 0; j < nj; j++)
			(POLYBENCH_ARRAY(C_MEM))[i][j] = (MEM_TYPE)((POLYBENCH_ARRAY(C))[i][j]);
	polybench_prevent_dce(print_array(ni, nj, POLYBENCH_ARRAY(C_MEM)));

	/* Be clean. */
	POLYBENCH_FREE_ARRAY(C_MEM);
	POLYBENCH_FREE_ARRAY(A_MEM);
	POLYBENCH_FREE_ARRAY(B_MEM);
	POLYBENCH_FREE_ARRAY(C);
	POLYBENCH_FREE_ARRAY(A);
	POLYBENCH_FREE_ARRAY(B);

	return 0;
}
