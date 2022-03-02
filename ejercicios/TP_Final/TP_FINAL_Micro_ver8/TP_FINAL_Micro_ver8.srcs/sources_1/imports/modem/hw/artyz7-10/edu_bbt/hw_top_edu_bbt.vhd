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
    clk_i           : in  std_logic;                    --system clock --> duda --> sys_clock : in STD_LOGIC;
    reset           : in  STD_LOGIC;
    led_o           : inout std_logic_vector(3 downto 0);
    btn             : in STD_LOGIC_VECTOR ( 3 downto 0 );
    sw              : in STD_LOGIC_VECTOR ( 3 downto 0 );
    rgb_led_tri_io  : inout STD_LOGIC_VECTOR ( 11 downto 0 );
    usb_rxd_out     : in STD_LOGIC;
    usb_txd_in      : out STD_LOGIC
  );
end entity hw_top_edu_bbt;

  
-- architecture
architecture rtl of hw_top_edu_bbt is

 COMPONENT system_wrapper 
  port (
    arst_o : out STD_LOGIC_VECTOR ( 0 to 0 );
    dip_switches_4bits_tri_i : in STD_LOGIC_VECTOR ( 3 downto 0 );
    led_4bits_tri_io : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    locked_microblaze : in STD_LOGIC;
    mn1_bytes_microblaze : out STD_LOGIC_VECTOR ( 7 downto 0 );
    mn1_pre_microblaze : out STD_LOGIC_VECTOR ( 7 downto 0 );
    push_buttons_4bits_tri_i : in STD_LOGIC_VECTOR ( 3 downto 0 );
    reset : in STD_LOGIC;
    rgb_led_tri_io : inout STD_LOGIC_VECTOR ( 11 downto 0 );
    selector_sw : out STD_LOGIC_VECTOR ( 0 to 0 );
    sigma_microblaze : out STD_LOGIC_VECTOR ( 15 downto 0 );
    sys_clock : in STD_LOGIC;
    usb_uart_rxd : in STD_LOGIC;
    usb_uart_txd : out STD_LOGIC
  );
 END COMPONENT;
 
 COMPONENT top_edu_bbt 
  port(
    clk_i           : in  std_logic;                    --system clock
    arst_i          : in  std_logic;                    --ascynchronous reset
    canal_rx_i      : in  std_logic;                    --receive pin
    canal_tx_o      : out std_logic;
    mn1_bytes_u_top : in std_logic_vector( 7 downto 0);
 	mn1_pre_u_top   : in std_logic_vector( 7 downto 0);
	sigma_u_top: in std_logic_vector( 15 downto 0);
	selector_sw_u_top : in  std_logic
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
    clk_out2          : out    std_logic; -- 100 MHz
    -- Status and control signals
    resetn              : in     std_logic;
    locked            : out    std_logic;
    clk_in1           : in     std_logic  -- 125 MHz
   );
  end component;

  -- ---------------------------------------------------------
  -- SIGNALś
    -- ---------------------------------------------------------
  signal clk_s        : std_logic;
  signal clk_locked_s : std_logic;

  signal rx_canal_s      : std_logic_vector(0 downto 0);
  signal tx_canal_s      : std_logic_vector(0 downto 0);

  signal clk_out2_s     : std_logic;       -- 100 MHz Miccroblaze
  signal arst_i_s       : STD_LOGIC;
  
  --signal led_o_s        : std_logic_vector(3 downto 0);
  signal led_4bits_tri_o_s : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal  rgb_led_tri_o_s  : STD_LOGIC_VECTOR ( 11 downto 0 );
  
   -- ---------------------------------------------------------------------------
  -- Switch Signals
  -- ---------------------------------------------------------------------------
  signal selector_sw_s      : std_logic_vector(0 to 0):="1";    -- Por default se comunica el Microblaze
  signal tx_microblaze_s    : std_logic;
  signal rx_microblaze_s    : std_logic_vector(0 downto 0);
  signal mn1_bytes_microblaze_s     : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal mn1_pre_microblaze_s       : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal sigma_microblaze_s         : STD_LOGIC_VECTOR ( 15 downto 0 );

begin

  u_clk_mmcm : clk_wiz_0
  port map (
    -- Clock out ports
    clk_out1 => clk_s,
    clk_out2 => clk_out2_s,
    -- Status and control signals
    resetn    => reset,
    locked   => clk_locked_s,
    -- Clock in ports
    clk_in1  => clk_i
  );

  u_top : top_edu_bbt
  port map
  (
    clk_i  => clk_s,
    arst_i => arst_i_s ,
    canal_rx_i   => rx_canal_s(0),
    canal_tx_o   => tx_canal_s(0),
    mn1_bytes_u_top=> mn1_bytes_microblaze_s,
 	mn1_pre_u_top  => mn1_pre_microblaze_s,
	sigma_u_top    => sigma_microblaze_s,
	selector_sw_u_top => selector_sw_s(0)
  );
  

  led_o <= led_4bits_tri_o_s;
  rgb_led_tri_io <= rgb_led_tri_o_s;
  
  u_system_wrapper: system_wrapper
  PORT MAP(
    arst_o(0) => arst_i_s,
    dip_switches_4bits_tri_i => sw,
    led_4bits_tri_io  => led_o,
    mn1_bytes_microblaze => mn1_bytes_microblaze_s,
    mn1_pre_microblaze=>  mn1_pre_microblaze_s,
    push_buttons_4bits_tri_i => btn,
    reset => reset,                           
    rgb_led_tri_io => rgb_led_tri_io,
    selector_sw => selector_sw_s,
    sigma_microblaze => sigma_microblaze_s,
    sys_clock => clk_out2_s,
    locked_microblaze => clk_locked_s ,
    usb_uart_rxd => rx_microblaze_s(0),
    usb_uart_txd => tx_microblaze_s
  );

   -- ---------------------------------------------------------------------------
   -- Switch 
   -- Si selector_sw_s=0 se comunica el canal
   -- Si selector_sw_s=1 se comunica el microblasze
   -- ---------------------------------------------------------------------------
   -- ---------------------------------------------------------------------------
   -- Switch de salida 
   -- ---------------------------------------------------------------------------
   u_sw_out : process(selector_sw_s,tx_canal_s,tx_microblaze_s)
   begin
     if (selector_sw_s(0)='0') then
        usb_txd_in <= tx_canal_s(0);
     else
        usb_txd_in <=tx_microblaze_s;
     end if;
   end process;
    -- ---------------------------------------------------------------------------
   -- Switch de entrada--> por ahora deshabilite este switch
   -- ---------------------------------------------------------------------------
   rx_canal_s(0) <= usb_rxd_out ;
   rx_microblaze_s(0) <= usb_rxd_out;
--   u_sw_in : process(selector_sw_s)
--   begin
--     if (selector_sw_s(0)='0') then
--        rx_canal_s(0) <= usb_rxd_out ;
--        rx_microblaze_s(0) <= '0' ;
--     else
--        rx_canal_s(0)<= '0' ;
--        rx_microblaze_s(0) <= usb_rxd_out;
--     end if;
--   end process;

end architecture;

