LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY dispence_money IS
  PORT (
        clk, enable: in std_logic;
        summa_de_scos: in std_logic_vector(9 downto 0);
        bancnote100, bancnote50, bancnote10, bancnote5: in std_logic_vector(7 downto 0);
        banc100, banc50, banc10, banc5 : out std_logic_vector(3 downto 0);
        ok: out std_logic
    );
END dispence_money;


ARCHITECTURE TypeArchitecture OF dispence_money IS
signal summa_scos : unsigned(9 downto 0);
signal bani100, bani50, bani10, bani5 : unsigned(7 downto 0);
signal money100, money50, money10, money5 : unsigned(3 downto 0);


begin
process(clk)
begin

if(rising_edge(clk))then
if(enable = '0')then
    summa_scos <= unsigned(summa_de_scos);
    bani100 <= unsigned(bancnote100);
    bani50 <= unsigned(bancnote50);
    bani10 <= unsigned(bancnote10);
    bani5 <= unsigned(bancnote5);
    money100 <= "0000";
    money50 <= "0000";
    money10 <= "0000";
    money5 <= "0000";
    ok <= '0';
else
    if( (summa_scos > 99) and (bani100 > 0) and (money100 < 9) )then
        summa_scos <= summa_scos -100;
        bani100 <= bani100 - 1;
        money100 <= money100 + 1;
        ok <= '0';
    elsif( (summa_scos > 49) and (bani50 > 0) and (money50 < 9)  ) then
        summa_scos <= summa_scos - 50;
        bani50 <= bani50 - 1;
        money50 <= money50 + 1;
        ok <= '0';
    elsif(  (summa_scos > 9) and (bani10 > 0) and (money10 < 9)  )then 
        summa_scos <= summa_scos - 10;
        bani10 <= bani10 - 1;
        money10 <= money10 + 1;
        ok <= '0';
    elsif( (summa_scos > 4) and (bani5 > 0) and (money5 < 9)   ) then
        summa_scos <= summa_scos - 5;
        bani5 <= bani5 - 1;
        money5 <= money5 + 1;
        ok <= '0';
    else
        if( summa_scos = 0)then
            ok <= '1';
        else
            ok <= '0';
        end if;
    end if;

end if;
end if;
end process;
banc100  <= std_logic_vector(money100);
banc50  <= std_logic_vector(money50); 
banc10   <= std_logic_vector(money10);
banc5  <= std_logic_vector(money5);

END TypeArchitecture;