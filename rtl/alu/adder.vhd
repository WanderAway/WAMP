-- I am aware I can just use numeric_std's addition operator
-- but what's the fun in that? 
-- Also - idea: since each bit gets XOR'ed in the addition process, why not 
--              combine adder with the xor operator? 


library ieee;
use ieee.std_logic_1164.all;

entity adder is 
  generic ( 
    ARCH    : integer := 16
  );
  port (
    op      : in std_logic; -- '1' for addition, 0 for xor
    in1     : in std_logic_vector (ARCH-1 downto 0);
    in2     : in std_logic_vector (ARCH-1 downto 0);
    result  : out std_logic_vector (ARCH-1 downto 0)
  );
  
end adder;


library ieee;
use ieee.std_logic_1164.all;

package adder_pkg is 
  component adder is 
    generic (
      ARCH    : integer := 16
    );
    port (
      op      : in std_logic; -- '1' for addition, 0 for xor
      in1     : in std_logic_vector (ARCH-1 downto 0);
      in2     : in std_logic_vector (ARCH-1 downto 0);
      result  : out std_logic_vector (ARCH-1 downto 0)
    );
  end component adder; 
end package adder_pkg;


-- I guess this isn't really RTL since it's all combinational but.... meh
architecture rtl of adder is 
  signal sum  : std_logic_vector (ARCH-1 downto 0);
  signal carry : std_logic_vector (ARCH-2 downto 0) := (others => '0');
  
begin 
  sum(ARCH-1 downto 1) <= in1(ARCH-1 downto 1) xor in2(ARCH-1 downto 1) xor carry; 
  
-- Carry LookAhead (CLA) block 
  carry <= (others => '0') when op = '0' else 
           (others => '1'); -- TODO 
  
  
  result <= sum; 
end;
