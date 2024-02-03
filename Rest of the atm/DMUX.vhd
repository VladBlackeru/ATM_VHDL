

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity DMUX is
  Port ( sel : in std_logic_vector(1 downto 0);
         enable_1, enable_2, enable_3, enable_4 : out std_logic
         );
end DMUX;

architecture Behavioral of DMUX is

begin
    
    process(sel)
        begin
        if ( sel = "00" ) then enable_1 <= '1';
                               enable_2 <= '0';
                               enable_3 <= '0';
                               enable_4 <= '0';
        elsif ( sel = "01" ) then enable_1 <= '0';
                               enable_2 <= '1';
                               enable_3 <= '0';
                               enable_4 <= '0';
        elsif ( sel = "10" ) then enable_1 <= '0';
                               enable_2 <= '0';
                               enable_3 <= '1';
                               enable_4 <= '0';                                             
        elsif ( sel = "11" ) then enable_1 <= '0';
                               enable_2 <= '0';
                               enable_3 <= '0';
                               enable_4 <= '1';
        else enable_1 <= '0';
             enable_2 <= '0';
              enable_3 <= '0';
              enable_4 <= '0';
         end if;                      
    end process;
    
end Behavioral;
