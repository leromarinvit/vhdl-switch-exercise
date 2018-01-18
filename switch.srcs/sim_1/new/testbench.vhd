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

    sw: entity work.switch
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

end Behavioral;
