--Copyright 1986-2021 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2021.1 (lin64) Build 3247384 Thu Jun 10 19:36:07 MDT 2021
--Date        : Sat Feb 12 12:52:29 2022
--Host        : pablo-MAX-G0101 running 64-bit Ubuntu 18.04.6 LTS
--Command     : generate_target system_wrapper.bd
--Design      : system_wrapper
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity system_wrapper is
  port (
    dip_switches_4bits_tri_i : in STD_LOGIC_VECTOR ( 3 downto 0 );
    led_4bits_tri_io : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    reset : in STD_LOGIC;
    rgb_led_tri_io : inout STD_LOGIC_VECTOR ( 11 downto 0 );
    sys_clock : in STD_LOGIC;
    usb_uart_rxd : in STD_LOGIC;
    usb_uart_txd : out STD_LOGIC
  );
end system_wrapper;

architecture STRUCTURE of system_wrapper is
  component system is
  port (
    sys_clock : in STD_LOGIC;
    reset : in STD_LOGIC;
    led_4bits_tri_i : in STD_LOGIC_VECTOR ( 3 downto 0 );
    led_4bits_tri_o : out STD_LOGIC_VECTOR ( 3 downto 0 );
    led_4bits_tri_t : out STD_LOGIC_VECTOR ( 3 downto 0 );
    dip_switches_4bits_tri_i : in STD_LOGIC_VECTOR ( 3 downto 0 );
    usb_uart_rxd : in STD_LOGIC;
    usb_uart_txd : out STD_LOGIC;
    rgb_led_tri_i : in STD_LOGIC_VECTOR ( 11 downto 0 );
    rgb_led_tri_o : out STD_LOGIC_VECTOR ( 11 downto 0 );
    rgb_led_tri_t : out STD_LOGIC_VECTOR ( 11 downto 0 )
  );
  end component system;
  component IOBUF is
  port (
    I : in STD_LOGIC;
    O : out STD_LOGIC;
    T : in STD_LOGIC;
    IO : inout STD_LOGIC
  );
  end component IOBUF;
  signal led_4bits_tri_i_0 : STD_LOGIC_VECTOR ( 0 to 0 );
  signal led_4bits_tri_i_1 : STD_LOGIC_VECTOR ( 1 to 1 );
  signal led_4bits_tri_i_2 : STD_LOGIC_VECTOR ( 2 to 2 );
  signal led_4bits_tri_i_3 : STD_LOGIC_VECTOR ( 3 to 3 );
  signal led_4bits_tri_io_0 : STD_LOGIC_VECTOR ( 0 to 0 );
  signal led_4bits_tri_io_1 : STD_LOGIC_VECTOR ( 1 to 1 );
  signal led_4bits_tri_io_2 : STD_LOGIC_VECTOR ( 2 to 2 );
  signal led_4bits_tri_io_3 : STD_LOGIC_VECTOR ( 3 to 3 );
  signal led_4bits_tri_o_0 : STD_LOGIC_VECTOR ( 0 to 0 );
  signal led_4bits_tri_o_1 : STD_LOGIC_VECTOR ( 1 to 1 );
  signal led_4bits_tri_o_2 : STD_LOGIC_VECTOR ( 2 to 2 );
  signal led_4bits_tri_o_3 : STD_LOGIC_VECTOR ( 3 to 3 );
  signal led_4bits_tri_t_0 : STD_LOGIC_VECTOR ( 0 to 0 );
  signal led_4bits_tri_t_1 : STD_LOGIC_VECTOR ( 1 to 1 );
  signal led_4bits_tri_t_2 : STD_LOGIC_VECTOR ( 2 to 2 );
  signal led_4bits_tri_t_3 : STD_LOGIC_VECTOR ( 3 to 3 );
  signal rgb_led_tri_i_0 : STD_LOGIC_VECTOR ( 0 to 0 );
  signal rgb_led_tri_i_1 : STD_LOGIC_VECTOR ( 1 to 1 );
  signal rgb_led_tri_i_10 : STD_LOGIC_VECTOR ( 10 to 10 );
  signal rgb_led_tri_i_11 : STD_LOGIC_VECTOR ( 11 to 11 );
  signal rgb_led_tri_i_2 : STD_LOGIC_VECTOR ( 2 to 2 );
  signal rgb_led_tri_i_3 : STD_LOGIC_VECTOR ( 3 to 3 );
  signal rgb_led_tri_i_4 : STD_LOGIC_VECTOR ( 4 to 4 );
  signal rgb_led_tri_i_5 : STD_LOGIC_VECTOR ( 5 to 5 );
  signal rgb_led_tri_i_6 : STD_LOGIC_VECTOR ( 6 to 6 );
  signal rgb_led_tri_i_7 : STD_LOGIC_VECTOR ( 7 to 7 );
  signal rgb_led_tri_i_8 : STD_LOGIC_VECTOR ( 8 to 8 );
  signal rgb_led_tri_i_9 : STD_LOGIC_VECTOR ( 9 to 9 );
  signal rgb_led_tri_io_0 : STD_LOGIC_VECTOR ( 0 to 0 );
  signal rgb_led_tri_io_1 : STD_LOGIC_VECTOR ( 1 to 1 );
  signal rgb_led_tri_io_10 : STD_LOGIC_VECTOR ( 10 to 10 );
  signal rgb_led_tri_io_11 : STD_LOGIC_VECTOR ( 11 to 11 );
  signal rgb_led_tri_io_2 : STD_LOGIC_VECTOR ( 2 to 2 );
  signal rgb_led_tri_io_3 : STD_LOGIC_VECTOR ( 3 to 3 );
  signal rgb_led_tri_io_4 : STD_LOGIC_VECTOR ( 4 to 4 );
  signal rgb_led_tri_io_5 : STD_LOGIC_VECTOR ( 5 to 5 );
  signal rgb_led_tri_io_6 : STD_LOGIC_VECTOR ( 6 to 6 );
  signal rgb_led_tri_io_7 : STD_LOGIC_VECTOR ( 7 to 7 );
  signal rgb_led_tri_io_8 : STD_LOGIC_VECTOR ( 8 to 8 );
  signal rgb_led_tri_io_9 : STD_LOGIC_VECTOR ( 9 to 9 );
  signal rgb_led_tri_o_0 : STD_LOGIC_VECTOR ( 0 to 0 );
  signal rgb_led_tri_o_1 : STD_LOGIC_VECTOR ( 1 to 1 );
  signal rgb_led_tri_o_10 : STD_LOGIC_VECTOR ( 10 to 10 );
  signal rgb_led_tri_o_11 : STD_LOGIC_VECTOR ( 11 to 11 );
  signal rgb_led_tri_o_2 : STD_LOGIC_VECTOR ( 2 to 2 );
  signal rgb_led_tri_o_3 : STD_LOGIC_VECTOR ( 3 to 3 );
  signal rgb_led_tri_o_4 : STD_LOGIC_VECTOR ( 4 to 4 );
  signal rgb_led_tri_o_5 : STD_LOGIC_VECTOR ( 5 to 5 );
  signal rgb_led_tri_o_6 : STD_LOGIC_VECTOR ( 6 to 6 );
  signal rgb_led_tri_o_7 : STD_LOGIC_VECTOR ( 7 to 7 );
  signal rgb_led_tri_o_8 : STD_LOGIC_VECTOR ( 8 to 8 );
  signal rgb_led_tri_o_9 : STD_LOGIC_VECTOR ( 9 to 9 );
  signal rgb_led_tri_t_0 : STD_LOGIC_VECTOR ( 0 to 0 );
  signal rgb_led_tri_t_1 : STD_LOGIC_VECTOR ( 1 to 1 );
  signal rgb_led_tri_t_10 : STD_LOGIC_VECTOR ( 10 to 10 );
  signal rgb_led_tri_t_11 : STD_LOGIC_VECTOR ( 11 to 11 );
  signal rgb_led_tri_t_2 : STD_LOGIC_VECTOR ( 2 to 2 );
  signal rgb_led_tri_t_3 : STD_LOGIC_VECTOR ( 3 to 3 );
  signal rgb_led_tri_t_4 : STD_LOGIC_VECTOR ( 4 to 4 );
  signal rgb_led_tri_t_5 : STD_LOGIC_VECTOR ( 5 to 5 );
  signal rgb_led_tri_t_6 : STD_LOGIC_VECTOR ( 6 to 6 );
  signal rgb_led_tri_t_7 : STD_LOGIC_VECTOR ( 7 to 7 );
  signal rgb_led_tri_t_8 : STD_LOGIC_VECTOR ( 8 to 8 );
  signal rgb_led_tri_t_9 : STD_LOGIC_VECTOR ( 9 to 9 );
begin
led_4bits_tri_iobuf_0: component IOBUF
     port map (
      I => led_4bits_tri_o_0(0),
      IO => led_4bits_tri_io(0),
      O => led_4bits_tri_i_0(0),
      T => led_4bits_tri_t_0(0)
    );
led_4bits_tri_iobuf_1: component IOBUF
     port map (
      I => led_4bits_tri_o_1(1),
      IO => led_4bits_tri_io(1),
      O => led_4bits_tri_i_1(1),
      T => led_4bits_tri_t_1(1)
    );
led_4bits_tri_iobuf_2: component IOBUF
     port map (
      I => led_4bits_tri_o_2(2),
      IO => led_4bits_tri_io(2),
      O => led_4bits_tri_i_2(2),
      T => led_4bits_tri_t_2(2)
    );
led_4bits_tri_iobuf_3: component IOBUF
     port map (
      I => led_4bits_tri_o_3(3),
      IO => led_4bits_tri_io(3),
      O => led_4bits_tri_i_3(3),
      T => led_4bits_tri_t_3(3)
    );
rgb_led_tri_iobuf_0: component IOBUF
     port map (
      I => rgb_led_tri_o_0(0),
      IO => rgb_led_tri_io(0),
      O => rgb_led_tri_i_0(0),
      T => rgb_led_tri_t_0(0)
    );
rgb_led_tri_iobuf_1: component IOBUF
     port map (
      I => rgb_led_tri_o_1(1),
      IO => rgb_led_tri_io(1),
      O => rgb_led_tri_i_1(1),
      T => rgb_led_tri_t_1(1)
    );
rgb_led_tri_iobuf_10: component IOBUF
     port map (
      I => rgb_led_tri_o_10(10),
      IO => rgb_led_tri_io(10),
      O => rgb_led_tri_i_10(10),
      T => rgb_led_tri_t_10(10)
    );
rgb_led_tri_iobuf_11: component IOBUF
     port map (
      I => rgb_led_tri_o_11(11),
      IO => rgb_led_tri_io(11),
      O => rgb_led_tri_i_11(11),
      T => rgb_led_tri_t_11(11)
    );
rgb_led_tri_iobuf_2: component IOBUF
     port map (
      I => rgb_led_tri_o_2(2),
      IO => rgb_led_tri_io(2),
      O => rgb_led_tri_i_2(2),
      T => rgb_led_tri_t_2(2)
    );
rgb_led_tri_iobuf_3: component IOBUF
     port map (
      I => rgb_led_tri_o_3(3),
      IO => rgb_led_tri_io(3),
      O => rgb_led_tri_i_3(3),
      T => rgb_led_tri_t_3(3)
    );
rgb_led_tri_iobuf_4: component IOBUF
     port map (
      I => rgb_led_tri_o_4(4),
      IO => rgb_led_tri_io(4),
      O => rgb_led_tri_i_4(4),
      T => rgb_led_tri_t_4(4)
    );
rgb_led_tri_iobuf_5: component IOBUF
     port map (
      I => rgb_led_tri_o_5(5),
      IO => rgb_led_tri_io(5),
      O => rgb_led_tri_i_5(5),
      T => rgb_led_tri_t_5(5)
    );
rgb_led_tri_iobuf_6: component IOBUF
     port map (
      I => rgb_led_tri_o_6(6),
      IO => rgb_led_tri_io(6),
      O => rgb_led_tri_i_6(6),
      T => rgb_led_tri_t_6(6)
    );
rgb_led_tri_iobuf_7: component IOBUF
     port map (
      I => rgb_led_tri_o_7(7),
      IO => rgb_led_tri_io(7),
      O => rgb_led_tri_i_7(7),
      T => rgb_led_tri_t_7(7)
    );
rgb_led_tri_iobuf_8: component IOBUF
     port map (
      I => rgb_led_tri_o_8(8),
      IO => rgb_led_tri_io(8),
      O => rgb_led_tri_i_8(8),
      T => rgb_led_tri_t_8(8)
    );
rgb_led_tri_iobuf_9: component IOBUF
     port map (
      I => rgb_led_tri_o_9(9),
      IO => rgb_led_tri_io(9),
      O => rgb_led_tri_i_9(9),
      T => rgb_led_tri_t_9(9)
    );
system_i: component system
     port map (
      dip_switches_4bits_tri_i(3 downto 0) => dip_switches_4bits_tri_i(3 downto 0),
      led_4bits_tri_i(3) => led_4bits_tri_i_3(3),
      led_4bits_tri_i(2) => led_4bits_tri_i_2(2),
      led_4bits_tri_i(1) => led_4bits_tri_i_1(1),
      led_4bits_tri_i(0) => led_4bits_tri_i_0(0),
      led_4bits_tri_o(3) => led_4bits_tri_o_3(3),
      led_4bits_tri_o(2) => led_4bits_tri_o_2(2),
      led_4bits_tri_o(1) => led_4bits_tri_o_1(1),
      led_4bits_tri_o(0) => led_4bits_tri_o_0(0),
      led_4bits_tri_t(3) => led_4bits_tri_t_3(3),
      led_4bits_tri_t(2) => led_4bits_tri_t_2(2),
      led_4bits_tri_t(1) => led_4bits_tri_t_1(1),
      led_4bits_tri_t(0) => led_4bits_tri_t_0(0),
      reset => reset,
      rgb_led_tri_i(11) => rgb_led_tri_i_11(11),
      rgb_led_tri_i(10) => rgb_led_tri_i_10(10),
      rgb_led_tri_i(9) => rgb_led_tri_i_9(9),
      rgb_led_tri_i(8) => rgb_led_tri_i_8(8),
      rgb_led_tri_i(7) => rgb_led_tri_i_7(7),
      rgb_led_tri_i(6) => rgb_led_tri_i_6(6),
      rgb_led_tri_i(5) => rgb_led_tri_i_5(5),
      rgb_led_tri_i(4) => rgb_led_tri_i_4(4),
      rgb_led_tri_i(3) => rgb_led_tri_i_3(3),
      rgb_led_tri_i(2) => rgb_led_tri_i_2(2),
      rgb_led_tri_i(1) => rgb_led_tri_i_1(1),
      rgb_led_tri_i(0) => rgb_led_tri_i_0(0),
      rgb_led_tri_o(11) => rgb_led_tri_o_11(11),
      rgb_led_tri_o(10) => rgb_led_tri_o_10(10),
      rgb_led_tri_o(9) => rgb_led_tri_o_9(9),
      rgb_led_tri_o(8) => rgb_led_tri_o_8(8),
      rgb_led_tri_o(7) => rgb_led_tri_o_7(7),
      rgb_led_tri_o(6) => rgb_led_tri_o_6(6),
      rgb_led_tri_o(5) => rgb_led_tri_o_5(5),
      rgb_led_tri_o(4) => rgb_led_tri_o_4(4),
      rgb_led_tri_o(3) => rgb_led_tri_o_3(3),
      rgb_led_tri_o(2) => rgb_led_tri_o_2(2),
      rgb_led_tri_o(1) => rgb_led_tri_o_1(1),
      rgb_led_tri_o(0) => rgb_led_tri_o_0(0),
      rgb_led_tri_t(11) => rgb_led_tri_t_11(11),
      rgb_led_tri_t(10) => rgb_led_tri_t_10(10),
      rgb_led_tri_t(9) => rgb_led_tri_t_9(9),
      rgb_led_tri_t(8) => rgb_led_tri_t_8(8),
      rgb_led_tri_t(7) => rgb_led_tri_t_7(7),
      rgb_led_tri_t(6) => rgb_led_tri_t_6(6),
      rgb_led_tri_t(5) => rgb_led_tri_t_5(5),
      rgb_led_tri_t(4) => rgb_led_tri_t_4(4),
      rgb_led_tri_t(3) => rgb_led_tri_t_3(3),
      rgb_led_tri_t(2) => rgb_led_tri_t_2(2),
      rgb_led_tri_t(1) => rgb_led_tri_t_1(1),
      rgb_led_tri_t(0) => rgb_led_tri_t_0(0),
      sys_clock => sys_clock,
      usb_uart_rxd => usb_uart_rxd,
      usb_uart_txd => usb_uart_txd
    );
end STRUCTURE;
