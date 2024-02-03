

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity CU_button_controller is
  Port ( button_up, button_down, button_left, button_right : in std_logic;
         clk : in std_logic; 
         reset : in std_logic;
         insert_led : in std_logic;
         current_state : out std_logic_vector(3 downto 0) );
         
end CU_button_controller;


architecture Behavioral of CU_button_controller is
signal direction : std_logic_vector(3 downto 0);

begin
    direction(3) <= button_right;
    direction(2) <= button_left;
    direction(1) <= button_down;
    direction(0) <= button_up;
    
    process(clk, direction, reset)
        begin
        if reset = '1' then current_state <= "0000";
            elsif insert_led = '0' then current_state <= "0000";
            elsif rising_edge(clk) then 
                    case direction is
                    when "0001" => if direction /= "0010" then 
                                   current_state <= "0001";
                                   else current_state <= direction;
                                   end if;
                    when "0010" => if direction /= "0001" then 
                                   current_state <= "0010";
                                   else current_state <= direction;
                                   end if;
                    when "0100" => if direction /= "1000" then 
                                   current_state <= "0100";
                                   else current_state <= direction;
                                   end if;        
                    when "1000" => if direction /= "0100" then 
                                   current_state <= "1000";
                                   else current_state <= direction;
                                   end if; 
                    when others => current_state <= direction;
                    end case;                                                   
        end if;    
    end process;
    
    
    
end Behavioral;
