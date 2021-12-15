-- Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2021.1 (lin64) Build 3247384 Thu Jun 10 19:36:07 MDT 2021
-- Date        : Sun Dec 12 18:33:48 2021
-- Host        : pablo-MAX-G0101 running 64-bit Ubuntu 18.04.6 LTS
-- Command     : write_vhdl -force -mode synth_stub
--               /home/pablo/Documentos/02_Maestria_en_Sistemas_Embebidos/21_Sistemas_Digitales_para_las_Comunicaciones/workspace/MSE-SDC-Ejercicio11-Arty_A-35/MSE-SDC-Ejercicio11-Arty_A-35.gen/sources_1/ip/ila_0/ila_0_stub.vhdl
-- Design      : ila_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7a35ticsg324-1L
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ila_0 is
  Port ( 
    clk : in STD_LOGIC;
    probe0 : in STD_LOGIC_VECTOR ( 9 downto 0 );
    probe1 : in STD_LOGIC_VECTOR ( 9 downto 0 );
    probe2 : in STD_LOGIC_VECTOR ( 7 downto 0 );
    probe3 : in STD_LOGIC_VECTOR ( 0 to 0 )
  );

end ila_0;

architecture stub of ila_0 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clk,probe0[9:0],probe1[9:0],probe2[7:0],probe3[0:0]";
attribute x_core_info : string;
attribute x_core_info of stub : architecture is "ila,Vivado 2021.1";
begin
end;
