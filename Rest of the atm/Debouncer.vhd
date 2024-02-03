----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/27/2023 08:32:57 PM
-- Design Name: 
-- Module Name: Debouncer - Behavioral
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

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Debouncer is
    Port ( clk : in STD_LOGIC;
           btn : in STD_LOGIC;
           debounced_btn : out STD_LOGIC);
end Debouncer;

architecture Behavioral of Debouncer is
    
    component Debouncer_clock_divider is
      Port (clk : in std_logic;
        clk_output : out std_logic );
    end component;
    signal d1, d2, d3 : STD_LOGIC;

     signal clk_output : std_logic; 
begin
    
    Clock_divider1 : Debouncer_clock_divider port map(clk => clk, clk_output => clk_output);
    
    
    process(clk_output)
    begin
        if rising_edge(clk_output) then
            d1 <= btn;
            d2 <= d1;
            d3 <= d2;
        end if;
    end process;

    debounced_btn <= d1 and d2 and d3;

end Behavioral;
