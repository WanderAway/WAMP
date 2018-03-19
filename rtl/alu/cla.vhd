-- Carry lookahead block 
library ieee;
use ieee.std_logic_1164.all;

entity cla_4 is 
  port(
    cin : in std_logic;
    g   : in std_logic_vector(3 downto 0);
    p   : in std_logic_vector(3 downto 0);
    pg  : out std_logic; -- used to chain different blocks together, could be pipelined 
    cout: out std_logic_vector(4 downto 0);
  );
end cla_4; 

library ieee;
use ieee.std_logic_1164.all; 

package cla_4_pkg is 
  component cla_4 is 
    port (
      cin : in std_logic;
      g   : in std_logic_vector(3 downto 0);
      p   : in std_logic_vector(3 downto 0);
      pg  : out std_logic;
      gg  : out std_logic;
      cout: out std_logic_vector(3 downto 0);
    );
  end component cla_4;
end package cla_4_pkg; 


architecture rtl of cla_4 is 
begin
  
  cout(0) <= cin;
  cout(1) <= g(0) or (p(0) and cin);
  cout(2) <= g(1) or (g(0) and p(1)) or (p(0) and p(1) and cin);
  cout(3) <= g(2) or (g(1) and p(2)) or (g(0) and p(1) and p(2)) or (cin and p(0) and p(1) and p(2));
  gg <= g(3) or (g(2) and p(3)) or (g(1) and p(2) and p(3)) or (g(0) and p(1) and p(2) and p(3)) or 
             (cin and p(0) and p(1) and p(2) and p(3));
  pg <= p(0) and p(1) and p(2) and p(3);
end rtl;
