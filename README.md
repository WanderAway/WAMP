# "Wander Away's MicroProcessor"
This project is built purely out of personal interest. If for whatever reason you feel like using this processor... Go ahead I guess, as long as you cite where it came from. 

For simplicity's sake, it will be a 16 bit processor based on a VHDL implementation with no pipelining or caching. 

No floating point support, maybe there'll be a module connected to system bus later down the line. 

## TODO 
* ALU 
  * Adder
  
    Maybe a carry lookahead adder, will look into different types at some point. 
  * ~~Multiplier~~ No. I'll make a co-processor or something later down the line

  
* Processor control

  I guess everything else that's not the ALU or the peripherals 
  
* Wishbone bus controller 

  Wishbone is an open source hardware bus architecture that I discovered recently, and should be able to utilize to control everything. Either that or I just default to something more simplistic...
  
* Peripherals 
  * UART Controller 
  
  * UART Bootloader 
    Also design some protocol to write to the memory so that we can actually get some program in there. 
  
  * Memory Controller 
  
    I'm probably just going to be using the block memory within the FPGA's, but maybe I'll look into DDR... I've heard it's a nightmare.
    
  * IO Controller 
  
    This should be pretty trivial but hey, what's the point of a processor if you can't do anything with it 
  
* Assembler 
  
  Program to translate from some sort of assembly to machine code 

* Compiler (Who knows how long until this will become a thing) 
  
  Yeah uh... not a priority. 
  
## Registers 
Initial design, let's say we will arbitrarily have 16 registers, each 16 bits wide, including special purpose ones. 

| Register Number | Purpose | 
|:-:|:-:|
| 0-11 | General Purpose Registers (GPR) |
| 12 | Accumulator Register (AR) | 
| 13 | Instruction Register (IR) | 
| 14 | Stack Pointer (SP) | 
| 15 | Program Counter (PC) |

## Opcodes
`S` for source register

`T` for target register 

`D` for data register (for operations like addition) 
  
`A` for address 

`I` for immediate values? (Maybe immediates for 16 bits is too much, but let's see)

`R` for reserved (aka I don't care what goes there as of now)


| Op Codes | Instruction | Format | Description | 
|:--------:|:-----------:|:------:|:-:|
| `0000` | Load           | `0000TTTTIIIIIIII` | Loads data at AR+I to T |
| `0001` | Store          | `0001SSSSIIIIIIII` | Stores data in S to AR+I |
| `0010` | Move           | `0010RRRRTTTTSSSS` | Copies data in S to T |
| `0011` | Move Immediate | `0011TTTTIIIIIIII` | Moves Immediate data to T | 
| `0100` | Push           | `0100SSSSIIIIIIII` | Pushes data in S to SP+I, SP-- |
| `0101` | Pop            | `0101TTTTIIIIIIII` | Pops data from SP+I to T, SP++ | 
| `0110` | Jump           | `0110SSSSIIIIIIII` | Changes PC to S+I | 
| `0111` | Jump if True   | `0111SSSSIIIIIIII` | Changes PC to S+I if AR!=0, otherwise do nothing | 
| `1000` | Add            | `1000TTTTSSSSDDDD` | T=S+D | 
|~~`1001`~~| ~~Multiply~~       | ~~`1001TTTTSSSSDDDD`~~ | T=S*D | 
| `1010` | Bitwise Not    | `1010TTTTSSSSRRRR` | T=¬S  |
| `1011` | Bitwise And    | `1011TTTTSSSSDDDD` | T=S&D | 
| `1100` | Bitwise Or     | `1100TTTTSSSSDDDD` | T=S|D |
| `1101` | Bitwise Xor    | `1101TTTTSSSSDDDD` | T=S^D | 
| `1110` | Shift Left     | `1110SSSSIIIIDDDD` | AR=S<<I if I!=0 else or AR=S<<D | 
| `1111` | Shift Right    | `1111SSSSIIIIDDDD` | Same as above | 

## Assembler
`Rt`:=`Target Register`

`Rs`:=`Source Register`

`Rd`:=`Data Register`

`#Immediate<N>`:=`N bit number`

`[]`:=`Optional data`

| Instruction | Code |
|:-----------:|:------:|
| Load | `LDR Rt #Immediate<8>` |
| Store | `STR Rs #Immediate<8>` |
| Move | `MOV Rt Rs` |
| Move Immediate | `MOV Rt #Immediate<8>` |
| Push | `PSH Rs #Immediate<8>` |
| Pop | `POP Rt #Immediate<8>` |
| Jump | `JMP Rs #Immediate<8>` |
| Jump Conditional | `JMC Rs #Immediate<8>` |
| Add | `ADD Rt Rs Rd` |
| ~~Multiply~~ | ~~`MUL Rt Rs Rd`~~ |
| Bitwise Not | `NOT Rt Rs` |
| Bitwise And | `AND Rt Rs Rd` |
| Bitwise Or | `OR Rt Rs Rd` |
| Bitwise Xor | `XOR Rt Rs Rd` |
| Shift Left | `SHL Rs [Rd] [#Immediate<4>]` |
| Shift Right | `SHR Rs [Rd] [#Immediate<4>]` |


SUBJECT TO CHANGE
