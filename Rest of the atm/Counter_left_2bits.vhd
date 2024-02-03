

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use IEEE.NUMERIC_STD.ALL;

entity counter_left_on_2_bits is
      Port (  clock_l, reset,PL : in std_logic;
              number: in std_logic_vector(1 downto 0);
              digit : out std_logic_vector(1 downto 0)
      );
end counter_left_on_2_bits;

architecture Behavioral of counter_left_on_2_bits is
    signal count : unsigned(1 downto 0) := unsigned(number);
    
begin
        process(clock_l, reset, PL)
        begin
        if(PL ='1')then
            count <= unsigned(number);
        else 
        if(reset ='1')then
            count<="00";
         else
            if(rising_edge(clock_l))then
                count <= count - 1;
            end if;
         end if;
         end if;
        end process;
        digit <= std_logic_vector(count);
 
    
end Behavioral;
