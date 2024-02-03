library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity counter_up_down is
  Port (reset, clk, up,  enable : in std_logic;
        digit_output : out std_logic_vector(3 downto 0)
        );
end counter_up_down;

architecture Behavioral of counter_up_down is
signal count : unsigned (3 downto 0) := "0000";
begin
    process(clk,up, enable, reset)
        begin
        if reset = '1' then count <= "0000";
        elsif ( enable = '1' ) then
            if ( rising_edge(clk) )then
                if (up = '1') then
                    count <= count + 1;
                    if (count = "1001") then
                        count <= "0000";
                     end if;
                else count <= count - 1;
                    if(count = "0000")then
                        count <= "1001";
                    end if;
                end if;

            end if;
        end if;
    end process;

 digit_output <= std_logic_vector(count);

end Behavioral;