
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity CU_ATM is

  Port  (clk, card_found, pin_found, ok_sold, reset, ok_numerar_depus : in std_logic;
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
         enable_adress : out std_logic;
         depus_numerar, retras_numerar : out std_logic
         );
  -- process(state, start, enter_introdu_card, card_found, enter_introdu_pin, pin_found, err_done, success_done, enter_select_operation, seleceted_operation,
  --          enter_back_to_sel_operation, enter_retragere_numerar, ok_sold, enter_depunere_numerar, enter_modificare_pin)      
end CU_ATM;

    architecture Behavioral of CU_ATM is

    type state_type is (idle, introdu_card, verificare_card, success_verif_card, err_verif_card,
                        introdu_pin, verificare_pin, success_verif_pin, err_verif_pin, select_operation, 
                        err_select_operation, identify_operation, interogare_sold, retragere_numerar, 
                        verificare_sold_cont_and_atm, success_verif_sold,
                        err_verif_sold, substract_money_from_account_and_atm, exit_atm, depunere_numerar, 
                        verif_depunere_numerar, success_depunere_numerar, err_depunere_numerar, 
                        update_sold_cont_and_atm, modificare_pin, update_pin);
                        
    Signal state, next_state : state_type := idle;    -- state is the current state internal signal
    signal first_time : std_logic;
    
begin
    
    -- process for deciding the current state
    process(clk)
        begin
            if rising_edge (clk) then
                  if reset = '1' then state <= idle;
            else 
                  state <= next_state;
              end if;     
                

            end if;
     end process;
     
   -- process for deciding the ouputs in every state
 process( state )    
            
        begin
            enable_comp_pin <= '0';
            enable_comp_card <= '0';
            enable_comp_sold <= '0';
            enable_write_sold_cont <= '0';
            enable_write_sold_atm <= '0';
            enable_write_cont_pin <= '0';
            err_led <= '0';
            waiting_led <= '0';
            success_led <= '0';
            display_money <= '0';
            reset_display <= '0';
            first_time <= '0';
            enable_afisor_tip_bacnote <= '0';
            enable_verif_numerar_depus <= '0';
            enable_adress <= '0';
           depus_numerar <= '0';
           retras_numerar <= '0';
                case state is
                    when idle => waiting_led <= '1';
                    
                    when introdu_card => waiting_led <= '1';
                                         
                                        
                    when verificare_card => enable_adress <= '1';
                                            enable_comp_card <= '1';
                                            reset_display <= '1'; 
                                                
                    when success_verif_card => success_led <= '1';
                    
                    when err_verif_card => err_led <= '1';
                    
                    when introdu_pin => waiting_led <= '1'; 
                    
                    when verificare_pin => enable_comp_pin <= '1';
                                           --reset_display <= '1';
                    
                    when success_verif_pin => success_led <= '1';
                    
                    when err_verif_pin => err_led <= '1';
                    
                    when select_operation => waiting_led <= '1';
                                            
                    
                    when identify_operation => waiting_led <= '1';
                                               reset_display <= '1'; 
                                                                   
                    when err_select_operation => err_led <= '1';
                    
                    when interogare_sold => display_money <= '1';
                    
                    when retragere_numerar => waiting_led <= '1';
                    
                    when verificare_sold_cont_and_atm => enable_comp_sold <= '1';
                                                          first_time <= '0';
                                                                                             
                    when err_verif_sold => err_led <= '1';
                    
                    when success_verif_sold => success_led <= '1';
                    
                    when substract_money_from_account_and_atm => if first_time = '0' then 
                                                                 enable_write_sold_cont <= '1';                               
                                                                 enable_write_sold_atm <= '1';
                                                                 retras_numerar <= '1';
                                                                 first_time <= '1';
                                                                 end if;
                                                                 --enable_comp_sold <= '1';
                                                                 enable_afisor_tip_bacnote <= '1';
                                                                 
                   when depunere_numerar => waiting_led <= '1';
                   
                   when verif_depunere_numerar => enable_verif_numerar_depus <= '1';
                                                  first_time <= '0';
                                                  reset_display <= '1';
                   
                   when err_depunere_numerar => err_led <= '1';
                   
                   when success_depunere_numerar => success_led <= '1';
                   
                   when update_sold_cont_and_atm => if first_time = '0' then
                                                    enable_write_sold_atm <= '1';
                                                    enable_write_sold_cont <= '1';
                                                    depus_numerar <= '1';
                                                    first_time <= '1';
                                                    end if;
                   
                  when modificare_pin => waiting_led <= '1';
                                         first_time <= '1';
                                         
                  when update_pin => enable_write_cont_pin <= '1';
                                    
                  when exit_atm => null;
                  
                  when others => null;         
                                                                                           
                end case;  
   end process;     
   
            
   
     
     -- process for deciding the next state
 process( state, enter )      
          
	begin
		case state is
		
      --     idle, introdu_card, verificare_card, success_verif_card, err_verif_card,
      --     introdu_pin, verificare_pin, success_verif_pin, err_verif_pin, select_operation, 
      --     err_select_operation, identify_operation, interogare_sold, retragere_numerar, 
      --     verificare_sold_cont_and_atm, success_verif_sold,
      --     err_verif_sold, substract_money_from_account_and_atm, exit_atm, depunere_numerar, 
      --     update_sold_cont_and_atm, modificare_pin, next_state <= idle;
		    when idle => if enter = '0' then next_state <= idle;
		                      else next_state <= introdu_card;
		                 end if;
		                      
		    when introdu_card => if enter = '1'  then next_state <= verificare_card;
		                              else next_state <= introdu_card;
		                         end if;
		                         
		    when verificare_card => if card_found = '0' then next_state <= err_verif_card ;
		                                  else next_state <= success_verif_card;
		                            end if;
		                            
		    when err_verif_card => if err_done = '1' then next_state <= introdu_card;
		                                  else next_state <= err_verif_card;
		                           end if;
		                                                          
		    when success_verif_card => if success_done = '1' then next_state <= introdu_pin;
		                                  else next_state <= success_verif_card;
		                               end if;
		                            
		    when introdu_pin => if enter = '1'  then next_state <= verificare_pin;
		                              else next_state <= introdu_pin;
		                        end if;
		                        
		    when verificare_pin => if pin_found = '1' then next_state <= success_verif_pin;
		                                  else next_state <= err_verif_pin;
		                           end if;
		    
		    when err_verif_pin => if err_done = '1' then next_state <= introdu_pin;
		                                  else next_state <= err_verif_pin;
		                           end if;
		    
		    when success_verif_pin => if success_done = '1' then next_state <= select_operation;
		                                  else next_state <= success_verif_pin;
		                            end if;                                    
                       
            when select_operation => if enter = '1' then next_state <= identify_operation;
                                            else next_state <= select_operation;
                                      end if;       
             
            when identify_operation => if selected_operation = "0001" then next_state <= interogare_sold;
                                            elsif selected_operation = "0010" then next_state <= retragere_numerar;
                                            elsif selected_operation = "0011" then next_state <= depunere_numerar;
                                            elsif selected_operation = "0100" then next_state <= modificare_pin;
                                            elsif selected_operation = "0101" then next_state <= exit_atm;
                                            else next_state <= err_select_operation;
                                       end if;
                                       
            when err_select_operation => if err_done = '1' then next_state <= select_operation;
                                            else next_state <= err_select_operation;
                                         end if;
            
            when interogare_sold => if enter = '1' then next_state <= select_operation;
                                            else next_state <= interogare_sold;
                                    end if;
                                    
            when retragere_numerar => if enter = '1' then next_state <= verificare_sold_cont_and_atm;
                                            else next_state <= retragere_numerar;
                                     end if;
                                     
            when verificare_sold_cont_and_atm => if ok_sold = '1' then next_state <= success_verif_sold;
                                                 else next_state <= err_verif_sold;
                                             end if;
            when success_verif_sold => if success_done = '1' then next_state <= substract_money_from_account_and_atm;
                                                else next_state <= success_verif_sold;
                                       end if;
                                      
            when err_verif_sold => if err_done = '1' then next_state <= retragere_numerar;
                                            else next_state <= err_verif_sold;
                                   end if;                                             
         
            when substract_money_from_account_and_atm => if enter = '1' then next_state <= select_operation;
                                                                else next_state <= substract_money_from_account_and_atm;
                                                         end if;
                                                         
            when depunere_numerar => if enter = '1' then next_state <= verif_depunere_numerar ;
                                            else next_state <= depunere_numerar;
                                     end if;                                                   
            
            when verif_depunere_numerar => if ok_numerar_depus = '1' then next_state <= success_depunere_numerar;     
                                                else next_state <= err_depunere_numerar;
                                           end if;
                                                
            when success_depunere_numerar => if success_done = '1' then next_state  <= update_sold_cont_and_atm;
                                                    else next_state <= success_depunere_numerar;
                                              end if;   
            
            when err_depunere_numerar => if err_done = '1' then next_state <= depunere_numerar;
                                                    else next_state <= err_depunere_numerar;
                                         end if;
                                                    
            when update_sold_cont_and_atm => if enter = '1' then next_state <= select_operation;
                                                    else next_state <= update_sold_cont_and_atm;
                                             end if; 
                                             
            when modificare_pin => if enter = '1' then next_state <= update_pin;
                                            else next_state <= modificare_pin;
                                   end if;
                                   
            when update_pin => if enter = '1' then next_state <= select_operation;
                                        else next_state <= update_pin;
                               end if;
                               
            when exit_atm => if enter = '1' then next_state <= idle;
                                    else next_state <= exit_atm;
                             end if;
                                                                                                                                                                                                                                                                                                                                                      
		    when others => null;                                                                            
	end case;
	end process;

	 process(state)
	 	begin
	 		case state is
	 			when idle => current_state <= "00000";                  
	 			when introdu_card => current_state <= "00001";         
	 			when verificare_card => current_state <= "00010";      
	 			when success_verif_card => current_state <= "00011";
	 			when err_verif_card => current_state <= "00100";
	 			when introdu_pin => current_state <= "00101";
	 			when verificare_pin => current_state <= "00110";
	 			when success_verif_pin => current_state <= "00111";
	 			when err_verif_pin => current_state <= "01000";
	 			when select_operation => current_state <= "01001";
	 			when err_select_operation => current_state <= "01010";
	 			when identify_operation => current_state <= "01011";
	 			when interogare_sold => current_state <= "01100";
	 			when retragere_numerar => current_state <= "01101";
	 			when verificare_sold_cont_and_atm => current_state <= "01110";
	 			when success_verif_sold => current_state <= "01111";
	 			when err_verif_sold => current_state <= "10000";
	 			when substract_money_from_account_and_atm => current_state <= "10001";
	 			when exit_atm => current_state <= "10010";
	 			when depunere_numerar => current_state <= "10011";
	 			when verif_depunere_numerar => current_state <= "10100";
	 			when err_depunere_numerar => current_state <= "10101";
	 			when success_depunere_numerar => current_state <= "10110";
	 			when update_sold_cont_and_atm => current_state <= "10111";
	 			when modificare_pin => current_state <= "11000";
	 			when update_pin => current_state <= "11001";
	 			when others => current_state <= "11111";         
	 		end case;	
	 end process;	
end Behavioral;
