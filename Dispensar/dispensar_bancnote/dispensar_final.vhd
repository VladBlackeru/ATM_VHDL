library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity dispensar_final is
  Port ( 
        clock, enbl: in std_logic;
        bank100, bank50, bank10, bank5: in std_logic_vector(7 downto 0);
        digit1, digit2, digit3, digit4: in std_logic_vector(3 downto 0);
        digit100_out, digit50_out, digit10_out, digit5_out: out std_logic_vector(3 downto 0);
        OK: out std_logic
   );
end dispensar_final;

architecture Behavioral of dispensar_final is

component dispensar_bancnote is
 Port (
        --sumaaa: out std_logic_vector(9 downto 0); -- suma convertita in 10 biti, din celce 4 digituri
        clk, enable: in std_logic;
        DIGIT1, DIGIT2, DIGIT3, DIGIT4: in std_logic_vector(3 downto 0);
        banknotes_of_100, banknotes_of_50, banknotes_of_10, banknotes_of_5 : in std_logic_vector(7 downto 0);
        valid_atm, ok_next_state: out std_logic;-- ok daca se pot retrage banii din bancomat
        bank_out_100, bank_out_50, bank_out_10, bank_out_5: out std_logic_vector(3 downto 0) 
  );
end component;

component RAM_bancnote_out is
  Port ( 
        we: in std_logic;
        ban100, ban50, ban10, ban5: in std_logic_vector(3 downto 0);
        banc100_out, banc50_out, banc10_out, banc5_out: out std_logic_vector(3 downto 0)
  );
end component;

signal bani_atm100, bani_atm50, bani_atm10, bani_atm5: std_logic_vector(3 downto 0); 
signal ok1, ok2, okf: std_logic:='0';

begin
OP1: dispensar_bancnote port map(
            clk => clock, enable=> enbl, 
            digit1 => digit1, digit2 => digit2, digit3 => digit3, digit4 => digit4,
            banknotes_of_100 => bank100, banknotes_of_50 => bank50, banknotes_of_10 => bank10, banknotes_of_5 => bank5,
            valid_atm => ok1, ok_next_state => ok2,
            bank_out_100 => bani_atm100, bank_out_50 => bani_atm50, bank_out_10 => bani_atm10, bank_out_5 => bani_atm5
            );
OP2: RAM_bancnote_out port map(
                    we => okf,ban100 => bani_atm100, ban50 => bani_atm50, ban10 => bani_atm10, ban5 => bani_atm5,
                    banc100_out =>  digit100_out , banc50_out => digit50_out, banc10_out => digit10_out, banc5_out => digit5_out
);
okf <= ok1 and ok2;
OK <= okf;
end Behavioral;
