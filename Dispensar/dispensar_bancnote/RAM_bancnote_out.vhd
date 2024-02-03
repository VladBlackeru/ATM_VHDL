----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/30/2023 08:51:50 PM
-- Design Name: 
-- Module Name: RAM_bancnote_out - Behavioral
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity RAM_bancnote_out is
  Port ( 
        we: in std_logic;
        ban100, ban50, ban10, ban5: in std_logic_vector(3 downto 0);
        banc100_out, banc50_out, banc10_out, banc5_out: out std_logic_vector(3 downto 0)
  );
end RAM_bancnote_out;

architecture Behavioral of RAM_bancnote_out is
signal b100,b50,b10,b5: std_logic_vector(3 downto 0):= "0000";

begin
process(we)
begin
if(rising_edge(we))then
    b100 <= ban100;
    b50 <= ban50;
    b10 <= ban10;
    b5 <= ban5;
end if;
end process;
banc100_out <= b100;
banc50_out <= b50;
banc10_out <= b10;
banc5_out <= b5;
end Behavioral;
