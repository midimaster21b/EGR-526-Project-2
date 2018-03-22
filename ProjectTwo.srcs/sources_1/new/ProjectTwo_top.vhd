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

  -- component bresenham_line is
  --   generic (Start_Col, Start_Row, Finish_Col, Finish_Row : Integer);

  --   Port (hcount,vcount : in STD_LOGIC_VECTOR(10 downto 0); blank, vsync : in STD_LOGIC;
  --         Line_Red, Line_Green, Line_Blue : in STD_LOGIC_VECTOR (3 downto 0);
  --         Red,Green,Blue : out STD_LOGIC_VECTOR(3 downto 0)
  --         -- Line_Col_In, Line_Row_In : in STD_LOGIC_VECTOR(10 downto 0);
  --         -- Line_Col_Out, Line_Row_Out : out STD_LOGIC_VECTOR(10 downto 0)
  --         );
  -- end component;

  signal clk_25MHz,blank,VSYNC_temp : STD_LOGIC;
  signal hcount,vcount : STD_LOGIC_VECTOR(10 downto 0);

  signal Line_Red, Line_Blue, Line_Green : STD_LOGIC_VECTOR (3 downto 0) := "1111";
  signal Line_Col_Feedback, Line_Row_Feedback : STD_LOGIC_VECTOR(10 downto 0);

begin
  c1 : clk_wiz_0 PORT MAP (clk_in1 => clk_100MHz, reset => reset, clk_out1 => clk_25MHz,
                           locked => locked);

  v1 : vga_controller_640_60 PORT MAP (pixel_clk => clk_25MHz, rst => reset, HS => HSYNC,
                                       VS => VSYNC_temp, blank => blank, hcount => hcount,
                                       vcount => vcount);

  s1 : static_background PORT MAP (hcount => hcount, vcount => vcount, blank => blank,
                                   RED => Red_Out, GREEN => Green_Out, BLUE => Blue_Out);

  -- bl : bresenham_line
  --   generic map (Start_Col => 50, Start_Row => 50, Finish_Col => 51, Finish_Row => 100)
  --   port map (hcount => hcount, vcount => vcount, blank => blank, vsync => VSYNC_temp,
  --             Line_Red => Line_Red, Line_Green => Line_Green, Line_Blue => Line_Blue,
  --             Red => Red_Out, Green => Green_Out, Blue => Blue_Out
  --             );

  VSYNC <= VSYNC_temp;


end Behavioral;
