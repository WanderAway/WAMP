# WAMP Assembler 
Converts assembly to binary containing machine code. 

### Notes: 
Instruction set still needs work on, to make lives easier, let's make all instructions into three characters, 
while the operands (registers, immediates, etc.) be ~~comma~~ space separated, and be listed from left to right:

`Destination Register` > `Source Register` > `Data Register` > `Immediate values`

Immediates shall be prefixed with a hash character `#`
