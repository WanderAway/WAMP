#pragma once 

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>

#define u8 uint8_t 
#define u16 uint16_t

// return error codes 
#define SUCCESS                 0
#define FAIL                    1
#define UNEXPECTED_EXPRESSION   2

// opcodes 
#define ldr 0x0
#define str 0x1
// ...

typedef struct  
{
  u8 s1     : 4;
  u8 opcode : 4;
  union {
    u8 imm;
    struct {
      u8 data_reg : 4;
      u8 src_reg : 4;
    } reg;
  };
    
} instruction; 

typedef struct 
{
  char inst[3];
  u8 tgt_reg : 4;
  u8 src_reg : 4;
  u8 data_reg;
  u8 imm; 
} code; 

int write_inst(const instruction* inst);

int get_code(code* c);
