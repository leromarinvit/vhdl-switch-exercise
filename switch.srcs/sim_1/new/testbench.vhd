----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/17/2018 08:20:11 PM
-- Design Name: 
-- Module Name: testbench - Behavioral
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
use IEEE.STD_LOGIC_UNSIGNED.all;
use ieee.numeric_std.all;

use work.switch_constants.all;

entity testbench is
--  Port ( );
end testbench;

architecture Behavioral of testbench is
    constant T: time := 10 ns;

    signal clk: std_logic;
    signal test_in: std_logic_vector(WIDTH-1 downto 0);
    signal test_out: std_logic_array(1 to NUM_OUTPUTS);
    
    signal out1: std_logic_vector(WIDTH-1 downto 0) := test_out(1);
    signal out2: std_logic_vector(WIDTH-1 downto 0) := test_out(2);
    signal out3: std_logic_vector(WIDTH-1 downto 0) := test_out(3);
    signal out4: std_logic_vector(WIDTH-1 downto 0) := test_out(4);
    
begin

    out1 <= test_out(1);
    out2 <= test_out(2);
    out3 <= test_out(3);
    out4 <= test_out(4);

    sw: entity work.switch -- statt component-declaration; siehe
                           -- http://insights.sigasi.com/tech/four-and-half-ways-write-vhdl-instantiations.html
    generic map(
        WIDTH => WIDTH,
        NUM_OUTPUTS => NUM_OUTPUTS,
        PKT_LEN => PKT_LEN,
        PAUSE_LEN => PAUSE_LEN
    )
    port map(
        clk => clk,
        input => test_in,
        outputs => test_out
    );
    
    osc: process
    begin
        clk <= '1';
        wait for T/2;
        clk <= '0';
        wait for T/2;
    end process osc;
    
    Waveforms: process
        begin
            -- Daten versetzt zur clock bereitstellen, so dass bei steigender Flanke immer sichere Daten anliegen:
            -- 0 - 1/2 T: Clock_high; 1/2 T bis T: Clock_low
            wait for 3*T/4; -- in der Mitte der Clock_low Phase
            
            --! Nullbyte for der ersten Adresse
            test_in <= x"00";
            wait for T;

            --! Jeden Ausgang einzeln testen            
            for addr in 1 to 4 loop
                test_in <= std_logic_vector(to_unsigned(addr, test_in'length)); --  adresse, 1. Byte
                wait for T;
                for i in 0 to 19 loop -- payload, 20 Bytes
                    test_in <= std_logic_vector(to_unsigned(255-i, 8));
                    wait for T;
                end loop;
                for i in 1 to 10 loop -- 10 Pausen-Bytes
                    test_in <= x"00";
                    wait for T;
                end loop;
            end loop;

            --! Broadcast
            test_in <= x"FF"; --  adresse, 1. Byte
            wait for T;
            for i in 0 to 19 loop -- payload, 20 Bytes
                test_in <= std_logic_vector(to_unsigned(255-i, 8));
                wait for T;
            end loop;
            for i in 1 to 10 loop -- 10 Pausen-Bytes
                test_in <= x"00";
                wait for T;
            end loop;

            --! Test auf "falsche" Adressen
            test_in <= x"05"; --  adresse, 1. Byte
            wait for T;
            for i in 0 to 19 loop -- payload, 20 Bytes
                test_in <= std_logic_vector(to_unsigned(255-i, 8));
                wait for T;
            end loop;
            for i in 1 to 10 loop -- 10 Pausen-Bytes
                test_in <= x"00";
                wait for T;
            end loop;

            --! richtiges Paket nach falschem
            test_in <= x"02"; --  adresse, 1. Byte
            wait for T;
            for i in 0 to 19 loop -- payload, 20 Bytes
                test_in <= std_logic_vector(to_unsigned(255-i, 8));
                wait for T;
            end loop;
            for i in 1 to 10 loop -- 10 Pausen-Bytes
                test_in <= x"00";
                wait for T;
            end loop;

            -- Auslauf...
            wait for (2**WIDTH + 10) * T;
            -- und ende!
            assert false
            report "test finished" severity failure;
        end process Waveforms;

end Behavioral;
