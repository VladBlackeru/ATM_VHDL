

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use IEEE.NUMERIC_STD.ALL;


entity counter_up_down_on_4bits is
  Port (clk_in, button_up, button_down, reset : in std_logic;
        digit_output : out std_logic_vector (3 downto 0)
        );
end counter_up_down_on_4bits;

architecture Behavioral of counter_up_down_on_4bits is
signal count : unsigned (3 downto 0) := "0000";
signal clk : std_logic;


begin
    clk <= button_up_debounced or button_down_debounced;
    
    process(clk, button_up_debounced, button_down_debounced)
        begin
            if reset ='1' then count <= "0000";
            else
            if (clk'event and clk = '1') then
                if button_up_debounced = '1'  then count <= count + 1;
                    if count = "1001" then count <= "0000";
                    end if;
                elsif button_down_debounced = '1' then count <= count - 1;
                    if count = "0000" then count <= "1001";
                    end if;
                end if;        
            end if;
            end if;
    end process;    
 digit_output <= std_logic_vector(count);
end Behavioral;
