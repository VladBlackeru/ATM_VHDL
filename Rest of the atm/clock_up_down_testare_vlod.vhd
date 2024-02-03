library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity clock_up_down_testare_vlod is
  Port ( 
        button_down, button_up : in std_logic;
        clk_out, up: out std_logic
  );
end clock_up_down_testare_vlod;

architecture Behavioral of clock_up_down_testare_vlod is
signal clk: std_logic;

begin
clk <= button_down or button_up;

process(button_down, button_up)
begin
    if(button_up = '1')then
        up <= '1';
    else
        up <= '0';
    end if;
end process;
clk_out <= clk;
end Behavioral;