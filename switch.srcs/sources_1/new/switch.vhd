----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/17/2018 06:41:07 PM
-- Design Name: 
-- Module Name: switch - Behavioral
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

use work.switch_constants.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

entity switch is
  generic (
    WIDTH: integer := 8;
    NUM_OUTPUTS: integer := 4;
    PKT_LEN: integer := 20;
    PAUSE_LEN: integer := 10
  );
  Port (
    signal clk: in std_logic;
    signal input: in std_logic_vector(WIDTH-1 downto 0);
    signal outputs: out std_logic_array(1 to NUM_OUTPUTS)
  );
end switch;

architecture Behavioral of switch is
    shared variable address: integer range 0 to ((2 ** input'length) - 1); -- m�gliche Werte: 0 to 255
    constant MAX: integer := PKT_LEN + PAUSE_LEN - 1; -- 20 + 10 = 30 Bytes
    constant ADDR_MAX: integer := 2**WIDTH - 1;
    signal finished: boolean := false;
begin

    -- read_start: speichert das erste Byte des Datenpakets als Zieladresse
    read_start: process(input, clk)
        variable temp_addr: integer range 0 to ((2 ** input'length) - 1); -- m�gliche Werte: 0 to 255
        variable last_input: std_logic_vector(input'range);
        variable zeros: std_logic_vector(input'range) := (others => '0');
        variable listen: boolean := true; -- warten auf neue Daten - Adresse ist erstes Byte, danach wird listen auf false gesetzt
    begin
        if rising_edge(clk) then
            if input /= zeros and last_input = zeros and listen then
                temp_addr := to_integer(unsigned(input));
                if temp_addr <= NUM_OUTPUTS or temp_addr = ADDR_MAX then
                    address := temp_addr;
                    listen := false;
                end if;
            elsif finished then
                listen := true;
                address := 0;
            end if;
            last_input := input;
        end if;
    end process read_start;
    
    forward: process(input, clk)
        variable remaining_bytes: integer range 0 to MAX := MAX;
    begin
        if clk'event and clk = '1' then
            for i in 1 to NUM_OUTPUTS loop
                outputs(i) <= (others => '0');
            end loop;
            if address >= 1 and address <= NUM_OUTPUTS then
                finished <= false;
                outputs(address) <= input;
            elsif address = ADDR_MAX then
                finished <= false;
                for i in 1 to NUM_OUTPUTS loop
                    outputs(i) <= input;
                end loop;
            end if;
            if address > 0 then
                remaining_bytes := remaining_bytes - 1;
            end if;
            if remaining_bytes = 0 then
                finished <= true;
                remaining_bytes := MAX;
            end if;
        end if;
    end process forward;

end Behavioral;
