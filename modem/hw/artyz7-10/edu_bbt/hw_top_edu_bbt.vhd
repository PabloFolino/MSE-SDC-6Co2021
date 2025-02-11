-- libraries
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.pkg_edu_bbt.all;

Library UNISIM;
use UNISIM.vcomponents.all;

-- entity
entity hw_top_edu_bbt is
  port(
    clk_i   : in  std_logic;                    --system clock
    arst_i  : in  std_logic;                    --ascynchronous reset
    rx_i    : in  std_logic;                    --receive pin
    tx_o    : out std_logic;
    led_o   : out std_logic_vector(3 downto 0);
    push_buttons_4bits_tri_i : in STD_LOGIC_VECTOR ( 3 downto 0 );
    dip_switches_4bits_tri_i : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rgb_led_tri_io : inout STD_LOGIC_VECTOR ( 11 downto 0 );
    usb_uart_rxd : in STD_LOGIC;
    usb_uart_txd : out STD_LOGIC
  );
end entity hw_top_edu_bbt;

-- architecture
architecture rtl of hw_top_edu_bbt is

 COMPONENT system_wrapper 
  port (
    dip_switches_4bits_tri_i : in STD_LOGIC_VECTOR ( 3 downto 0 );
    led_4bits_tri_io : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    push_buttons_4bits_tri_i : in STD_LOGIC_VECTOR ( 3 downto 0 );
    reset : in STD_LOGIC;
    rgb_led_tri_io : inout STD_LOGIC_VECTOR ( 11 downto 0 );
    sys_clock : in STD_LOGIC;
    usb_uart_rxd : in STD_LOGIC;
    usb_uart_txd : out STD_LOGIC
  );
 END COMPONENT;
 
  COMPONENT ila_0
  PORT (
    clk : IN STD_LOGIC;
    probe0 : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    probe1 : IN STD_LOGIC_VECTOR(0 DOWNTO 0)
  );
  END COMPONENT;

  component clk_wiz_0
  port (
    -- Clock in ports
    -- Clock out ports
    clk_out1          : out    std_logic; -- 16 MHz
    -- Status and control signals
    reset             : in     std_logic;
    locked            : out    std_logic;
    clk_in1           : in     std_logic  -- 125 MHz
   );
  end component;

  signal clk_s        : std_logic;
  signal clk_locked_s : std_logic;

  signal rx_s : std_logic_vector(0 downto 0);
  signal tx_s : std_logic_vector(0 downto 0);

  --signal counter_s : std_logic_vector(26 downto 0);
  signal led_o_s : std_logic_vector(3 downto 0);
begin

--  u_blinky : process(clk_s,arst_i)
--  begin
 
--    if arst_i = '1' then
--      counter_s <= (others => '0');
--    elsif rising_edge(clk_s) then
--      counter_s <= std_logic_vector(unsigned(counter_s)+1);
--    end if;
--  end process;
 
--  led_o <= counter_s(26 downto 23);

  u_clk_mmcm : clk_wiz_0
  port map (
    -- Clock out ports
    clk_out1 => clk_s,
    -- Status and control signals
    reset    => arst_i,
    locked   => clk_locked_s,
    -- Clock in ports
    clk_in1  => clk_i
  );
  -- clk_s <= clk_i;

  u_top : top_edu_bbt
  port map
  (
    clk_i  => clk_s,
    arst_i => arst_i,
    rx_i   => rx_i,
    tx_o   => tx_o
    -- rx_i   => rx_s(0),
    -- tx_o   => tx_s(0)
  );
  
  
  led_o <= led_o_s;
  
  u_system_wrapper: system_wrapper
  PORT MAP(
    dip_switches_4bits_tri_i => dip_switches_4bits_tri_i,
    led_4bits_tri_io => led_o_s,
    push_buttons_4bits_tri_i => push_buttons_4bits_tri_i,
    reset => arst_i,
    rgb_led_tri_io => rgb_led_tri_io,
    sys_clock => clk_i ,
    usb_uart_rxd=> usb_uart_rxd,
    usb_uart_txd => usb_uart_txd
  );

  -- rx_s(0) <= rx_i;
  -- tx_o    <= tx_s(0);
  -- u_ila0 : ila_0
  -- port map (
  --   clk    => clk_s,
  --   probe0 => rx_s,
  --   probe1 => tx_s
  -- );

end architecture;

