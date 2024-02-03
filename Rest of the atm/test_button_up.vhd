----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/07/2023 04:04:32 PM
-- Design Name: 
-- Module Name: test_button_up - Behavioral
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

entity test_button_up is
      Port ( button_up : in std_logic;
             output : out std_logic_vector (3 downto 0)
             );
end test_button_up;

architecture Behavioral of test_button_up is
signal count : unsigned(3 downto 0) := "0000";

begin
    
    process(button_up)
        begin
            if rising_edge(button_up) then
            count <= count + 1;
            end if;
    end process;
    
    
   output <= std_logic_vector(count);
end Behavioral;
