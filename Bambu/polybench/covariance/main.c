#include <polybench.h>
#include "covariance.c"

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

void main_kernel(int m, int n,
		       MEM_TYPE POLYBENCH_2D(data,N,M,n,m),
		       MEM_TYPE POLYBENCH_2D(cov,M,M,m,m))
{
    /**************** Convert input from posit to float format ****************/
    /***** Create local copies of the arrays pointed by the input pointers ****/
    DATA_TYPE float_n_local = PROCESS_IN((DATA_TYPE)N);
    DATA_TYPE data_local[N][M];
    DATA_TYPE cov_local[M][M];
    DATA_TYPE mean_local[M];
    for (int i = 0; i < _PB_N; i++)
        for (int j = 0; j < _PB_M; j++)
            data_local[i][j] = PROCESS_IN(data[i][j]);
    /**************************************************************************/

    /* Run kernel. */
    kernel_covariance (m, n, float_n_local,
                    (data_local),
                    (cov_local),
                    (mean_local));

    /*************** Convert output from float to posit format ****************/
    /**************** Asign output pointer to the local array *****************/
    for (int i = 0; i < _PB_M; i++)
        for (int j = 0; j < _PB_M; j++)
            cov[i][j] = PROCESS_OUT(cov_local[i][j]);
    /**************************************************************************/
}
