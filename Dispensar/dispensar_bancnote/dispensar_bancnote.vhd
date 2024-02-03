----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/18/2023 09:27:42 AM
-- Design Name: 
-- Module Name: dispensar_bancnote - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity dispensar_bancnote is
 Port (
        --sumaaa: out std_logic_vector(9 downto 0); -- suma convertita in 10 biti, din celce 4 digituri
        clk, enable: in std_logic;
        DIGIT1, DIGIT2, DIGIT3, DIGIT4: in std_logic_vector(3 downto 0);
        banknotes_of_100, banknotes_of_50, banknotes_of_10, banknotes_of_5 : in std_logic_vector(7 downto 0);
        valid_atm, ok_next_state: out std_logic;-- ok daca se pot retrage banii din bancomat
        bank_out_100, bank_out_50, bank_out_10, bank_out_5: out std_logic_vector(3 downto 0) 
  );
end dispensar_bancnote;

architecture Behavioral of dispensar_bancnote is

component wait_for_dispense_money is
  Port ( 
    enable, clk: in std_logic;
    ok : out std_logic
  );
end component;

component Adder is
Generic(n:integer);
    Port ( Cin : in  STD_LOGIC;
           A : in  STD_LOGIC_VECTOR (n-1 downto 0);
           B : in  STD_LOGIC_VECTOR (n-1 downto 0);
           Result : out  STD_LOGIC_VECTOR (n-1 downto 0));
end component;

component dispence_money IS
  PORT (
        clk, enable: in std_logic;
        summa_de_scos: in std_logic_vector(9 downto 0);
        bancnote100, bancnote50, bancnote10, bancnote5: in std_logic_vector(7 downto 0);
        banc100, banc50, banc10, banc5 : out std_logic_vector(3 downto 0);
        ok: out std_logic
    );
END component;

component from_16_bits_to_10 is
  Port ( 
        digit1,digit2,digit3, digit4 : in std_logic_vector(3 downto 0);
         outp_mii , outp_sute , outp_zeci , outp_unitati : out std_logic_vector(9 downto 0)
  );
end component;

signal mii, zeci, sute, unitati : std_logic_vector(9 downto 0);
signal s1, s2, sf : std_logic_vector(9 downto 0);
SIGNAL ok1, ok2 : std_logic;
begin
convertor : from_16_bits_to_10 port map(
              digit1 => DIGIT1, digit2 => DIGIT2, digit3 => DIGIT3, digit4 => DIGIT4,
               outp_mii => mii,  outp_sute => sute, outp_zeci => zeci,outp_unitati => unitati 
); 

sum1 :  Adder generic map(n => 10) port map(
        Cin => '0', A => mii, B => sute, Result => s1
);
sum2 :Adder generic map(n => 10) port map(
        Cin => '0', A => zeci, B => unitati, Result => s2
);
sumf :Adder generic map(n => 10) port map(
        Cin => '0', A => s1, B => s2, Result => sf
);

money_outp : dispence_money port map(
    clk => clk, enable => enable,summa_de_scos => sf, 
    bancnote100=> banknotes_of_100, bancnote50 => banknotes_of_50, bancnote10 => banknotes_of_10, bancnote5 => banknotes_of_5,
    banc100 => bank_out_100, banc50 => bank_out_50, banc10 => bank_out_10, banc5 =>  bank_out_5,
    ok => ok1
);
ok_state: wait_for_dispense_money port map(
    enable => enable, clk => clk,ok => ok_next_state);
--sumaaa <= sf;

ok2 <= '0' when  (mii = "0000000001" OR unitati = "0000000001") else
       '1' when (mii = "1111101000" and zeci ="0000000000" and unitati = "0000000000" and sute = "0000000000") else
       '1' when mii = "0000000000" else
       '0';
       
valid_atm <= ok1 and ok2;
end Behavioral;