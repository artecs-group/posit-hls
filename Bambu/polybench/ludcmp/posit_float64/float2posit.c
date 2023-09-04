#include "float2posit.h"

float float2posit(double val)
{
  // return (float)(val);
  unsigned long tmp = 0x80000000;
  if (val==0)
    return 0;
  else
    return ( *( float * ) &tmp);
}
