#include "util.h"
extern FILE* bin_out; 

int main(int argc, char *argv[])
{
  instruction i;
  i.opcode = 0xA;
  i.s1 = 0x1;
  i.reg.src_reg = 0x2;
  i.reg.data_reg = 0x3; 
  
  bin_out = fopen("out.bin", "w");
  
  write_inst(&i);
  
  return 0;
}
