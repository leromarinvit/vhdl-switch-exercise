-- Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2017.2 (win64) Build 1909853 Thu Jun 15 18:39:09 MDT 2017
-- Date        : Thu Jan 18 21:00:03 2018
-- Host        : NB000473 running 64-bit Service Pack 1  (build 7601)
-- Command     : write_vhdl -mode funcsim -nolib -force -file
--               C:/fh/fpga/switch/switch.sim/sim_1/synth/func/testbench_func_synth.vhd
-- Design      : switch
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7a100tcsg324-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity switch is
  port (
    clk : in STD_LOGIC;
    input : in STD_LOGIC_VECTOR ( 7 downto 0 );
    \outputs[1]\ : out STD_LOGIC_VECTOR ( 7 downto 0 );
    \outputs[2]\ : out STD_LOGIC_VECTOR ( 7 downto 0 );
    \outputs[3]\ : out STD_LOGIC_VECTOR ( 7 downto 0 );
    \outputs[4]\ : out STD_LOGIC_VECTOR ( 7 downto 0 )
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of switch : entity is true;
  attribute NUM_OUTPUTS : integer;
  attribute NUM_OUTPUTS of switch : entity is 4;
  attribute PAUSE_LEN : integer;
  attribute PAUSE_LEN of switch : entity is 10;
  attribute PKT_LEN : integer;
  attribute PKT_LEN of switch : entity is 20;
  attribute WIDTH : integer;
  attribute WIDTH of switch : entity is 8;
end switch;

architecture STRUCTURE of switch is
begin
\outputs[1][0]_INST_0\: unisim.vcomponents.OBUF
     port map (
      I => '0',
      O => \outputs[1]\(0)
    );
\outputs[1][1]_INST_0\: unisim.vcomponents.OBUF
     port map (
      I => '0',
      O => \outputs[1]\(1)
    );
\outputs[1][2]_INST_0\: unisim.vcomponents.OBUF
     port map (
      I => '0',
      O => \outputs[1]\(2)
    );
\outputs[1][3]_INST_0\: unisim.vcomponents.OBUF
     port map (
      I => '0',
      O => \outputs[1]\(3)
    );
\outputs[1][4]_INST_0\: unisim.vcomponents.OBUF
     port map (
      I => '0',
      O => \outputs[1]\(4)
    );
\outputs[1][5]_INST_0\: unisim.vcomponents.OBUF
     port map (
      I => '0',
      O => \outputs[1]\(5)
    );
\outputs[1][6]_INST_0\: unisim.vcomponents.OBUF
     port map (
      I => '0',
      O => \outputs[1]\(6)
    );
\outputs[1][7]_INST_0\: unisim.vcomponents.OBUF
     port map (
      I => '0',
      O => \outputs[1]\(7)
    );
\outputs[2][0]_INST_0\: unisim.vcomponents.OBUF
     port map (
      I => '0',
      O => \outputs[2]\(0)
    );
\outputs[2][1]_INST_0\: unisim.vcomponents.OBUF
     port map (
      I => '0',
      O => \outputs[2]\(1)
    );
\outputs[2][2]_INST_0\: unisim.vcomponents.OBUF
     port map (
      I => '0',
      O => \outputs[2]\(2)
    );
\outputs[2][3]_INST_0\: unisim.vcomponents.OBUF
     port map (
      I => '0',
      O => \outputs[2]\(3)
    );
\outputs[2][4]_INST_0\: unisim.vcomponents.OBUF
     port map (
      I => '0',
      O => \outputs[2]\(4)
    );
\outputs[2][5]_INST_0\: unisim.vcomponents.OBUF
     port map (
      I => '0',
      O => \outputs[2]\(5)
    );
\outputs[2][6]_INST_0\: unisim.vcomponents.OBUF
     port map (
      I => '0',
      O => \outputs[2]\(6)
    );
\outputs[2][7]_INST_0\: unisim.vcomponents.OBUF
     port map (
      I => '0',
      O => \outputs[2]\(7)
    );
\outputs[3][0]_INST_0\: unisim.vcomponents.OBUF
     port map (
      I => '0',
      O => \outputs[3]\(0)
    );
\outputs[3][1]_INST_0\: unisim.vcomponents.OBUF
     port map (
      I => '0',
      O => \outputs[3]\(1)
    );
\outputs[3][2]_INST_0\: unisim.vcomponents.OBUF
     port map (
      I => '0',
      O => \outputs[3]\(2)
    );
\outputs[3][3]_INST_0\: unisim.vcomponents.OBUF
     port map (
      I => '0',
      O => \outputs[3]\(3)
    );
\outputs[3][4]_INST_0\: unisim.vcomponents.OBUF
     port map (
      I => '0',
      O => \outputs[3]\(4)
    );
\outputs[3][5]_INST_0\: unisim.vcomponents.OBUF
     port map (
      I => '0',
      O => \outputs[3]\(5)
    );
\outputs[3][6]_INST_0\: unisim.vcomponents.OBUF
     port map (
      I => '0',
      O => \outputs[3]\(6)
    );
\outputs[3][7]_INST_0\: unisim.vcomponents.OBUF
     port map (
      I => '0',
      O => \outputs[3]\(7)
    );
\outputs[4][0]_INST_0\: unisim.vcomponents.OBUF
     port map (
      I => '0',
      O => \outputs[4]\(0)
    );
\outputs[4][1]_INST_0\: unisim.vcomponents.OBUF
     port map (
      I => '0',
      O => \outputs[4]\(1)
    );
\outputs[4][2]_INST_0\: unisim.vcomponents.OBUF
     port map (
      I => '0',
      O => \outputs[4]\(2)
    );
\outputs[4][3]_INST_0\: unisim.vcomponents.OBUF
     port map (
      I => '0',
      O => \outputs[4]\(3)
    );
\outputs[4][4]_INST_0\: unisim.vcomponents.OBUF
     port map (
      I => '0',
      O => \outputs[4]\(4)
    );
\outputs[4][5]_INST_0\: unisim.vcomponents.OBUF
     port map (
      I => '0',
      O => \outputs[4]\(5)
    );
\outputs[4][6]_INST_0\: unisim.vcomponents.OBUF
     port map (
      I => '0',
      O => \outputs[4]\(6)
    );
\outputs[4][7]_INST_0\: unisim.vcomponents.OBUF
     port map (
      I => '0',
      O => \outputs[4]\(7)
    );
end STRUCTURE;
