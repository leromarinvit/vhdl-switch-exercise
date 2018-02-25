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

use work.switch_constants.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity testbench is
--  Port ( );
end testbench;

architecture Behavioral of testbench is
--    component switch is
--      generic (
--          NUM_OUTPUTS: integer;
--          PKT_LEN: integer;
--          PAUSE_LEN: integer
--        );
--        Port (
--          signal clk: in std_logic;
--          signal input: in std_logic_vector;
--          signal outputs: out std_logic_array(1 to NUM_OUTPUTS)
--        );
--    end component switch;
    
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
            
            -- Testdaten:
            test_in <= x"00"; -- erstes Byte (noch Ruhe auf der Leitung)
            wait for T;   
            test_in <= x"00"; -- zweites Byte
            wait for T;
            test_in <= x"04"; -- jetzt Adresse als Startbyte
            wait for T;
            test_in <= x"02"; -- Payload 1. Byte
            wait for T;
            test_in <= x"01"; -- Payload 2. Byte
            wait for T;
            test_in <= x"17"; -- usw...
            wait for T;
            test_in <= x"05";
            wait for T;
            test_in <= x"FF";
            wait for T;
            test_in <= x"00";
            wait for T;
            test_in <= x"EC";
            wait for T;
            test_in <= x"BA";
            wait for T;
            test_in <= x"03";
            wait for T;
            test_in <= x"08";
            wait for T;
            test_in <= x"33";
            wait for T;
            test_in <= x"45";
            wait for T;
            test_in <= x"AA";
            wait for T;
            test_in <= x"13";
            wait for T;
            test_in <= x"AC";
            wait for T;
            test_in <= x"AB";
            wait for T;
            test_in <= x"DE";
            wait for T;
            test_in <= x"AD";
            wait for T;
            test_in <= x"01"; -- 19. Payload-Byte (=20. Byte des Pakets)
            wait for T;
            test_in <= x"00"; -- Pause: jetzt muss mind 10 mal die "0" kommen
            wait for T;
            test_in <= x"00";
            wait for T;
            test_in <= x"00";
            wait for T;
            test_in <= x"00";
            wait for T;
            test_in <= x"00";
            wait for T;
            test_in <= x"00";
            wait for T;
            test_in <= x"00";
            wait for T;
            test_in <= x"00";
            wait for T;
            test_in <= x"00";
            wait for T;
            test_in <= x"00"; -- 10. Byte der Pause
            wait for T;
            test_in <= x"00";
            
            
            wait for (2**WIDTH + 10) * T;
            assert false
            report "test finished" severity failure;
        end process Waveforms;

end Behavioral;