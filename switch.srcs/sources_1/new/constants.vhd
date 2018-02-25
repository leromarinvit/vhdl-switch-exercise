----------------------------------------------------------------------------------
--! @file
--! @brief   Switch Constants
--! @author  Bernd Wacke
--! @author  Oliver Hanser
--! @details This file defines constants for the Switch project.
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

package switch_constants is

    constant NUM_OUTPUTS: integer := 4; --! Anzahl der Ausg�nge
    constant WIDTH: integer := 8;       --! Wortbreite
    
    constant PKT_LEN: integer := 20;    --! L�nge der Datenpakete
    constant PAUSE_LEN: integer := 10;  --! L�nge der Pause
    
    --! Array von std_logic_vector
    type std_logic_array is array(positive range <>) of std_logic_vector(WIDTH-1 downto 0);

end switch_constants;