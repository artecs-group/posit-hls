/**
 * This version is stamped on May 10, 2016
 *
 * Contact:
 *   Louis-Noel Pouchet <pouchet.ohio-state.edu>
 *   Tomofumi Yuki <tomofumi.yuki.fr>
 *
 * Web address: http://polybench.sourceforge.net
 */
/* 3mm.c: this file is part of PolyBench/C */

#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include <math.h>

/* Include polybench common header. */
#include <polybench.h>

/* Include benchmark-specific header. */
#include "3mm.h"


/* Array initialization. */
static
void init_array(int ni, int nj, int nk, int nl, int nm,
		MEM_TYPE POLYBENCH_2D(A_MEM,NI,NK,ni,nk),
		MEM_TYPE POLYBENCH_2D(B_MEM,NK,NJ,nk,nj),
		MEM_TYPE POLYBENCH_2D(C_MEM,NJ,NM,nj,nm),
		MEM_TYPE POLYBENCH_2D(D_MEM,NM,NL,nm,nl),
		DATA_TYPE POLYBENCH_2D(A,NI,NK,ni,nk),
		DATA_TYPE POLYBENCH_2D(B,NK,NJ,nk,nj),
		DATA_TYPE POLYBENCH_2D(C,NJ,NM,nj,nm),
		DATA_TYPE POLYBENCH_2D(D,NM,NL,nm,nl))
{
  int i, j;

  for (i = 0; i < ni; i++)
    for (j = 0; j < nk; j++)
    {
      A_MEM[i][j] = (MEM_TYPE) ((i*j+1) % ni) / (5*ni);
      A[i][j] = (DATA_TYPE) (A_MEM[i][j]);
    }
  for (i = 0; i < nk; i++)
    for (j = 0; j < nj; j++)
    {
      B_MEM[i][j] = (MEM_TYPE) ((i*(j+1)+2) % nj) / (5*nj);
      B[i][j] = (DATA_TYPE) (B_MEM[i][j]);
    }
  for (i = 0; i < nj; i++)
    for (j = 0; j < nm; j++)
    {
      C_MEM[i][j] = (MEM_TYPE) (i*(j+3) % nl) / (5*nl);
      C[i][j] = (DATA_TYPE) (C_MEM[i][j]);
    }
  for (i = 0; i < nm; i++)
    for (j = 0; j < nl; j++)
    {
      D_MEM[i][j] = (MEM_TYPE) ((i*(j+2)+2) % nk) / (5*nk);
      D[i][j] = (DATA_TYPE) (D_MEM[i][j]);
    }
}


/* DCE code. Must scan the entire live-out data.
   Can be used also to check the correctness of the output. */
static
void print_array(int ni, int nl,
		 MEM_TYPE POLYBENCH_2D(G_MEM,NI,NL,ni,nl))
{
  int i, j;

  POLYBENCH_DUMP_START;
  POLYBENCH_DUMP_BEGIN("G");
  for (i = 0; i < ni; i++)
    for (j = 0; j < nl; j++) {
	if ((i * ni + j) % 20 == 0) fprintf (POLYBENCH_DUMP_TARGET, "\n");
#ifdef DATA_TYPE_IS_POSIT
  std::cout << hex_format(G_MEM[i][j]) << " ";
#else
	fprintf (POLYBENCH_DUMP_TARGET, DATA_PRINTF_MODIFIER, G_MEM[i][j]);
#endif
    }
  POLYBENCH_DUMP_END("G");
  POLYBENCH_DUMP_FINISH;
}


/* Main computational kernel. The whole function will be timed,
   including the call and return. */
static
void kernel_3mm(int ni, int nj, int nk, int nl, int nm,
		DATA_TYPE POLYBENCH_2D(E,NI,NJ,ni,nj),
		DATA_TYPE POLYBENCH_2D(A,NI,NK,ni,nk),
		DATA_TYPE POLYBENCH_2D(B,NK,NJ,nk,nj),
		DATA_TYPE POLYBENCH_2D(F,NJ,NL,nj,nl),
		DATA_TYPE POLYBENCH_2D(C,NJ,NM,nj,nm),
		DATA_TYPE POLYBENCH_2D(D,NM,NL,nm,nl),
		DATA_TYPE POLYBENCH_2D(G,NI,NL,ni,nl))
{
  int i, j, k;

#pragma scop
  /* E := A*B */
  for (i = 0; i < _PB_NI; i++)
    for (j = 0; j < _PB_NJ; j++)
      {
	E[i][j] = SCALAR_VAL(0.0);
	for (k = 0; k < _PB_NK; ++k)
	  E[i][j] += A[i][k] * B[k][j];
      }
  /* F := C*D */
  for (i = 0; i < _PB_NJ; i++)
    for (j = 0; j < _PB_NL; j++)
      {
	F[i][j] = SCALAR_VAL(0.0);
	for (k = 0; k < _PB_NM; ++k)
	  F[i][j] += C[i][k] * D[k][j];
      }
  /* G := E*F */
  for (i = 0; i < _PB_NI; i++)
    for (j = 0; j < _PB_NL; j++)
      {
	G[i][j] = SCALAR_VAL(0.0);
	for (k = 0; k < _PB_NJ; ++k)
	  G[i][j] += E[i][k] * F[k][j];
      }
#pragma endscop

}


int main(int argc, char** argv)
{
  /* Retrieve problem size. */
  int ni = NI;
  int nj = NJ;
  int nk = NK;
  int nl = NL;
  int nm = NM;

  /* Variable declaration/allocation. */
  POLYBENCH_2D_ARRAY_DECL(A_MEM, MEM_TYPE, NI, NK, ni, nk);
  POLYBENCH_2D_ARRAY_DECL(B_MEM, MEM_TYPE, NK, NJ, nk, nj);
  POLYBENCH_2D_ARRAY_DECL(C_MEM, MEM_TYPE, NJ, NM, nj, nm);
  POLYBENCH_2D_ARRAY_DECL(D_MEM, MEM_TYPE, NM, NL, nm, nl);
  POLYBENCH_2D_ARRAY_DECL(G_MEM, MEM_TYPE, NI, NL, ni, nl);
  POLYBENCH_2D_ARRAY_DECL(E, DATA_TYPE, NI, NJ, ni, nj);
  POLYBENCH_2D_ARRAY_DECL(A, DATA_TYPE, NI, NK, ni, nk);
  POLYBENCH_2D_ARRAY_DECL(B, DATA_TYPE, NK, NJ, nk, nj);
  POLYBENCH_2D_ARRAY_DECL(F, DATA_TYPE, NJ, NL, nj, nl);
  POLYBENCH_2D_ARRAY_DECL(C, DATA_TYPE, NJ, NM, nj, nm);
  POLYBENCH_2D_ARRAY_DECL(D, DATA_TYPE, NM, NL, nm, nl);
  POLYBENCH_2D_ARRAY_DECL(G, DATA_TYPE, NI, NL, ni, nl);

  /* Initialize array(s). */
  init_array (ni, nj, nk, nl, nm,
	      POLYBENCH_ARRAY(A_MEM),
	      POLYBENCH_ARRAY(B_MEM),
	      POLYBENCH_ARRAY(C_MEM),
	      POLYBENCH_ARRAY(D_MEM),
	      POLYBENCH_ARRAY(A),
	      POLYBENCH_ARRAY(B),
	      POLYBENCH_ARRAY(C),
	      POLYBENCH_ARRAY(D));

  /* Start timer. */
  polybench_start_instruments;

  /* Run kernel. */
  kernel_3mm (ni, nj, nk, nl, nm,
	      POLYBENCH_ARRAY(E),
	      POLYBENCH_ARRAY(A),
	      POLYBENCH_ARRAY(B),
	      POLYBENCH_ARRAY(F),
	      POLYBENCH_ARRAY(C),
	      POLYBENCH_ARRAY(D),
	      POLYBENCH_ARRAY(G));

  /* Stop and print timer. */
  polybench_stop_instruments;
  polybench_print_instruments;

  /* Prevent dead-code elimination. All live-out data must be printed
     by the function call in argument. */
	/* Convert result to original format */
	for (int i = 0; i < ni; i++)
		for (int j = 0; j < nl; j++)
		{
			(POLYBENCH_ARRAY(G_MEM))[i][j] = (MEM_TYPE)((POLYBENCH_ARRAY(G))[i][j]);
		}
  polybench_prevent_dce(print_array(ni, nl,  POLYBENCH_ARRAY(G_MEM)));

  /* Be clean. */
  POLYBENCH_FREE_ARRAY(A_MEM);
  POLYBENCH_FREE_ARRAY(B_MEM);
  POLYBENCH_FREE_ARRAY(C_MEM);
  POLYBENCH_FREE_ARRAY(D_MEM);
  POLYBENCH_FREE_ARRAY(G_MEM);
  POLYBENCH_FREE_ARRAY(E);
  POLYBENCH_FREE_ARRAY(A);
  POLYBENCH_FREE_ARRAY(B);
  POLYBENCH_FREE_ARRAY(F);
  POLYBENCH_FREE_ARRAY(C);
  POLYBENCH_FREE_ARRAY(D);
  POLYBENCH_FREE_ARRAY(G);

  return 0;
}
