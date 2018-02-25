----------------------------------------------------------------------------------
--! @file
--! @brief   Switch
--! @author  Bernd Wacke
--! @author  Oliver Hanser
--! @details This file defines the switch entity.
----------------------------------------------------------------------------------


--! Use standard library
library IEEE;

--! Use std_lgoic functions
use IEEE.STD_LOGIC_1164.ALL;

--! Use constant definitions
use work.switch_constants.ALL;

--! Use numeric functions
use IEEE.NUMERIC_STD.ALL;


--! Switch entity

--! Diese Entity implementiert den Switch. Diverse Parameter werden als Generics
--! erst bei der Instanzierung angegeben.
entity switch is
  generic (
    WIDTH: integer := 8;        --! Wortbreite (parallel)
    NUM_OUTPUTS: integer := 4;  --! Anzahl der Ausgänge
    PKT_LEN: integer := 20;     --! Länge der Datenpakete
    PAUSE_LEN: integer := 10    --! Länge der Pause zwischen Paketen
  );
  Port (
    signal clk: in std_logic;                               --! Takt
    signal input: in std_logic_vector(WIDTH-1 downto 0);    --! Eingang
    signal outputs: out std_logic_array(1 to NUM_OUTPUTS)   --! Array von Ausgängen
  );
end switch;

--! Switch architecture

--! In dieser Architecture wird der Switch implementiert
architecture switch of switch is
    --! Adresse - mögliche Werte: 0 to 255 (für WIDTH=8)
    shared variable address: integer range 0 to ((2 ** input'length) - 1);
    --! Länge von Datenpaket + Pause - 1: 20 + 10 - 1 = 29 Bytes
    --! 1 Takt Abzug wegen Handshake über signal finished
    constant MAX: integer := PKT_LEN + PAUSE_LEN - 1;
    --! Broadcast-Adresse
    constant ADDR_MAX: integer := 2**WIDTH - 1;
    --! Datenpaket komplett übertragen
    signal finished: boolean := false;
begin

    --! read_start: speichert das erste Byte des Datenpakets als Zieladresse
    read_start: process(input, clk)
        --! Temporäre Adressvariable für Gültigkeitsprüfung
        variable temp_addr: integer range 0 to ((2 ** input'length) - 1);
        --! Letztes gelesenes Byte
        variable last_input: std_logic_vector(input'range);
        --! Vergleichswert aus lauter Nullbits
        variable zeros: std_logic_vector(input'range) := (others => '0');
        --! warten auf neue Daten - Adresse ist erstes Byte, danach wird listen auf false gesetzt
        variable listen: boolean := true;
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
    
    --! forward: leitet Daten am Eingang an selektierten Ausgang weiter
    --! Wenn address = ADDR_MAX, dann wird das Paket an alle Ausgänge gesendet
    --! Nach MAX Bytes wird finished = true gesetzt und remaining_bytes wieder
    --! auf MAX.
    forward: process(input, clk)
        --! Zähler für verbleibende Bytes in Datenpaket
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

end switch;
