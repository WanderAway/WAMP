#include "util.h"

FILE* asm_in;
FILE* bin_out; 
unsigned int write_count = 0;

int write_inst(const instruction* inst)
{
  u8 n;
  n = fwrite(inst, 2, 1, bin_out);
  
  if (n == 1) 
  {
    write_count += 2;
    return SUCCESS;
  }
  else 
    return FAIL;
}
