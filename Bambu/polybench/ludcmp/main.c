#include <polybench.h>
#include "ludcmp.c"

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

void main_kernel(int n,
		 MEM_TYPE POLYBENCH_2D(A,N,N,n,n),
		 MEM_TYPE POLYBENCH_1D(b,N,n),
		 MEM_TYPE POLYBENCH_1D(x,N,n),
		 MEM_TYPE POLYBENCH_1D(y,N,n))
{
    /**************** Convert input from posit to float format ****************/
    /***** Create local copies of the arrays pointed by the input pointers ****/
    DATA_TYPE A_local[N][N];
    DATA_TYPE b_local[N];
    DATA_TYPE x_local[N];
    DATA_TYPE y_local[N];
    for (int i = 0; i < _PB_N; i++)
    {
        b_local[i] = PROCESS_IN(b[i]);
        x_local[i] = PROCESS_IN(x[i]);
        y_local[i] = PROCESS_IN(y[i]);
        for (int j = 0; j < _PB_N; j++)
        {
            A_local[i][j] = PROCESS_IN(A[i][j]);
        }
    }
    /**************************************************************************/

    /* Run kernel. */
  kernel_ludcmp (n,
		 (A_local),
		 (b_local),
		 (x_local),
		 (y_local));

    /*************** Convert output from float to posit format ****************/
    /**************** Asign output pointer to the local array *****************/
    for (int i = 0; i < _PB_N; i++)
        x[i] = PROCESS_OUT(x_local[i]);
    /**************************************************************************/
}
