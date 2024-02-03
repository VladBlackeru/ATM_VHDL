----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/26/2023 09:28:31 PM
-- Design Name: 
-- Module Name: MUX4_1 - Behavioral
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

entity MUX8_1 is
      Port (SEL : in std_logic_vector(2 downto 0);
            a0 : in std_logic_vector(3 downto 0);
            a1 : in std_logic_vector(3 downto 0);
            a2 : in std_logic_vector(3 downto 0);
            a3 : in std_logic_vector(3 downto 0);
            a4 : in std_logic_vector(3 downto 0);
            a5 : in std_logic_vector(3 downto 0);
            a6 : in std_logic_vector(3 downto 0);
            a7 : in std_logic_vector(3 downto 0);
            output : out std_logic_vector(3 downto 0));
end MUX8_1;

architecture Behavioral of MUX8_1 is

begin
    
    process(sel,a0,a1,a2,a3,a4,a5,a6,a7)
        begin
        if ( sel = "000" ) then
        output <= a0;
        elsif ( sel = "001" ) then
        output <= a1;
        elsif ( sel = "010" ) then
        output <= a2;
        elsif ( sel = "011" ) then
        output <= a3;
        elsif ( sel = "100" ) then
        output <= a4;
        elsif ( sel = "101" ) then
        output <= a5;
        elsif ( sel = "110" ) then
        output <= a6;
        else 
        output <= a7;
        end if;
    end process;

end Behavioral;
