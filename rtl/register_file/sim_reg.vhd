library ieee;
use ieee.std_logic_1164.all;
use work.register_file_pkg.all;

entity sim is 
end sim;

architecture tb of sim is 
  signal sel_in, sel_out1, sel_out2 : std_logic_vector(3 downto 0) := (others => '0');
  signal d_in, d_out1, d_out2 : std_logic_vector(15 downto 0) := (others => '0');
  signal wren : std_logic := '0';
  signal clk, rst : std_logic := '0';
begin 
  
  reg_inst : register_file 
  port map (
    clk => clk, 
    rst => rst,
    sel_in => sel_in , 
    sel_out1 => sel_out1, 
    sel_out2 => sel_out2, 
    d_in => d_in, 
    d_out1 => d_out1, 
    d_out2 => d_out2, 
    wren => wren
  );
  
  
  clk_process : process 
  begin 
    clk <= not clk; 
    wait for 5 ns;
  end process clk_process;

  input_process : process 
  begin
    rst <= '1';
    
    wait for 30 ns; 
    rst <= '0';
    sel_in <= "0100";
    sel_out1 <= "0001";
    sel_out2 <= "0010"; 
    d_in <= x"DEAD";
    
    wait for 20 ns;
    wren <= '1';
    wait for 10 ns;
    wren <= '0';
    sel_out1 <="0100";
    sel_in <= "0010";
    d_in <= x"BEEF";
    
    wait for 20 ns;
    wren <= '1';
    wait for 10 ns;
    wren <= '0';
    
    wait for 100 ms;
    
  end process input_process;
  
end tb;
