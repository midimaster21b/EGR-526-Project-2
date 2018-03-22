----------------------------------------------------------------------------------
-- Company:
-- Engineer: Joshua Edgcombe
--
-- Create Date: 03/11/2018 05:22:28 PM
-- Design Name: WarioWare - Space Fighter
-- Module Name: ProjectTwo_top - Behavioral
-- Project Name: EGR 526: Project 2
-- Target Devices: xc7a35tcpg236-1
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ProjectTwo_top is
  Port(clk_100MHz,reset, left_btn, right_btn, up_btn, down_btn : in STD_LOGIC;

       HSYNC, VSYNC, locked : out STD_LOGIC;
       Red_Out, Green_Out, Blue_Out : out STD_LOGIC_Vector (3 downto 0));
end ProjectTwo_top;

architecture Behavioral of ProjectTwo_top is

  component clk_wiz_0
    port(clk_in1,reset : in std_logic; clk_out1,locked : out std_logic);
  end component;

  component vga_controller_640_60 is
    port(rst,pixel_clk : in std_logic; HS,VS,blank : out std_logic;
         hcount,vcount : out std_logic_vector(10 downto 0));
  end component;

  component static_background is
    Port (hcount,vcount : in STD_LOGIC_VECTOR(10 downto 0); blank : in STD_LOGIC;
          Red,Green,Blue : out STD_LOGIC_VECTOR(3 downto 0));
  end component;

  component lasers is
      Port (hcount,vcount : in STD_LOGIC_VECTOR(10 downto 0); blank, vsync, laser_clk : in STD_LOGIC;
              Red,Green,Blue : out STD_LOGIC_VECTOR(3 downto 0));
  end component;

  component pixel_mux is
    Port (hcount,vcount : in STD_LOGIC_VECTOR(10 downto 0);
          blank : in STD_LOGIC;
          RED_IN_1, RED_IN_2, RED_IN_3, GREEN_IN_1, GREEN_IN_2, GREEN_IN_3, BLUE_IN_1, BLUE_IN_2, BLUE_IN_3 : STD_LOGIC_VECTOR (3 downto 0);
          Red_Out, Green_Out, Blue_Out : out STD_LOGIC_VECTOR (3 downto 0));
  end component;

  component space_fighter_logic is
    Port(clk_game_logic, reset, left_btn, right_btn, up_btn, down_btn : in STD_LOGIC;
         spaceship_row, spaceship_col : out STD_LOGIC_VECTOR (10 downto 0);
         spaceship_enable : out STD_LOGIC);
  end component;

  component spaceship is
    Port (clk25 : in STD_LOGIC; hcount,vcount : in STD_LOGIC_VECTOR(10 downto 0);
          blank : in STD_LOGIC;
          ROW_CENTER, COL_CENTER : in STD_LOGIC_VECTOR (10 downto 0);
          Red, Green, Blue : out STD_LOGIC_VECTOR (3 downto 0));
  end component;

  component ClkDivider is
    Generic ( OutputClkFreq : Integer := 1; InputClkFreq : Integer := 100000000 );
    Port (signal InputClock : in STD_LOGIC; signal OutputClock : out STD_LOGIC := '0' );
  end component;


  signal clk_25MHz,blank,VSYNC_temp : STD_LOGIC;
  signal hcount,vcount : STD_LOGIC_VECTOR(10 downto 0);

  -- Colors
  signal background_blue, background_green, background_red : STD_LOGIC_VECTOR (3 downto 0);
  signal spaceship_blue, spaceship_green, spaceship_red : STD_LOGIC_VECTOR (3 downto 0) := "0000";
  signal laser_blue, laser_green, laser_red : STD_LOGIC_VECTOR (3 downto 0) := "0000";

  -- Logic and positioning
  signal laser_clk : STD_LOGIC := '0';

  -- signal spaceship_row : STD_LOGIC_VECTOR (10 downto 0) := "00011110000"; -- 240
  -- signal spaceship_col : STD_LOGIC_VECTOR (10 downto 0) := "00011110000"; -- 240
  signal spaceship_row : STD_LOGIC_VECTOR (10 downto 0);
  signal spaceship_col : STD_LOGIC_VECTOR (10 downto 0);

  signal clk_game_logic : STD_LOGIC := '0';
  signal left_btn_debounced,right_btn_debounced,up_btn_debounced, down_btn_debounced : STD_LOGIC;
  signal spaceship_enable : STD_LOGIC;

begin
  c1 : clk_wiz_0 PORT MAP (clk_in1 => clk_100MHz, reset => reset, clk_out1 => clk_25MHz,
                           locked => locked);

  v1 : vga_controller_640_60 PORT MAP (pixel_clk => clk_25MHz, rst => reset, HS => HSYNC,
                                       VS => VSYNC_temp, blank => blank, hcount => hcount,
                                       vcount => vcount);

  s1 : static_background PORT MAP (hcount => hcount, vcount => vcount, blank => blank,
                                   RED => background_red, GREEN => background_green, BLUE => background_blue);


  laser_clk_div: ClkDivider
    generic map ( OutputClkFreq => 200, InputClkFreq => 100000000 )
    port map (InputClock => clk_100MHz, OutputClock => laser_clk);

  lase1: lasers port map (hcount => hcount, vcount => vcount, blank => blank, vsync => vsync_temp, laser_clk => laser_clk,
                          Red => laser_red, Green => laser_green, Blue => laser_blue);

  game_logic_clk_div: ClkDivider
    generic map ( OutputClkFreq => 250, InputClkFreq => 100000000 )
    port map (InputClock => clk_100MHz, OutputClock => clk_game_logic );

  fighter_logic_1: space_fighter_logic port map (
    clk_game_logic => clk_game_logic, reset => reset,
    left_btn => left_btn,
    right_btn => right_btn,
    -- left_btn => left_btn_debounced,
    -- right_btn => right_btn_debounced,
    up_btn => up_btn,
    down_btn => down_btn,
    spaceship_row => spaceship_row, spaceship_col => spaceship_col,
    spaceship_enable => spaceship_enable);

  fighter1: spaceship port map (clk25 => clk_25MHz, hcount => hcount, vcount => vcount, blank => blank,
                              ROW_CENTER => spaceship_row, COL_CENTER => spaceship_col,
                              Red => spaceship_red, Green => spaceship_green, Blue => spaceship_blue);


  p1 : pixel_mux port map (hcount => hcount, vcount => vcount, blank => blank,
                           RED_IN_1 => background_red, RED_IN_2 => laser_red, RED_IN_3 => spaceship_red,
                           GREEN_IN_1 => background_green, GREEN_IN_2 => laser_green, GREEN_IN_3 => spaceship_green,
                           BLUE_IN_1 => background_blue, BLUE_IN_2 => laser_blue, BLUE_IN_3 => spaceship_blue,
                           Red_Out => Red_Out, Green_Out => Green_Out, Blue_Out => Blue_Out
                           );




  VSYNC <= VSYNC_temp;


end Behavioral;
