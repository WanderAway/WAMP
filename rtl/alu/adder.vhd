-- I am aware I can just use numeric_std's addition operator
-- but what's the fun in that? 
-- Also - idea: since each bit gets XOR'ed in the addition process, why not 
--              combine adder with the xor operator? 

-- NOTE: In spite of having an generic declaring the architecture width, this 
--       implementation is only for 16 bits at the moment, due to problems with chain generation. 

library ieee;
use ieee.std_logic_1164.all;
use work.cla_4_pkg.all;

entity adder is 
  generic ( 
    ARCH    : integer := 16
  );
  port (
    op      : in std_logic_vector(1 downto 0); -- '00' for addition, '01' for xor, '10' for not
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
  signal carry : std_logic_vector (ARCH-1 downto 0) := (others => '0');
  signal pg : std_logic_vector (ARCH/4-1 downto 0) := (others => '0');
  signal gg : std_logic_vector (ARCH/4-1 downto 0) := (others => '0');
  signal cla : std_logic_vector (ARCH-1 downto 0) := (others => '0');
  signal cla1 : std_logic_vector (2 downto 0) := (others => '0');
  signal generator : std_logic_vector (ARCH-1 downto 0) := (others => '0');
  signal propagate : std_logic_vector (arch-1 downto 0) := (others => '0');
  signal invert : std_logic_vector (ARCH-1 downto 0) := (others => '1');
  
  constant ADD : std_logic_vector(1 downto 0) := "00"; 
  constant EXOR : std_logic_vector(1 downto 0) := "01"; 
  constant INV : std_logic_vector(1 downto 0) := "10"; 
  
begin 
  
-- Carry LookAhead (CLA) block 
  
  propagate <= in1 xor in2; 
  generator <= in1 and in2; 
  
  cla4_inst0 : cla_4 
    port map (
      cin => '0', 
      g => generator(3 downto 0), 
      p => propagate(3 downto 0),
      cout => cla(3 downto 0),
      gg => gg(0),
      pg => pg(0)
    );
  
  cla4_inst1 : cla_4 
    port map (
      cin => cla1(0); 
      g => generator(7 downto 4), 
      p => propagate(7 downto 4), 
      cout => cla(7 downto 4), 
      gg => gg(1), 
      pg => pg(1)
    );
  
  cla4_inst2 : cla_4 
    port map (
      cin => cla1(1); 
      g => generator(11 downto 8), 
      p => propagate(11 downto 8), 
      cout => cla(11 downto 8), 
      gg => gg(2), 
      pg => pg(2)
    );

  cla4_inst3 : cla_4 
    port map (
      cin => cla1(2); 
      g => generator(15 downto 12), 
      p => propagate(15 downto 12), 
      cout => cla(15 downto 12), 
      gg => gg(3), 
      pg => pg(3)
    );
    
  cla4_layer2 : cla_4 
    port map (
      cin => '0', 
      g => gg, 
      p => pg, 
      cout => cla1, 
      gg => open, 
      pg => open 
    );
  -- set carry to 0 if xor operation
  carry <= (others => '0') when op = EXOR else 
           cla; 

  -- set in2 to 1 if invert operation 
  result <= in1 xor invert when op = INV  else 
                          in1 xor in2 xor carry; 
end rtl; 
