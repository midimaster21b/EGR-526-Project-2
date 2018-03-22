----------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date: 02/20/2016 04:29:37 PM
-- Design Name:
-- Module Name: static_background - Behavioral
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity static_background is
  Port (hcount,vcount : in STD_LOGIC_VECTOR(10 downto 0); blank : in STD_LOGIC;
        Red,Green,Blue : out STD_LOGIC_VECTOR(3 downto 0));
end static_background;

architecture Behavioral of static_background is

  component bresenham_line is
    generic (Start_Col, Start_Row, Finish_Col, Finish_Row : Integer);

    Port (hcount,vcount : in STD_LOGIC_VECTOR(10 downto 0);
          Line_Red, Line_Green, Line_Blue : in STD_LOGIC_VECTOR (3 downto 0);
          Red,Green,Blue : out STD_LOGIC_VECTOR(3 downto 0)
          );
  end component;

  signal Line_Red, Line_Green, Line_Blue : STD_LOGIC_VECTOR (3 downto 0) := "1111";

  signal Red1, Green1, Blue1 : STD_LOGIC_VECTOR (3 downto 0) := "0000";
  signal Red2, Green2, Blue2 : STD_LOGIC_VECTOR (3 downto 0) := "0000";
  signal Red3, Green3, Blue3 : STD_LOGIC_VECTOR (3 downto 0) := "0000";
  signal Red4, Green4, Blue4 : STD_LOGIC_VECTOR (3 downto 0) := "0000";
  signal Red5, Green5, Blue5 : STD_LOGIC_VECTOR (3 downto 0) := "0000";
  signal Red6, Green6, Blue6 : STD_LOGIC_VECTOR (3 downto 0) := "0000";
  signal Red7, Green7, Blue7 : STD_LOGIC_VECTOR (3 downto 0) := "0000";
  signal Red8, Green8, Blue8 : STD_LOGIC_VECTOR (3 downto 0) := "0000";

begin

  upper_left_diag : bresenham_line
    generic map (Start_Col => 84, Start_Row => 1, Finish_Col => 178, Finish_Row => 109)
    port map (hcount => hcount, vcount => vcount,
              Line_Red => Line_Red, Line_Green => Line_Green, Line_Blue => Line_Blue,
              Red => Red1, Green => Green1, Blue => Blue1
              );

  -- Not showing up currently
  upper_right_diag : bresenham_line
    -- generic map (Start_Col => 556, Start_Row => 1, Finish_Col => 461, Finish_Row => 109)
    -- generic map (Start_Col => 461, Start_Row => 109, Finish_Col => 556, Finish_Row => 1)
    generic map (Start_Col => 461, Start_Row => 109, Finish_Col => 550, Finish_Row => 1)
    port map (hcount => hcount, vcount => vcount,
              Line_Red => Line_Red, Line_Green => Line_Green, Line_Blue => Line_Blue,
              Red => Red2, Green => Green2, Blue => Blue2
              );

  top_horiz_line : bresenham_line
    generic map (Start_Col => 178, Start_Row => 109, Finish_Col => 461, Finish_Row => 109)
    port map (hcount => hcount, vcount => vcount,
              Line_Red => Line_Red, Line_Green => Line_Green, Line_Blue => Line_Blue,
              Red => Red3, Green => Green3, Blue => Blue3
              );

  bottom_horiz_line : bresenham_line
    generic map (Start_Col => 141, Start_Row => 371, Finish_Col => 517, Finish_Row => 371)
    port map (hcount => hcount, vcount => vcount,
              Line_Red => Line_Red, Line_Green => Line_Green, Line_Blue => Line_Blue,
              Red => Red4, Green => Green4, Blue => Blue4
              );


  -- Not showing up currently
  left_inner_line : bresenham_line
    -- generic map (Start_Col => 178, Start_Row => 109, Finish_Col => 141, Finish_Row => 371)
    generic map (Start_Col => 141, Start_Row => 371, Finish_Col => 178, Finish_Row => 109)
    port map (hcount => hcount, vcount => vcount,
              Line_Red => Line_Red, Line_Green => Line_Green, Line_Blue => Line_Blue,
              Red => Red5, Green => Green5, Blue => Blue5
              );

  -- This line makes the screen blur/alias
  -- Would splitting it up help?
  right_inner_line : bresenham_line
    generic map (Start_Col => 461, Start_Row => 109, Finish_Col => 517, Finish_Row => 371)
    -- generic map (Start_Col => 517, Start_Row => 371, Finish_Col => 461, Finish_Row => 109)
    port map (hcount => hcount, vcount => vcount,
              Line_Red => Line_Red, Line_Green => Line_Green, Line_Blue => Line_Blue,
              Red => Red6, Green => Green6, Blue => Blue6
              );

  bottom_left_diag : bresenham_line
    generic map (Start_Col => 1, Start_Row => 439, Finish_Col => 141, Finish_Row => 371)
    port map (hcount => hcount, vcount => vcount,
              Line_Red => Line_Red, Line_Green => Line_Green, Line_Blue => Line_Blue,
              Red => Red7, Green => Green7, Blue => Blue7
              );

  bottom_right_diag : bresenham_line
    generic map (Start_Col => 517, Start_Row => 371, Finish_Col => 640, Finish_Row => 439)
    port map (hcount => hcount, vcount => vcount,
              Line_Red => Line_Red, Line_Green => Line_Green, Line_Blue => Line_Blue,
              Red => Red8, Green => Green8, Blue => Blue8
              );


  -- This should probably be a separate entity...
  -- Pixel mux...
  process(Red1, Red2, Red3, Red4, Red5, Red6,
          Green1, Green2, Green3, Green4, Green5, Green6,
          Blue1, Blue2, Blue3, Blue4, Blue5, Blue6)
  begin
    Red   <= Red1 or Red2 or Red3 or Red4 or Red5 or Red6 or Red7 or Red8;
    Green <= Green1 or Green2 or Green3 or Green4 or Green5 or Green6 or Green7 or Green8;
    Blue  <= Blue1 or Blue2 or Blue3 or Blue4 or Blue5 or Blue6 or Blue7 or Blue8;
  end process;
end Behavioral;
