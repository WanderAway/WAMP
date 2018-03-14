library ieee; 
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity register_file is 
  generic (
    ARCH      : integer := 16;
    NUM_REGS  : integer := 16;
    SEL_WIDTH : integer := 3;
    PC_REG    : integer := 15
  )
  port (
    clk       : in std_logic;
    
    sel_in    : in std_logic_vector (SEL_WIDTH-1 downto 0);
    sel_out1  : in std_logic_vector (SEL_WIDTH-1 downto 0);
    sel_out2  : in std_logic_vector (SEL_WIDTH-1 downto 0);
    
    d_in      : in std_logic_vector (ARCH-1 downto 0);
    d_out1    : out std_logic_vector (ARCH-1 downto 0);
    d_out2    : out std_logic_vector (ARCH-1 downto 0);
    
    wren      : in std_logic -- write enable for input register 
  );
end register_file;

package register_file_pkg is 
component register_file is 
  generic (
    ARCH      : integer := 16;
    NUM_REGS  : integer := 16;
    SEL_WIDTH : integer := 3;
    PC_REG    : integer := 15
  )
  port (
    clk       : in std_logic;
    
    sel_in    : in std_logic_vector (SEL_WIDTH-1 downto 0);
    sel_out1  : in std_logic_vector (SEL_WIDTH-1 downto 0);
    sel_out2  : in std_logic_vector (SEL_WIDTH-1 downto 0);
    
    d_in      : in std_logic_vector (ARCH-1 downto 0);
    d_out1    : out std_logic_vector (ARCH-1 downto 0);
    d_out2    : out std_logic_vector (ARCH-1 downto 0);
    
    wren      : in std_logic := '0'     -- write enable for input register 
  );
end component;
end;


---------------------------------------------------------------------
-- architecture 
---------------------------------------------------------------------
architecture rtl of register_file is 

signal registers : array (0 to NUM_REGS-1) of std_logic_vector(ARCH-1 downto 0) := (others=> (others => '0'));

begin 

  reg_write : process (clk) 
  begin
  if rising_edge(clk) then 
    if wren = '1' then  -- need to watch for setup/hold time here, wren need to be glitch free, 
      registers(to_integer(unsigned(sel_in))) <= d_in;
    end if;
    
    -- increment PC by number of bytes per per instruction 
    registers(PC_REG) <= registers(PC_REG) + ARCH/8;
  end if;
  end process reg_write; 
  -- now that I think about it, pipelining this might actually make some parts easier, 
  -- but I'm sure it'll make life miserable at some point down the line...
  
  -- combinational for fastest response 
  d_out1 <= registers(to_integer(unsigned(sel_out1)));
  d_out2 <= registers(to_integer(unsigned(sel_out2)));
  
end rtl;