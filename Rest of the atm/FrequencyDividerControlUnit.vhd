library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity FrequencyDividerControlUnit is
  port (
        clock100Mhz: in std_logic;
        reset : in std_logic;
        clockOut: out std_logic
    );
end FrequencyDividerControlUnit;

architecture TypeArchitecture OF FrequencyDividerControlUnit is

signal temp: std_logic := '0';
begin

    process(clock100Mhz)
        variable count: integer range 0 to 6_000_000 := 0; -- 6 milioane ar fi cel mai bine
        begin
            if rising_edge(clock100Mhz) then
                if reset = '0' then
                    count := 0;
                elsif count = (6_000_000 - 1) then
                    temp <= not temp;
                    count := 0;
                else 
                    count := count + 1;
                end if;
            end if;
            clockOut <= temp;
    end process;

end TypeArchitecture;