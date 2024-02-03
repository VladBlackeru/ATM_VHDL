
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity Clock_divider_for_leds is
  Port ( clk : in std_logic;
        done : out std_logic );
end Clock_divider_for_leds;

architecture Behavioral of Clock_divider_for_leds is
signal count: unsigned(26 downto 0) := "000000000000000000000000000";
                                      --"101111101011110000100000000"

constant end_count_start : unsigned(26 downto 0) := "101111101011110000100000000";
constant end_count_end : unsigned(26 downto 0) :=   "101111111011110000100000111";


begin

    process(clk)
        begin
            
            if rising_edge(clk) then
                 count <= count + 1;
                
                    if count = end_count_end then
                        count <= "000000000000000000000000000";
                    end if;
           
            end if;
            
          
    end process; 
    
     process(count)
        begin
        if count > end_count_start  then
               done <= '1';
               else done <= '0';
            end if;
     end process;   

end Behavioral;
