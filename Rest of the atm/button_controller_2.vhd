

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
entity button_controller_2 is
  Port ( clk : in std_logic;
         button_up, button_down, button_left, button_right, button_enter, switch_reset : in std_logic;
         digit1, digit2, digit3, digit4 : out std_logic_vector(3 downto 0);
         current_state : out std_logic_vector(3 downto 0)
         );
end button_controller_2;

architecture Behavioral of button_controller_2 is

    Component CU_button_controller is
      Port ( button_up, button_down, button_left, button_right : in std_logic;
         clk : in std_logic; 
         reset : in std_logic;
         insert_led : in std_logic;
         current_state : out std_logic_vector(3 downto 0) );
         
    end component;
    
    Component EU_button_controller is
    Port ( button_up, button_down, button_right, button_left : in std_logic;
       current_state : in std_logic_vector(3 downto 0);
       reset : in std_logic;
       digit1 : out std_logic_vector(3 downto 0);
       digit2 : out std_logic_vector(3 downto 0);
       digit3 : out std_logic_vector(3 downto 0);
       digit4 : out std_logic_vector(3 downto 0)
      );
       
    end component;

    signal state : std_logic_vector(3 downto 0);
    signal insert_led : std_logic := '1';
begin
    current_state <= state;
CU : CU_button_controller port map (
    button_up => button_up,
    button_down => button_down,
    button_left => button_left,
    button_right => button_right,
    clk => clk,
    reset => switch_reset,
    insert_led => insert_led,
    current_state => state
);

EU : EU_button_controller port map (
    button_up => button_up,
    button_down => button_down,
    button_left => button_left,
    button_right => button_right,
    current_state => state,
    reset => switch_reset,
    digit1 => digit1,
    digit2 => digit2,
    digit3 => digit3,
    digit4 => digit4
);                           

    
end Behavioral;
