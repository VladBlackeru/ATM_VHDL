----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/24/2023 12:55:38 AM
-- Design Name: 
-- Module Name: PIN_TEST - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

entity PIN_TEST is
 Port ( enable_comp_card_from_CU, enable_comp_pin_from_CU : in std_logic;
        digit1, digit2, digit3, digit4 : in std_logic_vector(3 downto 0);
          card_found, pin_found : out std_logic;
        clk : in std_logic;
      pin_out : out std_logic_vector ( 15 downto 0) 
        
 );
end PIN_TEST;

architecture Behavioral of PIN_TEST is
Component RAM_PIN_CONT is
  Port ( address : in std_logic_vector ( 1 downto 0 );
         pin_in : in std_logic_vector ( 15 downto 0 );
         write_enable : in std_logic;
         clk_ram : in std_logic;
         pin_out : out std_logic_vector ( 15 downto 0) );
end component;

Component comparator_PIN_CARD is
 Port (
       enable_comp_card : in std_logic; 
       enable_comp_pin: in std_logic;
       pin_of_curr_card: in std_logic_vector(15 downto 0);
       digit1, digit2, digit3, digit4: in std_logic_vector(3 downto 0);
       card_found : out std_logic;
       pin_found : out std_logic
  );
end component;

       signal  pin_in1 : std_logic_vector ( 15 downto 0 ) := "0000000000000000";
       signal write_enable1 : std_logic := '0';
       signal address1 : std_logic_vector(1 downto 0) := "00";
       signal pin_curr_card :  std_logic_vector ( 15 downto 0) ;
       
      
       
       
begin

pin_out <= pin_curr_card; 
       
           RAM_PIN : RAM_PIN_CONT port map (address => address1,
                                         pin_in => pin_in1,
                                         write_enable => write_enable1,
                                         clk_ram => clk,
                                         pin_out => pin_curr_card
                                         );
    
            comp_PIN_CARD : comparator_PIN_CARD port map (enable_comp_card => enable_comp_card_from_CU,
                                                      enable_comp_pin => enable_comp_pin_from_CU,
                                                      pin_of_curr_card => pin_curr_card,
                                                      digit1 => digit1,
                                                      digit2 => digit2,
                                                      digit3 => digit3,
                                                      digit4 => digit4,
                                                      card_found => card_found,
                                                       pin_found => pin_found
                                                   );
end Behavioral;
