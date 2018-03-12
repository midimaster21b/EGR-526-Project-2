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
  Port(clk_100MHz,reset,left_btn,right_btn : in STD_LOGIC;
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

  signal clk_25MHz,blank,VSYNC_temp : STD_LOGIC;
  signal hcount,vcount : STD_LOGIC_VECTOR(10 downto 0);

begin
  c1 : clk_wiz_0 PORT MAP (clk_in1 => clk_100MHz, reset => reset, clk_out1 => clk_25MHz,
                           locked => locked);

  v1 : vga_controller_640_60 PORT MAP (pixel_clk => clk_25MHz, rst => reset, HS => HSYNC,
                                       VS => VSYNC_temp, blank => blank, hcount => hcount,
                                       vcount => vcount);

  s1 : static_background PORT MAP (hcount => hcount, vcount => vcount, blank => blank,
                                   RED => Red_Out, GREEN => Green_Out, BLUE => Blue_Out);

  VSYNC <= VSYNC_temp;


end Behavioral;
