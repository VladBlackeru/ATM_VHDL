----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/27/2023 08:34:57 PM
-- Design Name: 
-- Module Name: Debouncer_clock_divider - Behavioral
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

entity Debouncer_clock_divider is
  Port (clk : in std_logic;
        clk_output : out std_logic );
end Debouncer_clock_divider;
    
 
   
architecture Behavioral of Debouncer_clock_divider is
    
begin
    process(clk)
    variable count : natural := 0 ;
        begin
          if ( clk'event and clk ='1') then
            if ( count = 65535 ) then
                count := 0;
                clk_output <= '0';
             elsif ( count < 32768 ) then 
            count := count + 1;
            clk_output <= '0';
            elsif ( count > 32767) then
            count := count + 1;
            clk_output <= '1';
            end if;
          end if;
    end process;

end Behavioral;
