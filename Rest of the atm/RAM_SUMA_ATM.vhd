
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity RAM_SUMA_ATM is
  Port ( 
         bancnota_5_in, bancnota_10_in, bancnota_50_in, bancnota_100_in : in std_logic_vector(3 downto 0); 
         write_enable : in std_logic;
         depus_numerar : in std_logic;
         retras_numerar : in std_logic;
         clk_ram : in std_logic;
         bancnota_5_out, bancnota_10_out, bancnota_50_out, bancnota_100_out : out std_logic_vector(7 downto 0)
         );
         
end RAM_SUMA_ATM;

architecture Behavioral of RAM_SUMA_ATM is
                                  
signal b5 : unsigned(7 downto 0) := b"00010100"; -- 100
signal b10 : unsigned(7 downto 0) := b"00010100"; -- 100
signal b50 : unsigned(7 downto 0) := b"00010100"; -- 100
signal b100 : unsigned(7 downto 0) := b"00010100"; -- 100   
                              
begin
    
    
   
    process(clk_ram, bancnota_5_in, bancnota_10_in, bancnota_50_in, bancnota_100_in)
        begin
            if rising_edge(clk_ram) then
                if write_enable = '1' then
                    if depus_numerar = '1' then
                        b5 <= unsigned(bancnota_5_in) + b5;
                        b10 <= unsigned(bancnota_10_in) + b10;
                        b50 <= unsigned(bancnota_50_in) + b50;
                        b100 <= unsigned(bancnota_100_in) + b100;
                    elsif retras_numerar = '1' then
                        b5 <= unsigned(bancnota_5_in) - b5;
                        b10 <= unsigned(bancnota_10_in) - b10;
                        b50 <= unsigned(bancnota_50_in) - b50;
                        b100 <= unsigned(bancnota_100_in) - b100;
                    end if;
                end if;
            end if;
    end process;    
    
bancnota_5_out <= std_logic_vector(b5);
bancnota_10_out <= std_logic_vector(b5);
bancnota_50_out <= std_logic_vector(b5);
bancnota_100_out <= std_logic_vector(b5);
end Behavioral;
