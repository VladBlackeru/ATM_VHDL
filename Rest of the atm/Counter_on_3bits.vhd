----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/27/2023 03:23:51 PM
-- Design Name: 
-- Module Name: Counter_on_3bits - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity counter_on_3bits is
  port (
    clk : in std_logic;
    reset : in std_logic;
    output_counter : out std_logic_vector(2 downto 0)
  );
end entity counter_on_3bits;

architecture behavioral of counter_on_3bits is
signal count : unsigned (2 downto 0) := "000";
begin
  process (clk, reset)
  begin
    if reset = '1' then
      count <= "000";
    elsif rising_edge(clk) then
      if count = 7 then
        count <= "000";
      else
        count <= count + 1;
      end if;
    end if;
  end process;
  
  output_counter <= std_logic_vector(count);
end architecture behavioral;

