library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_arith.all;

entity NumberToDigitsConverter is
  port (
    input: in std_logic_vector (15 downto 0);
    output0: out std_logic_vector (3 downto 0);
    output1: out std_logic_vector (3 downto 0);
    output2: out std_logic_vector (3 downto 0);
    output3: out std_logic_vector (3 downto 0)
  );
end NumberToDigitsConverter;

architecture Behavioral of NumberToDigitsConverter is

signal number: integer := 0;
signal digit0: integer := 0;
signal digit1: integer := 0;
signal digit2: integer := 0;
signal digit3: integer := 0;

begin

    number <= conv_integer(unsigned(input));
    
    digit3 <= (number / 1000) mod 10;
    digit2 <= (number / 100) mod 10;
    digit1 <= (number / 10) mod 10;
    digit0 <= (number / 1) mod 10;
    
    output0 <= conv_std_logic_vector(digit0, output0'length);
    output1 <= conv_std_logic_vector(digit1, output1'length);
    output2 <= conv_std_logic_vector(digit2, output2'length);
    output3 <= conv_std_logic_vector(digit3, output3'length);

end Behavioral;
