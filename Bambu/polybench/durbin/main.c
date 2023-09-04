#include <polybench.h>
#include "durbin.c"

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
                MEM_TYPE POLYBENCH_1D(r,N,n),
                MEM_TYPE POLYBENCH_1D(y,N,n))
{
    /**************** Convert input from posit to float format ****************/
    /***** Create local copies of the arrays pointed by the input pointers ****/
    DATA_TYPE r_local[N];
    DATA_TYPE y_local[N];
    for (int i = 0; i < _PB_N; i++)
        r_local[i] = PROCESS_IN(r[i]);
    /**************************************************************************/

    /* Run kernel. */
    kernel_durbin (n,
            (r_local),
            (y_local));

    /*************** Convert output from float to posit format ****************/
    /**************** Asign output pointer to the local array *****************/
    for (int i = 0; i < _PB_N; i++)
        y[i] = PROCESS_OUT(y_local[i]);
    /**************************************************************************/
}
