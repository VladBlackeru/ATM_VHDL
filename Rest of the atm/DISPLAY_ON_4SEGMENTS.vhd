

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use IEEE.NUMERIC_STD.ALL;

entity DISPLAY_ON_4SEGMENTS is
 Port (CLK : in std_logic;
       digit1 : in std_logic_vector(3 downto 0);
       digit2 : in std_logic_vector(3 downto 0);
       digit3 : in std_logic_vector(3 downto 0);
       digit4 : in std_logic_vector(3 downto 0);
       reset : in std_logic;
       CATOZI : out std_logic_vector(6 downto 0);
       ANOZI : out std_logic_vector(3 downto 0)
       );
end DISPLAY_ON_4SEGMENTS;

architecture Behavioral of DISPLAY_ON_4SEGMENTS is

    Component Clock_Divider is
      Port ( CLK : in std_logic;
             CLK_output : out std_logic);
    end component;
    
    Component MUX8_1 is
      Port (SEL : in std_logic_vector(2 downto 0);
            a0 : in std_logic_vector(3 downto 0);
            a1 : in std_logic_vector(3 downto 0);
            a2 : in std_logic_vector(3 downto 0);
            a3 : in std_logic_vector(3 downto 0);
            a4 : in std_logic_vector(3 downto 0);
            a5 : in std_logic_vector(3 downto 0);
            a6 : in std_logic_vector(3 downto 0);
            a7 : in std_logic_vector(3 downto 0);
            output : out std_logic_vector(3 downto 0));
    end component;
    
    Component DECODER_BCD_TO_7SD is
      Port ( BCDin : in std_logic_vector(3 downto 0);
         Seven_Segment : out std_logic_vector(6 downto 0)
         );
    end component;
    
    Component Counter_on_3bits is
      Port (clk : in std_logic;
        reset : in std_logic;
        output_counter : out std_logic_vector(2 downto 0));
    end component;
    
    
    Signal mux_to_decoder : std_logic_vector(3 downto 0);
    Signal mux_to_anozi : std_logic_vector(6 downto 0);
    Signal counter_output : std_logic_vector(2 downto 0);
    Signal clock_divider_to_counter : std_logic;
    
    
begin

    Clock_Divider1 : Clock_Divider port map (CLK => CLK, CLK_output => clock_divider_to_counter);
    
    Counter1 : Counter_on_3bits port map(clk => clock_divider_to_counter, reset =>reset, output_counter => counter_output );
    
    DECODER : DECODER_BCD_TO_7SD port map (BCDin => mux_to_decoder, Seven_Segment => CATOZI);
    
    MUX1 : MUX8_1 port map (SEL => counter_output,  a0 => digit1, a1 => digit2, a2 =>digit3, a3 => digit4, a4 => "0000", a5 => "0000", 
                            a6 => "0000", a7 => "0000", output => mux_to_decoder );
                            
    MUX2: MUX8_1 port map (SEL => counter_output, a0 => "01111111", a1 => "10111111", a2 => "11011111", a3 => "11101111",
                           a4 => "11110111", a5 => "11111011", a6 => "11111101", a7 => "11111110", output => ANOZI);
                           
    
    
end Behavioral;
