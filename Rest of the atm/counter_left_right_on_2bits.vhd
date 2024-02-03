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

entity counter_left_right_on_2bits is
      Port (   button_up, button_down, reset : in std_logic;
              digit_2bits : out std_logic_vector(1 downto 0)
      );
end counter_left_right_on_2bits;

architecture Behavioral of counter_left_right_on_2bits is
    signal count : unsigned(1 downto 0) := "00";
    signal clk : std_logic;
begin
    clk <= button_up or button_down;
    
    process(clk,reset)
        begin
        if ( reset = '1' )then
            count <= "00";
        else 
            if(rising_edge(clk))then
                if(button_up ='1')then
                    count <= count + 1;
                elsif(button_down ='1')then
                    count <= count - 1;
                end if;
            end if;
        end if;
    end process;

digit_2bits <= std_logic_vector(count);

end Behavioral;