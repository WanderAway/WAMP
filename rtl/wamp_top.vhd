library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.register_file_pkg.all;

entity wamp_top is 
  generic 
  (
    ARCH    : integer := 16;   -- 16 bit processor
    NUM_IO  : integer := 16;   -- kinda arbitrary
    NUM_REGS: integer := 16;
    REG_SEL : integer := 4;    -- selector width for register file 
    PC_REG  : integer := 15;   -- register number of program counter
  
  );
  port 
  ( -- will probably add more in the future 
    clk     : in std_logic; 
    reset   : in std_logic; 
    io      : inout std_logic_vector(NUM_IO-1 downto 0); 
    
  -- UART signals 
    txd     : out std_logic;
    rxd     : in std_logic; 
    prog    : in std_logic    -- program pin to write to the block ram through uart bootloader
  )
end entity wamp_top; 

architecture rtl of wamp_top is 
begin 
  
  
end rtl;
