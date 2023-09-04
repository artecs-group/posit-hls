#include <polybench.h>
#include "fdtd-2d.hpp"

#define PROCESS_IN(x) x
#define PROCESS_OUT(x) x

void main_kernel(int tmax, int nx, int ny,
                DATA_TYPE POLYBENCH_2D(ex, NX, NY, nx, ny),
                DATA_TYPE POLYBENCH_2D(ey, NX, NY, nx, ny),
                DATA_TYPE POLYBENCH_2D(hz, NX, NY, nx, ny),
                DATA_TYPE POLYBENCH_1D(_fict_, TMAX, tmax))
{
    /***** Create local copies of the arrays pointed by the input pointers ****/
    DATA_TYPE ex_local[NX][NY];
    DATA_TYPE ey_local[NX][NY];
    DATA_TYPE hz_local[NX][NY];
    for (int i = 0; i < _PB_NX; i++)
    {
        for (int j = 0; j < _PB_NY; j++)
        {
            ex_local[i][j] = PROCESS_IN(ex[i][j]);
            ey_local[i][j] = PROCESS_IN(ey[i][j]);
            hz_local[i][j] = PROCESS_IN(hz[i][j]);
        }
    }
    DATA_TYPE _fict__local[TMAX];
    for (int t = 0; t < _PB_TMAX; t++)
        _fict__local[t] = PROCESS_IN(_fict_[t]);
    /**************************************************************************/

    /* Run kernel. */
    kernel_fdtd_2d(tmax, nx, ny,
                 (ex_local),
                 (ey_local),
                 (hz_local),
                 (_fict__local));

    /**************** Asign output pointer to the local array *****************/    
    for (int i = 0; i < _PB_NX; i++)
    {
        for (int j = 0; j < _PB_NY; j++)
        {
            ex[i][j] = PROCESS_OUT(ex_local[i][j]);
            ey[i][j] = PROCESS_OUT(ey_local[i][j]);
            hz[i][j] = PROCESS_OUT(hz_local[i][j]);
        }
    }
    /**************************************************************************/
}
