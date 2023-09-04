#include <polybench.h>
#include "gemm.hpp"

#define PROCESS_IN(x) x
#define PROCESS_OUT(x) x


void main_kernel(int ni, int nj, int nk,
            DATA_TYPE alpha,
            DATA_TYPE beta,
            DATA_TYPE POLYBENCH_2D(C, NI, NJ, ni, nj),
            DATA_TYPE POLYBENCH_2D(A, NI, NK, ni, nk),
            DATA_TYPE POLYBENCH_2D(B, NK, NJ, nk, nj))
{
    /***** Create local copies of the arrays pointed by the input pointers ****/
    DATA_TYPE alpha_local = PROCESS_IN(alpha);
    DATA_TYPE beta_local = PROCESS_IN(beta);

    DATA_TYPE C_local[NI][NJ];
    DATA_TYPE A_local[NI][NK];
    DATA_TYPE B_local[NK][NJ];
    for (int i = 0; i < _PB_NI; i++)
    {
        for (int j = 0; j < _PB_NJ; j++)
            C_local[i][j] = PROCESS_IN(C[i][j]);
    }
    for (int i = 0; i < _PB_NI; i++)
    {
        for (int k = 0; k < _PB_NK; k++)
            A_local[i][k] = PROCESS_IN(A[i][k]);
    }
    for (int k = 0; k < _PB_NK; k++)
    {
        for (int j = 0; j < _PB_NJ; j++)
            B_local[k][j] = PROCESS_IN(B[k][j]);
    }
    /**************************************************************************/

    /* Run kernel. */
    kernel_gemm(ni, nj, nk,
                alpha_local, beta_local,
                (C_local),
                (A_local),
                (B_local));

//     int i, j, k;

// // BLAS PARAMS
// // TRANSA = 'N'
// // TRANSB = 'N'
// //  => Form C := alpha*A*B + beta*C,
// // A is NIxNK
// // B is NKxNJ
// // C is NIxNJ
// #pragma scop
//     for (i = 0; i < _PB_NI; i++)
//     {
//         for (j = 0; j < _PB_NJ; j++)
//             C_local[i][j] *= beta_local;
//         for (k = 0; k < _PB_NK; k++)
//         {
//             for (j = 0; j < _PB_NJ; j++)
//                 C_local[i][j] += alpha_local * A_local[i][k] * B_local[k][j];
//         }
//     }
// #pragma endscop

    /**************** Asign output pointer to the local array *****************/
    for (int i = 0; i < _PB_NI; i++)
    {
        for (int j = 0; j < _PB_NJ; j++)
            C[i][j] = PROCESS_OUT(C_local[i][j]);
    }
    /**************************************************************************/

}
