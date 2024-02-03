----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/28/2023 10:05:43 PM
-- Design Name: 
-- Module Name: wait_for_dispense_money - Behavioral
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

entity wait_for_dispense_money is
  Port ( 
    enable, clk: in std_logic;
    ok : out std_logic
  );
end wait_for_dispense_money;

architecture Behavioral of wait_for_dispense_money is
signal count : unsigned(9 downto 0):="0000000000";
begin
process
begin
if(enable = '0')then
    count <= "0000000000";
    ok <='0';
else
    if(rising_edge(clk))then
        if(count = 1000)then
            ok <='1';
        else
            count <= count + 1;
            ok <= '0';
        end if;
    end if;
end if;
end process;

end Behavioral;
