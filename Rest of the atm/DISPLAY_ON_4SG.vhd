----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/27/2023 06:09:38 PM
-- Design Name: 
-- Module Name: DISPLAY_ON_4SG - Behavioral
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

entity DISPLAY_ON_4SG is
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
end DISPLAY_ON_4SG;

architecture Behavioral of DISPLAY_ON_4SG is
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
    
    Component MUX8_1_on8bits is
              Port (SEL : in std_logic_vector(2 downto 0);
            a0 : in std_logic_vector(7 downto 0);
            a1 : in std_logic_vector(7 downto 0);
            a2 : in std_logic_vector(7 downto 0);
            a3 : in std_logic_vector(7 downto 0);
            a4 : in std_logic_vector(7 downto 0);
            a5 : in std_logic_vector(7 downto 0);
            a6 : in std_logic_vector(7 downto 0);
            a7 : in std_logic_vector(7 downto 0);
            output : out std_logic_vector(7 downto 0));
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
    Signal clock_divider_output : std_logic;
    Signal counter_output : std_logic_vector(2 downto 0);
    
    
begin
    Clock_Divider1 : Clock_Divider port map (CLK => CLK, CLK_output => clock_divider_output);
    Counter_on_3bits1 : Counter_on_3bits port map (clk => clock_divider_output, reset => reset, output_counter => counter_output);
    DECODER : DECODER_BCD_TO_7SD port map (BCDin => mux_to_decoder, Seven_Segment => CATOZI);
    MUX1 : MUX8_1 port map (SEL => counter_output, a0 => digit1, a1 => digit2, a2 => digit3, a3 => digit4, a4 => "1001", a5 => "0000",
                            a6 => "0000", a7 => "0010", output => mux_to_decoder);
    MUX2: MUX8_1_on8bits port map (SEL => counter_output, a0 => "01111111", a1 => "10111111", a2 => "11011111",
                           a3 => "11101111", a4 => "11110111", a5 => "11111011", a6 => "11111101",
                           a7 => "11111110", output => ANOZI);
    
    SEL <= counter_output;
end Behavioral;

