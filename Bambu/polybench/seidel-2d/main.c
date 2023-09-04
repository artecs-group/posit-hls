#include <polybench.h>
#include "seidel-2d.c"

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

void main_kernel(int tsteps, int n,
                MEM_TYPE POLYBENCH_2D(A,N,N,n,n))
{
    /**************** Convert input from posit to float format ****************/
    /***** Create local copies of the arrays pointed by the input pointers ****/
    DATA_TYPE A_local[N][N];
    for (int i = 0; i < _PB_N; i++)
    {
        for (int j = 0; j < _PB_N; j++)
        {
            A_local[i][j] = PROCESS_IN(A[i][j]);
        }
    }
    /**************************************************************************/

    /* Run kernel. */
    kernel_seidel_2d (tsteps, n, (A_local));

    /*************** Convert output from float to posit format ****************/
    /**************** Asign output pointer to the local array *****************/
    for (int i = 0; i < _PB_N; i++)
    {
        for (int j = 0; j < _PB_N; j++)
        {
            A[i][j] = PROCESS_OUT(A_local[i][j]);
        }
    }
    /**************************************************************************/
}
