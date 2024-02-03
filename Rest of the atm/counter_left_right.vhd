----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/02/2023 07:49:30 PM
-- Design Name: 
-- Module Name: counter_left_right - Behavioral
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

entity counter_left_right is
      Port (  reset, button_left, button_right : in std_logic;
              afisor_select : out std_logic_vector(1 downto 0)
      );
end counter_left_right;

architecture Behavioral of counter_left_right is
    signal count : unsigned(1 downto 0) := "00";
    signal clk: std_logic;
    
begin
    clk <= button_left or button_right;
    
    process(reset, clk,button_left, button_right)
    begin
        if ( reset = '1' ) then count <= "00";
        elsif( rising_edge(clk))then
            if(button_left = '1')then
                count <= count - 1;
            elsif(button_right = '1')then
                count <= count + 1;
 
            end if;
        end if;
    end process;
    
afisor_select <= std_logic_vector(count);

end Behavioral;
