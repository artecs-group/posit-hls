#include <polybench.h>
#include "3mm.c"

#ifndef POSIT_MEM
#define PROCESS_IN(x) x
#define PROCESS_OUT(x) x
#define MEM_TYPE DATA_TYPE
#else
#include "posit2float.h"
#include "float2posit.h"
#define PROCESS_IN(x) posit2float(x)
#define PROCESS_OUT(x) float2posit(x)
#define MEM_TYPE float /* Emulates a 32-bit posit */
#endif

void main_kernel(int ni, int nj, int nk, int nl, int nm,
                 MEM_TYPE POLYBENCH_2D(A, NI, NK, ni, nk),
                 MEM_TYPE POLYBENCH_2D(B, NK, NJ, nk, nj),
                 MEM_TYPE POLYBENCH_2D(C, NJ, NM, nj, nm),
                 MEM_TYPE POLYBENCH_2D(D, NM, NL, nm, nl),
                 MEM_TYPE POLYBENCH_2D(G, NI, NL, ni, nl))
{
    /**************** Convert input from posit to float format ****************/
    /***** Create local copies of the arrays pointed by the input pointers ****/
    DATA_TYPE A_local[NI][NK];
    for (int i = 0; i < _PB_NI; i++)
    {
        for (int j = 0; j < _PB_NK; j++)
            A_local[i][j] = PROCESS_IN(A[i][j]);
    }
    DATA_TYPE B_local[NK][NJ];
    for (int i = 0; i < _PB_NK; i++)
    {
        for (int j = 0; j < _PB_NJ; j++)
            B_local[i][j] = PROCESS_IN(B[i][j]);
    }
    DATA_TYPE C_local[NJ][NM];
    for (int i = 0; i < _PB_NJ; i++)
    {
        for (int j = 0; j < _PB_NM; j++)
            C_local[i][j] = PROCESS_IN(C[i][j]);
    }
    DATA_TYPE D_local[NM][NL];
    for (int i = 0; i < _PB_NM; i++)
    {
        for (int j = 0; j < _PB_NL; j++)
            D_local[i][j] = PROCESS_IN(D[i][j]);
    }
    DATA_TYPE G_local[NI][NL];
    for (int i = 0; i < _PB_NI; i++)
    {
        for (int j = 0; j < _PB_NL; j++)
            G_local[i][j] = PROCESS_IN(G[i][j]);
    }
    DATA_TYPE E_local[NI][NJ];
    DATA_TYPE F_local[NJ][NL];
    /**************************************************************************/

    /* Run kernel. */
    kernel_3mm(ni, nj, nk, nl, nm,
               (E_local),
               (A_local),
               (B_local),
               (F_local),
               (C_local),
               (D_local),
               (G_local));

    /*************** Convert output from float to posit format ****************/
    /**************** Asign output pointer to the local array *****************/
    for (int i = 0; i < _PB_NI; i++)
    {
        for (int j = 0; j < _PB_NL; j++)
            G[i][j] = PROCESS_OUT(G_local[i][j]);
    }
    /**************************************************************************/
}
