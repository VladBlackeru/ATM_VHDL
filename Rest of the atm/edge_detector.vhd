library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity edge_detector is
port (
  i_clk                       : in  std_logic;
  i_input                     : in  std_logic;
  o_pulse                     : out std_logic);
end edge_detector;
architecture rtl of edge_detector is
signal r0_input                           : std_logic;
signal r1_input                           : std_logic;
begin
p_rising_edge_detector : process(i_clk)
begin
 if(rising_edge(i_clk)) then
    r0_input           <= i_input;
    r1_input           <= r0_input;
  end if;
end process p_rising_edge_detector;
o_pulse            <= not r1_input and r0_input;
end rtl;