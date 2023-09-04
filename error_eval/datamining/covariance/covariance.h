/**
 * This version is stamped on May 10, 2016
 *
 * Contact:
 *   Louis-Noel Pouchet <pouchet.ohio-state.edu>
 *   Tomofumi Yuki <tomofumi.yuki.fr>
 *
 * Web address: http://polybench.sourceforge.net
 */
#ifndef _COVARIANCE_H
# define _COVARIANCE_H

/* Default to LARGE_DATASET. */
# if !defined(MINI_DATASET) && !defined(SMALL_DATASET) && !defined(MEDIUM_DATASET) && !defined(LARGE_DATASET) && !defined(EXTRALARGE_DATASET)
#  define LARGE_DATASET
# endif

# if !defined(M) && !defined(N)
/* Define sample dataset sizes. */
#  ifdef MINI_DATASET
#   define M 28
#   define N 32
#  endif

#  ifdef SMALL_DATASET
#   define M 80
#   define N 100
#  endif

#  ifdef MEDIUM_DATASET
#   define M 240
#   define N 260
#  endif

#  ifdef LARGE_DATASET
#   define M 1200
#   define N 1400
#  endif

#  ifdef EXTRALARGE_DATASET
#   define M 2600
#   define N 3000
#  endif


#endif /* !(M N) */

# define _PB_M POLYBENCH_LOOP_BOUND(M,m)
# define _PB_N POLYBENCH_LOOP_BOUND(N,n)


/* Default data type */
# if !defined(DATA_TYPE_IS_INT) && !defined(DATA_TYPE_IS_FLOAT) && !defined(DATA_TYPE_IS_DOUBLE) && !defined(DATA_TYPE_IS_LONGDOUBLE) && !defined(DATA_TYPE_IS_POSIT32) && !defined(DATA_TYPE_IS_POSIT64)
#  define DATA_TYPE_IS_DOUBLE
# endif

#if defined(DATA_TYPE_IS_POSIT32) || defined(DATA_TYPE_IS_POSIT64) || defined(POSIT_MEM)
/* Include universal numbers library. */
#include <universal/number/posit/posit.hpp>
#  define DATA_TYPE_IS_POSIT
#endif

#ifdef DATA_TYPE_IS_INT
#  define DATA_TYPE int
#  define DATA_PRINTF_MODIFIER "%d "
#endif

#ifdef DATA_TYPE_IS_FLOAT
#  define DATA_TYPE float
#  define DATA_PRINTF_MODIFIER "%0.9f "
#  define SCALAR_VAL(x) x##f
#  define SQRT_FUN(x) sqrtf(x)
#  define EXP_FUN(x) expf(x)
#  define POW_FUN(x,y) powf(x,y)
# endif

#ifdef DATA_TYPE_IS_DOUBLE
#  define DATA_TYPE double
#  define DATA_PRINTF_MODIFIER "%0.17lf "
#  define SCALAR_VAL(x) x
#  define SQRT_FUN(x) sqrt(x)
#  define EXP_FUN(x) exp(x)
#  define POW_FUN(x,y) pow(x,y)
# endif

#ifdef DATA_TYPE_IS_LONGDOUBLE
#  define DATA_TYPE long double
#  define DATA_PRINTF_MODIFIER "%0.21Lf "
#  define SCALAR_VAL(x) x##L
#  define SQRT_FUN(x) sqrt(x)
#  define EXP_FUN(x) exp(x)
#  define POW_FUN(x, y) pow(x, y)
#endif

#ifdef DATA_TYPE_IS_POSIT32
using Posit32 = sw::universal::posit<32, 2>;
#  define DATA_TYPE Posit32
// # define DATA_PRINTF_MODIFIER "%0.9lf "
#  define SCALAR_VAL(x) x
#  define SQRT_FUN(x) sqrt(x)
#  define EXP_FUN(x) exp(x)
#  define POW_FUN(x, y) pow(x, y)
#endif

#ifdef DATA_TYPE_IS_POSIT64
using Posit64 = sw::universal::posit<64, 2>;
#  define DATA_TYPE Posit64
// # define DATA_PRINTF_MODIFIER "%0.17lf "
#  define SCALAR_VAL(x) x
#  define SQRT_FUN(x) sqrt(x)
#  define EXP_FUN(x) exp(x)
#  define POW_FUN(x, y) pow(x, y)
#endif

#ifdef POSIT_MEM
using Posit32 = sw::universal::posit<32, 2>;
#  define MEM_TYPE Posit32
#else
#  define MEM_TYPE DATA_TYPE
#endif

#endif /* !_COVARIANCE_H */
