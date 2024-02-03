 library IEEE;
    use IEEE.STD_LOGIC_1164.ALL;
    
    -- Uncomment the following library declaration if using
    -- arithmetic functions with Signed or Unsigned values
    --use IEEE.NUMERIC_STD.ALL;
    
    -- Uncomment the following library declaration if instantiating
    -- any Xilinx leaf cells in this code.
    --library UNISIM;
    --use UNISIM.VComponents.all;
    
    entity my_button_controller is
     Port ( button_left, button_right, button_down,button_up, RESET: in std_logic; 
            digit1, digit2, digit3, digit4 : out std_logic_vector(3 downto 0)
     );
    end my_button_controller;
    
architecture Behavioral of my_button_controller is
    
    Component counter_left_right
          Port ( reset,  button_left, button_right : in std_logic;
                  afisor_select : out std_logic_vector(1 downto 0)
          );
    end component;
    
    Component counter_up_down
      Port (reset, clk, up, enable : in std_logic;
            digit_output : out std_logic_vector(3 downto 0)
            );
    end component;
    
    Component DMUX
      Port ( sel : in std_logic_vector(1 downto 0);
             enable_1, enable_2, enable_3, enable_4 : out std_logic
             );
    end component;
        
      component clock_up_down_testare_vlod   
      Port(button_down, button_up : in std_logic;
        clk_out, up: out std_logic
        );
        end component;
            
       signal afisor_select : std_logic_vector(1 downto 0);
       signal enable_1, enable_2, enable_3, enable_4 : std_logic;
       signal clocc, upp: std_logic;
            
                      
    begin
    
        DMUX1 : DMUX port map (sel => afisor_select, enable_1 => enable_1, enable_2 => enable_2, enable_3 => enable_3, enable_4 => enable_4);
        Counter_afisor : counter_left_right port map (reset => RESET, button_left => button_left, button_right => button_right, afisor_select => afisor_select);
        UPorDOWN: clock_up_down_testare_vlod port map(button_down => button_down, button_up => button_up, clk_out => clocc, up => upp );
        Afisor_1 : counter_up_down port map (reset => RESET,clk => clocc, up => upp , enable => enable_1, digit_output => digit1 );
        Afisor_2 : counter_up_down port map (reset => RESET, clk => clocc, up => upp,  enable => enable_2, digit_output => digit2 );
        Afisor_3 : counter_up_down port map (reset => RESET, clk => clocc, up => upp,  enable => enable_3, digit_output => digit3 );
        Afisor_4 : counter_up_down port map (reset => RESET, clk => clocc, up => upp, enable => enable_4, digit_output => digit4 );
           
    end Behavioral;