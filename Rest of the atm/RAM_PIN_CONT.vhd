
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


-- RAM 4 X 16 , in fiecare bloc se afla PIN-ul de la fiecare cont
entity RAM_PIN_CONT is
  Port ( address : in std_logic_vector ( 1 downto 0 );
         pin_in : in std_logic_vector ( 15 downto 0 );
         write_enable : in std_logic;
         clk_ram : in std_logic;
         pin_out : out std_logic_vector ( 15 downto 0) );
end RAM_PIN_CONT;

architecture Behavioral of RAM_PIN_CONT is

type ram_array is array ( 0 to 3 ) of std_logic_vector (15 downto 0);
signal ram_data : ram_array := (  b"0001001000110001", -- PIN1 = 1231
                                  b"0010000000000011", -- PIN2 = 2003
                                  b"0010000000100110", -- PIN3 = 2026
                                  b"0010000000000000" ); -- PIN4 = 2000                                                                 
begin

    process(clk_ram)
        begin
            if ( rising_edge(clk_ram) ) then
                if ( write_enable = '1' ) then
                    ram_data(to_integer(unsigned(address))) <= pin_in;
                end if;
            end if;                 
    end process;   
     
    pin_out <= ram_data(to_integer(unsigned(address)));
    
end Behavioral;
