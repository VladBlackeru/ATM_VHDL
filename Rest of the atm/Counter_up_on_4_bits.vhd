
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity counter_down_on_4_bits is
 Port (  clock_down, reset,PL : in std_logic;
              number_in: in std_logic_vector(3 downto 0);
              digit : out std_logic_vector(3 downto 0)
      );
end counter_down_on_4_bits;

architecture Behavioral of counter_down_on_4_bits is
signal count: unsigned(3 downto 0) := unsigned(number_in);
begin
    process(clock_down, reset, PL)
    begin
        if(PL ='1')then
            count <= unsigned(number_in);
        else
            if(reset ='1')then
                count <="0000";
             else
                if(rising_edge(clock_down))then
                    count <= count  - 1;
                    if(count = "0000")then
                        count <= "1001";
                    end if;
                end if;
             end if;
         end if;
    end process;
    digit <= std_logic_vector(count);
end Behavioral;
