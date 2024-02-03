library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use IEEE.NUMERIC_STD.ALL;


entity from_16_bits_to_10 is
  Port ( 
        digit1,digit2,digit3, digit4 : in std_logic_vector(3 downto 0);
         outp_mii , outp_sute , outp_zeci , outp_unitati : out std_logic_vector(9 downto 0)
  );
end from_16_bits_to_10;

architecture Behavioral of from_16_bits_to_10 is
signal outp1, outp2,outp3,outp4 : unsigned(9 downto 0):="0000000000";


begin
process(digit1)
begin
    if(digit1 = "0001")then
        outp1 <= "1111101000";
    elsif(digit1 = "0000")then
        outp1 <= "0000000000";
    else
        outp1 <= "0000000001"; -- 1001 if mii > 1000
    end if;
end process;

process(digit2)
begin

if(digit2 = "0001")then
    outp2 <= "0001100100";
elsif(digit2 = "0010")then
    outp2 <= "0011001000";
elsif(digit2 = "0011")then
    outp2 <= "0100101100";
elsif(digit2 = "0100")then
    outp2 <= "0110010000";
elsif(digit2 = "0101")then
    outp2 <= "0111110100";
elsif(digit2 = "0110")then
    outp2 <= "1001011000";
elsif(digit2 = "0111")then
    outp2 <= "1010111100";
elsif(digit2 = "1000")then
    outp2 <= "1100100000";
elsif(digit2 = "1001")then
    outp2 <= "1110000100";
else
    outp2 <= "0000000000";

end if;
end process;

process(digit3)
begin
if(digit3 = "0001")then
    outp3 <= "0000001010";
elsif(digit3 = "0010")then
   outp3 <=  "0000010100";
elsif(digit3 = "0011")then
    outp3 <= "0000011110";
elsif(digit3 = "0100")then
    outp3 <= "0000101000";
elsif(digit3 = "0101")then
    outp3 <= "0000110010";
elsif(digit3 = "0110")then
    outp3 <= "0000111100";
elsif(digit3 = "0111")then
    outp3 <= "0001000110";
elsif(digit3 = "1000")then
    outp3 <= "0001010000";
elsif(digit3 = "1001")then
    outp3 <= "0001011010";
else
    outp3 <= "0000000000";
end if;
end process;

process(digit4)
begin
if(digit4 = "0101")then
    outp4 <= "0000000101";
elsif(digit4 = "0000")then
    outp4 <= "0000000000";
else
    outp4 <= "0000000001";
end if;
end process;

outp_mii <= std_logic_vector(outp1);
outp_sute <= std_logic_vector(outp2);
outp_zeci <= std_logic_vector(outp3);
outp_unitati <= std_logic_vector(outp4);
end Behavioral;