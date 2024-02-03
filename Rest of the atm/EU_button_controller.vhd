----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/03/2023 10:37:59 AM
-- Design Name: 
-- Module Name: EU_button_controller - Behavioral
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

entity EU_button_controller is
Port ( button_up, button_down, button_right, button_left : in std_logic;
       current_state : in std_logic_vector(3 downto 0);
       reset : in std_logic;
       digit1 : out std_logic_vector(3 downto 0);
       digit2 : out std_logic_vector(3 downto 0);
       digit3 : out std_logic_vector(3 downto 0);
       digit4 : out std_logic_vector(3 downto 0);
       enable_up1, enable_down1, enable_left1, enable_right1 : out std_logic;
        select_counter1 : out std_logic_vector ( 1 downto 0);
        clk_up_down1 : out std_logic;
        clk_left_right1 : out std_logic;
    
     enable_11, enable_21, enable_31, enable_41 : out std_logic
      );
         
end EU_button_controller;

architecture Behavioral of EU_button_controller is

    signal digit_1, digit_2, digit_3, digit_4 : std_logic_vector ( 3 downto 0 ) := "0000"; 
    signal enable_up, enable_down, enable_left, enable_right : std_logic;    
    
    Component counter_up_down_on_4bits is
      Port (clk, enable_counter, enable_up, enable_down, reset : in std_logic;
        digit_output : out std_logic_vector (3 downto 0)
        );
    end component;
    
    Component counter_left_right_on_2bits is
          Port (  clk, enable_left, enable_right, reset : in std_logic;
              digit_2bits : out std_logic_vector(1 downto 0)
      );
    end component;
    
    signal clk_up_down : std_logic;
    signal clk_left_right : std_logic;
    
    signal enable_1, enable_2, enable_3, enable_4 : std_logic;
    signal select_counter : std_logic_vector ( 1 downto 0);
    
begin
    clk_up_down <= button_up or button_down;
    clk_left_right <= button_left or button_right;
    
    digit1 <= digit_1;
    digit2 <= digit_2;
    digit3 <= digit_3;
    digit4 <= digit_4;
    
    
    Counter_1 : counter_up_down_on_4bits port map (clk => clk_up_down, enable_counter => enable_1,
                                                    enable_up => enable_up, enable_down => enable_down, 
                                                    reset => reset, digit_output => digit_1);
    Counter_2 : counter_up_down_on_4bits port map (clk => clk_up_down, enable_counter => enable_2,
                                                    enable_up => enable_up, enable_down => enable_down, 
                                                    reset => reset, digit_output => digit_2);                                                    
    Counter_3 : counter_up_down_on_4bits port map (clk => clk_up_down, enable_counter => enable_3,
                                                    enable_up => enable_up, enable_down => enable_down, 
                                                    reset => reset, digit_output => digit_3);    
    Counter_4 : counter_up_down_on_4bits port map (clk => clk_up_down, enable_counter => enable_4,
                                                    enable_up => enable_up, enable_down => enable_down, 
                                                    reset => reset, digit_output => digit_4);
                                                    
    Counter_left_right : counter_left_right_on_2bits port map (clk => clk_left_right, enable_left => enable_left,
                                                                enable_right => enable_right, reset => reset, 
                                                                digit_2bits => select_counter);
                                                                
   --process for selecting counter enable
   process(select_counter)
        begin
        case select_counter is
        when "00" => enable_1 <= '1';
                     enable_2 <= '0';
                     enable_3 <= '0';
                     enable_4 <= '0';
        when "01" => enable_1 <= '0';
                     enable_2 <= '1';
                     enable_3 <= '0';
                     enable_4 <= '0';
                     
        when "10" => enable_1 <= '0';
                     enable_2 <= '0';
                     enable_3 <= '1';
                     enable_4 <= '0';
        when "11" => enable_1 <= '0';
                     enable_2 <= '0';
                     enable_3 <= '0';
                     enable_4 <= '1'; 
        when others => enable_1 <= '0';
                     enable_2 <= '0';
                     enable_3 <= '0';
                     enable_4 <= '0';                                                                            
        end case;             
   end process;                                                                                                              
                                                       
    -- process for choosing enables base on the current states
    process(current_state)
        begin
            case current_state is
                when "0001" => enable_up <= '1';
                               enable_down <= '0';
                               enable_left <= '0';
                               enable_right <= '0';                      
                when "0010" => enable_up <= '0';
                               enable_down <= '1';
                               enable_left <= '0';
                               enable_right <= '0';
                 when "0100" => enable_up <= '0';
                               enable_down <= '0';
                               enable_left <= '1';
                               enable_right <= '0';
                when "1000" => enable_up <= '0';
                               enable_down <= '0';
                               enable_left <= '0';
                               enable_right <= '1';
                when others => enable_up <= '0';
                               enable_down <= '0';
                               enable_left <= '0';
                               enable_right <= '0';
                                         
             end case;                         
    end process;   
    
     enable_up1 <= enable_up;
     enable_down1 <= enable_down;
     enable_left1 <= enable_left; 
     enable_right1 <= enable_right;
        select_counter1 <= select_counter;
      
        clk_up_down1 <= clk_up_down;
        clk_left_right1 <= clk_left_right;
    
     enable_11 <= enable_1;
     enable_21 <= enable_2;
     enable_31 <= enable_3;
     enable_41 <= enable_4;    
end Behavioral;
