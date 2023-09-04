#ifndef _MY_MULT_H_
#define _MY_MULT_H_

#define VIVADO_BACKEND
#include <ap_int.h>
#include "hint.hpp"
#include "posit/conversions.ipp"

#define P_SIZE 32
#define WES 2

typedef PositEncoding<P_SIZE, WES, hint::VivadoWrapper> data_t;

#endif