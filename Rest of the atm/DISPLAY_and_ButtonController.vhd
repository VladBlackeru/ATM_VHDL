
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity DISPLAY_and_ButtonController is
  Port (button_left, button_right, button_up, button_down : in std_logic;
        digit1_in, digit2_in, digit3_in, digit4_in : in std_logic_vector(3 downto 0);
        disable_button_controller : in std_logic;
        CATOZI : out std_logic_vector(6 downto 0);
        ANOZI : out std_logic_vector(7 downto 0);
        reset : in std_logic;
        clk : in std_logic;
        digit1_out, digit2_out, digit3_out, digit4_out : out std_logic_vector(3 downto 0)
        );
end DISPLAY_and_ButtonController;

architecture Behavioral of DISPLAY_and_ButtonController is
    Component my_button_controller is
     Port ( button_left, button_right, button_down, button_up, RESET: in std_logic; 
            digit1, digit2, digit3, digit4 : out std_logic_vector(3 downto 0)
            );
            
    end component;
    
    Component SSD is
        Port ( CLK : in STD_LOGIC;
           digit0 : in STD_LOGIC_VECTOR (3 downto 0);
           digit1 : in STD_LOGIC_VECTOR (3 downto 0);
           digit2 : in STD_LOGIC_VECTOR (3 downto 0);
           digit3 : in STD_LOGIC_VECTOR (3 downto 0);
           AN : out STD_LOGIC_VECTOR (3 downto 0);
           CAT : out STD_LOGIC_VECTOR (6 downto 0));
    end component;
    Component DISPLAY_ON_4SG is
    Port (CLK : in std_logic;
       digit1 : in std_logic_vector(3 downto 0);
       digit2 : in std_logic_vector(3 downto 0);
       digit3 : in std_logic_vector(3 downto 0);
       digit4 : in std_logic_vector(3 downto 0);
       reset : in std_logic;
       CATOZI : out std_logic_vector(6 downto 0);
       ANOZI : out std_logic_vector(7 downto 0);
       SEL : out std_logic_vector(2 downto 0)
       );
    end component;
    
    Component Debouncer is
        Port ( clk : in STD_LOGIC;
           btn : in STD_LOGIC;
           debounced_btn : out STD_LOGIC);
    end component;
    Signal digit1_in_Display, digit2_in_Display, digit3_in_Display, digit4_in_Display : std_logic_vector(3 downto 0);
    Signal digit1_out_BTC, digit2_out_BTC, digit3_out_BTC, digit4_out_BTC : std_logic_vector(3 downto 0);
    Signal debounced_btn_left, debounced_btn_right, debounced_btn_up, debounced_btn_down, debounced_btn_enter : std_logic;
    Signal sel : std_logic_vector(2 downto 0);
    
begin
   
   process(disable_button_controller,digit1_in, digit2_in, digit3_in, digit4_in,
           digit1_out_BTC, digit2_out_BTC, digit3_out_BTC, digit4_out_BTC
           )
        begin
            if disable_button_controller = '1' then
            digit1_in_display <= digit1_in;
            digit2_in_display <= digit2_in;
            digit3_in_display <= digit3_in;
            digit4_in_display <= digit4_in;            
            else
            digit1_in_display <= digit1_out_BTC;
            digit2_in_display <= digit2_out_BTC;
            digit3_in_display <= digit3_out_BTC;
            digit4_in_display <= digit4_out_BTC;  
            end if;
   end process;      
    
    Display : DISPLAY_ON_4SG port map (CLK => clk, digit1 => digit1_in_display, digit2 => digit2_in_display
                                      ,digit3 => digit3_in_display, digit4 =>digit4_in_display,
                                       reset => reset, CATOZI => CATOZI, ANOZI => ANOZI, SEL => sel);
    Button_controller2 : my_button_controller port map (button_left => button_left, button_right => button_right,
                       button_down => button_down, button_up => button_up, RESET => reset,
                      digit1 => digit1_out_BTC, digit2 => digit2_out_BTC, digit3 => digit3_out_BTC, digit4 => digit4_out_BTC);

    digit1_out <= digit1_in_display;
    digit2_out <= digit2_in_display;
    digit3_out <= digit3_in_display;
    digit4_out <= digit4_in_display;
end Behavioral;
