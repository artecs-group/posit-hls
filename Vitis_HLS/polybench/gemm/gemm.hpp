/* Include polybench common header. */
#include <polybench.h>

/* Include benchmark-specific header. */
#include "gemm.h"

/* Main computational kernel. The whole function will be timed,
   including the call and return. */
void kernel_gemm(int ni, int nj, int nk,
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
    first_loop: for (i = 0; i < _PB_NI; i++)
    {
        second_loop: for (j = 0; j < _PB_NJ; j++)
            C[i][j] = C[i][j] * beta;
        third_loop: for (k = 0; k < _PB_NK; k++)
        {
            four_loop: for (j = 0; j < _PB_NJ; j++)
            {
                C[i][j] = C[i][j] + DATA_TYPE(DATA_TYPE(alpha * A[i][k]) * B[k][j]);
            }
        }
    }
#pragma endscop
}

// #define NI 20
// #define NJ 25
// #define NK 30

// void kernel_gemm(int ni, int nj, int nk,
//                  float alpha,
//                  float beta,
//                  float C[NI][NJ],
//                  float A[NI][NJ],
//                  float B[NI][NJ])
// {
//     int i, j;
//     first_loop: for (i = 0; i < ni; i++)
//     {
//         second_loop: for (j = 0; j < nj; j++)
//         {
//             // C[i][j] *= beta;
//             C[i][j] = A[i][j] * B[i][j];
//         }
//     }

// }