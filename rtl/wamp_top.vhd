library ieee;
use ieee.std_logic_1164.all;

entity wamp_top is 
  generic 
  (
    ARCH    : 16;   -- 16 bit processor
    NUM_IO  : 16;    -- kinda arbitrary
    NUM_REGS: 16
  );
  port 
  ( -- will add more in the future 
    clk     : in std_logic; 
    reset   : in std_logic; 
    io      : inout std_logic_vector(NUM_IO-1 downto 0)
  )
end entity wamp_top; 

architecture rtl of wamp_top is 

  -- registers 
  signal registers : array(0 to NUM_REGS-1) of std_logic_vector(ARCH-1 downto 0) := (others => (others => '0') );
  
begin 
  
  
end rtl;
