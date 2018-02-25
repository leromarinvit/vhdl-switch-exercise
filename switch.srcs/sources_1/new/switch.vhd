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

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

package switch_types is
    generic(
        WIDTH: integer; -- Datenbreite (Bits)
        NUM_PORTS: integer -- Anzahl der Ausgänge
    );
    subtype word is std_logic_vector(WIDTH-1 downto 0);
    type word_array is array (1 to NUM_PORTS) of word; 
end package;


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use work.switch_constants.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

entity switch is
  generic (
    --type word;
    --type word_array;
    WIDTH: integer := 8;
    NUM_OUTPUTS: integer := 4;
    PKT_LEN: integer := 20;
    PAUSE_LEN: integer := 10
  );
  Port (
    signal clk: in std_logic;
    signal input: in std_logic_vector(WIDTH-1 downto 0);
    signal outputs: out std_logic_array(1 to NUM_OUTPUTS)
    --signal outputs: out array of t(1 to NUM_OUTPUTS)
    --signal outputs: out word_array
  );
end switch;

architecture Behavioral of switch is
    signal address: integer range 0 to ((2 ** input'length) - 1); -- mögliche Werte: 0 to 255
    signal listen: boolean := true; -- warten auf neue Daten - Adresse ist erstes Byte, danach wird listen auf false gesetzt
    constant MAX: integer := PKT_LEN + PAUSE_LEN; -- 20 + 10 = 30 Bytes
    signal remaining_bits: integer range 0 to MAX := MAX;
    signal finished: boolean := false;
begin

    -- read_start: speichert das erste Byte des Datenpakets als Zieladresse
    read_start: process(input)
        variable last_input: std_logic_vector(input'range);
        variable zeros: std_logic_vector(input'range) := (others => '0');
    begin
        if rising_edge(clk) then
            if input /= zeros and last_input = zeros and listen then
                address <= to_integer(unsigned(input));
                listen <= false;
            elsif finished then
                listen <= true;
                address <= 0;
            end if;
            last_input := input;
        end if;
    end process read_start;
    
    forward: process(input, clk)
    begin
        if clk'event and clk = '1' then
            for i in 1 to NUM_OUTPUTS loop
                outputs(i) <= (others => '0');
            end loop;
            if address >= 1 and address <= NUM_OUTPUTS then
                finished <= false;
                outputs(address) <= input;
            elsif address = 255 then
                for i in 1 to NUM_OUTPUTS loop
                    outputs(i) <= input;
                end loop;
            end if;
            remaining_bits <= remaining_bits - 1;
            if remaining_bits = 0 then
                finished <= true;
                remaining_bits <= MAX;
            end if;
        end if;
    end process forward;

end Behavioral;
