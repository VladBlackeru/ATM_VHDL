
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity EU_ATM is

    Port (  clk : in std_logic;
            button_left, button_right, button_up, button_down, button_enter_in, reset_switch :  in std_logic;
            waiting_led, success_led, err_led : out std_logic;
            address_led : out std_logic_vector(2 downto 0) ;
            CAT : out std_logic_vector(6 downto 0);
            AN : out std_logic_vector(3 downto 0);
             current_state_test : out std_logic_vector(4 downto 0)
          );
end EU_ATM;


architecture Behavioral of EU_ATM is
 
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

component RAM_SUMA_ATM is
  Port ( 
         bancnota_5_in, bancnota_10_in, bancnota_50_in, bancnota_100_in : in std_logic_vector(7 downto 0); 
         write_enable : in std_logic;
         depus_numerar : in std_logic;
         retras_numerar : in std_logic;
         clk_ram : in std_logic;
         bancnota_5_out, bancnota_10_out, bancnota_50_out, bancnota_100_out : out std_logic_vector(7 downto 0);
         suma_atm_total : out std_logic_vector(15 downto 0)
         );
         
end component;

  component NumberToDigitsConverter is
  port (
    input: in std_logic_vector (15 downto 0);
    output0: out std_logic_vector (3 downto 0);
    output1: out std_logic_vector (3 downto 0);
    output2: out std_logic_vector (3 downto 0);
    output3: out std_logic_vector (3 downto 0)
  );
end component; 

  Component CU_ATM is
    Port( clk, card_found, pin_found, ok_sold, reset, ok_numerar_depus : in std_logic;
         enter : in std_logic;
         err_done : in std_logic;
         success_done : in std_logic;
         selected_operation : in std_logic_vector(3 downto 0);
         enable_comp_pin, enable_comp_card, enable_comp_sold: out std_logic; -- la sold trb verificat si ATM-ul si Contul
         err_led : out std_logic;
         waiting_led : out std_logic;
         success_led : out std_logic;
         display_money : out std_logic;
         reset_display : out std_logic;
         enable_write_sold_cont, enable_write_sold_atm, enable_verif_numerar_depus, enable_write_cont_pin : out std_logic;
         enable_afisor_tip_bacnote : out std_logic;
         current_state : out std_logic_vector(4 downto 0);
         enable_adress : out std_logic
        );
  end component;  
  
  Component DISPLAY_and_ButtonController is
    Port (button_left, button_right, button_up, button_down : in std_logic;
        digit1_in, digit2_in, digit3_in, digit4_in : in std_logic_vector(3 downto 0);
        disable_button_controller : in std_logic;
        CATOZI : out std_logic_vector(6 downto 0);
        ANOZI : out std_logic_vector(7 downto 0);
        reset : in std_logic;
        clk : in std_logic;
        digit1_out, digit2_out, digit3_out, digit4_out : out std_logic_vector(3 downto 0)
        );
  end component;
  
  Component FrequencyDividerControlUnit is
    port (
        clock100Mhz: in std_logic;
        reset : in std_logic;
        clockOut: out std_logic
    );
  end component;
   
   Component edge_detector is
port (
  i_clk                       : in  std_logic;
  i_input                     : in  std_logic;
  o_pulse                     : out std_logic);
end Component;

component Clock_divider_for_leds is
  Port (clk : in std_logic;
        done : out std_logic );
end component;

   component RAM_PIN_CONT is
  Port ( address : in std_logic_vector ( 1 downto 0 );
         pin_in : in std_logic_vector ( 15 downto 0 );
         write_enable : in std_logic;
         clk_ram : in std_logic;
         pin_out : out std_logic_vector ( 15 downto 0) );
end component;
  
  component RAM_SUMA_CONT is
  Port ( address : in std_logic_vector ( 1 downto 0 );
         suma_in : in std_logic_vector ( 15 downto 0 );
         ok_suma_depusa : in std_logic;
         ok_suma_retrasa : in std_logic;
         write_enable : in std_logic;
         clk_ram : in std_logic;
         suma_out : out std_logic_vector ( 15 downto 0) );
end component;
  
  --signals for RAM_SUMA_CONT
  signal suma_in_by_user, suma_out_ram_cont : std_logic_vector(15 downto 0);
  signal ok_suma_depusa, ok_suma_retrasa : std_logic;
  
  --signals for CU
  signal clk_for_CU, card_found_CU, pin_found_CU,ok_sold_CU,reset_CU,ok_numerar_depus_CU : std_logic;
  signal err_done_CU, success_done_CU, enable_comp_pin_from_CU, enable_comp_card_from_CU : std_logic;
  signal enable_comp_sold_from_CU, err_led_from_CU, success_led_from_CU, waiting_led_from_CU : std_logic;
  signal display_money_from_CU, reset_display_from_CU : std_logic;
  signal enable_write_sold_cont_from_CU, enable_write_sold_atm_from_CU : std_logic;
  signal enable_verif_numerar_depus_from_CU, enable_write_cont_pin_from_CU : std_logic;
  signal enable_afisor_tip_bacnote_from_CU : std_logic;
  signal selected_operation_CU : std_logic_vector(3 downto 0);
  signal button_enter : std_logic;
  signal state : std_logic_vector(4 downto 0);
  signal enable_adress : std_logic;
  
  --signals for DISPLAY_and_Button_Controller
  signal digit1_by_us, digit2_by_us, digit3_by_us, digit4_by_us : std_logic_vector(3 downto 0);
  signal disable_button_controller_from_us : std_logic;
  signal AN_IN : std_logic_vector(7 downto 0);
  signal digit1_out_DS, digit2_out_DS, digit3_out_DS, digit4_out_DS : std_logic_vector(3 downto 0);
  
  --signal for memory
  signal account_adress : std_logic_vector(3 downto 0) := "0000";
  
  -- signal enter detection
  signal enter : std_logic;
 
 --signals for RAM_PIN_CONT
 signal pin_in_by_user : std_logic_vector(15 downto 0);
 signal pin_current_account : std_logic_vector(15 downto 0);
 signal digit1_ram, digit2_ram, digit3_ram, digit4_ram : std_logic_vector(3 downto 0);
 
 --signals 
    signal digit1_BCD:  std_logic_vector (3 downto 0);
    signal digit2_BCD:  std_logic_vector (3 downto 0);
    signal digit3_BCD:  std_logic_vector (3 downto 0);
    signal digit4_BCD:  std_logic_vector (3 downto 0);
    
  --signal for changing the pin
  signal pin_to_be_changed : std_logic_vector(15 downto 0);
  
  --signalf for retragere numerar
  signal digit1_DEPUNERE,  digit2_DEPUNERE, digit3_DEPUNERE, digit4_DEPUNERE : std_logic_vector(3 downto 0);
  signal suma_retragere_numerar_unsigned : integer;
  
begin

--    RAM_ATM_HERE :  RAM_SUMA_ATM port map ( 
--         bancnota_5_in => ,
--         bancnota_10_in => ,
--         bancnota_50_in => ,
--         bancnota_100_in => ,
--         write_enable => ,
--         depus_numerar => ,
--         retras_numerar => ,
--         clk_ram : in s
--         bancnota_5_out, bancnota_10_out, bancnota_50_out, bancnota_100_out : out std_logic_vector(7 downto 0);
--         suma_atm_total : out std_logic_vector(15 downto 0)
--         );
         

    RAM_PIN_HERE : RAM_PIN_CONT port map (address => account_adress(1 downto 0),
                                           pin_in => pin_to_be_changed,
                                           write_enable => enable_write_cont_pin_from_CU,
                                           clk_ram => clk,
                                           pin_out => pin_current_account
                                          );
                                          
    CU_BIG_BOY : CU_ATM port map (clk => clk, 
                                  card_found => card_found_CU, 
                                  pin_found => pin_found_CU, 
                                  ok_sold => ok_sold_CU, 
                                  reset => reset_switch, 
                                  ok_numerar_depus => ok_numerar_depus_CU,
                                  enter => enter,
                                  err_done => err_done_CU,
                                  success_done => success_done_CU,
                                  selected_operation => selected_operation_CU,
                                  enable_comp_pin => enable_comp_pin_from_CU, 
                                  enable_comp_card => enable_comp_card_from_CU,
                                  enable_comp_sold => enable_comp_sold_from_CU,
                                  err_led => err_led,
                                  waiting_led => waiting_led,
                                  success_led => success_led,
                                  display_money => display_money_from_CU,
                                  reset_display => reset_display_from_CU,
                                  enable_write_sold_cont => enable_write_sold_cont_from_CU,
                                  enable_write_sold_atm => enable_write_sold_atm_from_CU,
                                  enable_verif_numerar_depus => enable_verif_numerar_depus_from_CU,
                                  enable_write_cont_pin => enable_write_cont_pin_from_CU,
                                  enable_afisor_tip_bacnote => enable_afisor_tip_bacnote_from_CU,
                                  current_state => state,
                                  enable_adress => enable_adress
                                  );
                                  current_state_test <= state;
    AN <= AN_IN(7 downto 4);
    Display_money : DISPLAY_and_ButtonController port map (button_left => button_left, 
                                                           button_right => button_right,
                                                           button_up => button_up, 
                                                           button_down => button_down,
                                                           digit1_in => digit1_by_us, 
                                                           digit2_in => digit2_by_us,
                                                           digit3_in => digit3_by_us,
                                                           digit4_in => digit4_by_us,
                                                           disable_button_controller => disable_button_controller_from_us,           
                                                           CATOZI => CAT,
                                                           ANOZI => AN_IN,
                                                           reset => reset_switch,
                                                           clk => clk,
                                                           digit1_out => digit1_out_DS, 
                                                           digit2_out => digit2_out_DS, 
                                                           digit3_out => digit3_out_DS,
                                                           digit4_out => digit4_out_DS
                                                           );
                                                           
--    Clock_divider_for_CU : FrequencyDividerControlUnit port map (
--        clock100Mhz => clk,
--        reset => reset_switch,
--        clockOut => clk_for_CU
--     );
 
     
     edge_detector_enter: edge_detector port map(
                                                 i_clk => clk,
                                                 i_input => button_enter_in,
                                                 o_pulse=> enter
                                                );


    err_led_comp : Clock_divider_for_leds port map(clk => clk,
                                          done => err_done_CU);
                                          
    success_led_comp : Clock_divider_for_leds port map(clk => clk,
                                          done => success_done_CU);
                                          
    RAM_SUMA_CONT_ANOTHER_BIG_BOY : RAM_SUMA_CONT port map (address => account_adress(1 downto 0),
                                                            suma_in => suma_in_by_user,
                                                            ok_suma_depusa => ok_numerar_depus_CU,
                                                            ok_suma_retrasa => ok_suma_retrasa,
                                                            write_enable => enable_write_sold_cont_from_CU,
                                                            clk_ram => clk,
                                                            suma_out => suma_out_ram_cont
                                                            );
    
    CONVERTER_BCD : NumberToDigitsConverter port map(
                                                     input => suma_out_ram_cont,
                                                     output0 => digit4_BCD,
                                                     output1 => digit3_BCD,
                                                     output2 => digit2_BCD,
                                                     output3 => digit1_BCD
                                                    ); 
                       
       account_adress <= std_logic_vector(unsigned(digit4_out_DS) - 1) when enable_adress = '1';
                       
    address_led <= account_adress(2 downto 0);
    
     --VERIFYING THE ACCOUNT CHOSEN
    card_found_cu <= '1' when digit1_out_DS = "0000" and digit2_out_DS = "0000" and digit3_out_DS = "0000"
                      and (digit4_out_DS = "0001" or digit4_out_DS = "0010" or digit4_out_DS = "0011" or digit4_out_DS = "0100") 
                      else '0';
                     
     --PUT THE PIN
     pin_in_by_user(15 downto 12) <= digit1_out_DS; 
     pin_in_by_user(11 downto 8) <= digit2_out_DS; 
     pin_in_by_user(7 downto 4) <= digit3_out_DS; 
     pin_in_by_user(3 downto 0) <= digit4_out_DS;
     
     --VERIFY THE PIN
      pin_found_CU <= '1' when pin_current_account = pin_in_by_user else
                      '0';
                      
    --GIVE THE CHOSEN OPERATION
    selected_operation_CU <= digit4_out_DS;                  
                     
    --DISPLAY MONEY
    digit1_by_us <= digit1_BCD when display_money_from_CU = '1';
    digit2_by_us <= digit2_BCD when display_money_from_CU = '1';
    digit3_by_us <= digit3_BCD when display_money_from_CU = '1';
    digit4_by_us <= digit4_BCD when display_money_from_CU = '1';
    disable_button_controller_from_us <= '1' when display_money_from_CU = '1' else
                                         '0';
    
    --GET THE PIN TO BE CHANGED
    pin_to_be_changed(15 downto 12) <= digit1_out_DS when state = "11000";
    pin_to_be_changed(11 downto 8) <= digit2_out_DS when state = "11000";
    pin_to_be_changed(7 downto 4) <= digit3_out_DS when state = "11000";
    pin_to_be_changed(3 downto 0) <= digit4_out_DS when state = "11000";
    
    --DEPUNERE NUMERAR
--    ok_numerar_depus_CU <= '1' when( unsigned(digit1_DEPUNERE) * 100 + unsigned(digit2_DEPUNERE) *50 + unsigned(digit3_DEPUNERE) * 10 + unsigned(digit4_DEPUNERE)*5 ) < 1001 else
--                           '0';
   
--    digit1_DEPUNERE <=  digit1_BCD when state = "10011";
--    digit2_DEPUNERE <=  digit2_BCD when state = "10011";
--    digit3_DEPUNERE <=  digit3_BCD when state = "10011";
--    digit4_DEPUNERE <=  digit4_BCD when state = "10011";
    
--    suma_retragere_numerar_unsigned <= to_integer( unsigned(digit1_DEPUNERE) * 100 + unsigned(digit2_DEPUNERE) *50 + unsigned(digit3_DEPUNERE)*10 + unsigned(digit4_DEPUNERE)*5 );
    
--    suma_in_by_user <= std_logic_vector( to_unsigned( suma_retragere_numerar_unsigned, 16 ) ) ;
    
    
    
    
    
    
    
    
end Behavioral;


