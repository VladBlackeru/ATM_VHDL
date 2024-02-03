library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity counter_right_on_2_bits is
      Port (  clock_r, reset,PL : in std_logic;
              number_in: in std_logic_vector(1 downto 0);
              digit : out std_logic_vector(1 downto 0)
      );
end counter_right_on_2_bits;

architecture Behavioral of counter_right_on_2_bits is
    signal count : unsigned(1 downto 0) := unsigned(number_in);
    
begin
        process(clock_r, reset, PL)
        begin
        if(PL ='1')then
            count <= unsigned(number_in);
        else 
        if(reset ='1')then
            count<="00";
         else
            if(rising_edge(clock_r))then
                count <= count + 1;
            end if;
         end if;
         end if;
        end process;
        digit <= std_logic_vector(count);
 
    
end Behavioral;
