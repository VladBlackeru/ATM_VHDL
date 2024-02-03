
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity comparator_PIN_CARD is
 Port (
       enable_comp_card : in std_logic; 
       enable_comp_pin: in std_logic;
       pin_of_curr_card: in std_logic_vector(15 downto 0);
       digit1_card, digit2_card, digit3_card, digit4_card: in std_logic_vector(3 downto 0);
       digit1_pin, digit2_pin, digit3_pin, digit4_pin: in std_logic_vector(3 downto 0);
       card_found : out std_logic;
       pin_found : out std_logic
  );
end comparator_PIN_CARD;

architecture Behavioral of comparator_PIN_CARD is

begin
    --- the digits can't be bigger than 9, the countter is made in such a way that it can count from 0 to 9
    --- if the digits except digit1 are bigger than 0, since we have just 4 acc, it's nott good, card doesn't exist
    process(digit1_card, digit2_card, digit3_card, digit4_card, enable_comp_card)
        begin
        if(enable_comp_card = '1') then
      	  if(digit1_card = "0000" and digit2_card = "0000" and digit3_card = "0000") then
      	     if(digit4_card ="0001" or digit4_card ="0010" or digit4_card ="0011" or digit4_card ="0100") then
         	   card_found <='1';
         	 else      	      
          	    card_found <='0';
         	 end if;
      	  else
          	  card_found <='0';
         	  end if;
        else
          card_found <='0';
        end if;
    end process;
    
    
    ---comparing pin
    process(digit1_pin, digit2_pin, digit3_pin, digit4_pin, enable_comp_pin,pin_of_curr_card)
        begin
        if(enable_comp_pin = '1')then
        	if( pin_of_curr_card(3 downto 0) = digit4_pin 
        	and pin_of_curr_card(7 downto 4) = digit3_pin 
        	and pin_of_curr_card(11 downto 8) = digit2_pin
        	and pin_of_curr_card(15 downto 12) = digit1_pin ) then
        	
           	 pin_found <='1';
       	 else
         	   pin_found <='0';
       	 end if;
        else
        	pin_found <='0';
        end if;
    end process;  
end Behavioral;