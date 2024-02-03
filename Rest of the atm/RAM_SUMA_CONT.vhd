
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity RAM_SUMA_CONT is
  Port ( address : in std_logic_vector ( 1 downto 0 );
         suma_in : in std_logic_vector ( 15 downto 0 );
         ok_suma_depusa : in std_logic;
         ok_suma_retrasa : in std_logic;
         write_enable : in std_logic;
         clk_ram : in std_logic;
         suma_out : out std_logic_vector ( 15 downto 0) );
end RAM_SUMA_CONT;

architecture Behavioral of RAM_SUMA_CONT is
-- 65535€ SUMA MAXIMA
type ram_array is array ( 0 to 3 ) of std_logic_vector (15 downto 0);
signal ram_data : ram_array := (  b"0000000011001000", -- SUMA CONT 1= 200€
                                  b"0000001110000100", -- SUMA CONT 2= 900€
                                  b"0000001111101000", -- SUMA CONT 3 = 1000€
                                  b"0000000101011110"); -- SUMA CONT 4 = 350€ 
                                  
       
       
                                  
begin
    
    suma_out <= ram_data(to_integer(unsigned(address)));
   
    process(clk_ram, ok_suma_retrasa, ok_suma_depusa, suma_in, write_enable)
        begin
            if rising_edge (clk_ram) then
                if write_enable = '1'  then
                    if ok_suma_depusa = '1' then
                        ram_data(to_integer(unsigned(address))) <= std_logic_vector( unsigned( unsigned(ram_data(to_integer(unsigned(address)))) + unsigned(suma_in) ) );
                    elsif ok_suma_retrasa = '1' then
                        ram_data(to_integer(unsigned(address))) <= std_logic_vector( unsigned( unsigned(ram_data(to_integer(unsigned(address)))) - unsigned(suma_in) ) );  
                    end if;
                end if;
            end if;    
    end process;    
    

end Behavioral;
