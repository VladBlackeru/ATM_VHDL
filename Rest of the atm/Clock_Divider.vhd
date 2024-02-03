

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Clock_Divider is
      Port ( CLK : in std_logic;
             CLK_output : out std_logic);
end Clock_Divider;

architecture Behavioral of Clock_Divider is
    
    signal count : natural range 0 to 100000 := 0;
    
begin
process(clk)
    begin
        if ( CLK'event and CLK ='1' ) then
        if ( count = 99999 ) then 
         count <= 0; CLK_output <= '0'; 
          elsif ( count < 50000 ) then 
            CLK_output <= '0';
            count <= count + 1;
          elsif ( count > 49999 )then 
          CLK_output <= '1';
          count <= count + 1;
        end if;
        end if;

end process; 
    
end Behavioral;
