# Register File 
As of right now, in an attempt to complete an instruction in a single clock cycle, I've made everything except for the writing of the register into combinational logic. 
Pipelining is making more sense at this point but I'm sure that's way more complicated than I'm currently thinking so I'll just stick with this for now. 


# Generics: 

| Generic Name | Description | 
|:------------:|:-----------:|
| `ARCH`       | data width  | 
| `NUM_REGS`   | number of registers | 
| `SEL_WIDTH`  | number of select signal bits, should be log2(NUM_REGS) |
| `PC_REG`     | which register is for program counter |

# Signals: 

| Signal Name | Direction | Description | 
|:-----------:|:---------:|:-----------:|
| `clk`       | in        | clock signal|
| `rst`       | in        | reset signal, resets register contents to 0 |
| `sel_in`    | in        | register mux selects, used for input and writing |
| `sel_out1`  | in        | register select for d_out1 | 
| `sel_out2`  | in        | register select for d_out2 |
| `d_in`      | in        | data to be written to register |
| `d_out1`    | out       | data from the register selected | 
| `d_out2`    | out       | data from the second selected register | 
| `wren`      | in        | when asserted, `reg(sel_in)` will be written with `d_in`|
