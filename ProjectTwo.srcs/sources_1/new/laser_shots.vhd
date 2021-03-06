----------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date: 03/22/2016 04:27:37 AM
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
use ieee.numeric_std.all;

entity lasers is
  Port (hcount,vcount : in STD_LOGIC_VECTOR(10 downto 0); blank, vsync, laser_clk : in STD_LOGIC;
        Red,Green,Blue : out STD_LOGIC_VECTOR(3 downto 0));
end lasers;

architecture Behavioral of lasers is

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

  -- signal Upper_Blank : STD_LOGIC_VECTOR (10 downto 0) := std_logic_vector(to_unsigned(340, 11));
  -- signal Lower_Blank : STD_LOGIC_VECTOR (10 downto 0) := std_logic_vector(to_unsigned(380, 11));
  -- signal Upper_Blank : Integer := 340;
  -- signal Lower_Blank : Integer := 380;

begin

  left_laser : bresenham_line
    generic map (Start_Col => 320, Start_Row => 240, Finish_Col => 220, Finish_Row => 480)
    port map (hcount => hcount, vcount => vcount,
              Line_Red => Line_Red, Line_Green => Line_Green, Line_Blue => Line_Blue,
              Red => Red1, Green => Green1, Blue => Blue1
              );

  right_laser : bresenham_line
    generic map (Start_Col => 320, Start_Row => 240, Finish_Col => 461, Finish_Row => 480)
    port map (hcount => hcount, vcount => vcount,
              Line_Red => Line_Red, Line_Green => Line_Green, Line_Blue => Line_Blue,
              Red => Red2, Green => Green2, Blue => Blue2
              );


  -- This should probably be a separate entity...
  -- Pixel mux...
  process(hcount, vcount, blank, vsync)

    variable col : Integer range 1 to 640;
    variable row : Integer range 1 to 480;
    variable Upper_Blank : Integer range 1 to 560 := 480;
    variable Lower_Blank : Integer range 1 to 560 := 560;


  begin
    row := conv_integer(vcount);
    col := conv_integer(hcount);

    if (rising_edge(laser_clk)) then
      if (Lower_Blank < 240) then
        Upper_Blank := 480;
        Lower_Blank := 560;

      else
        Upper_Blank := Upper_Blank - 1;
        Lower_Blank := Lower_Blank - 1;

      end if;
    end if;

    if (blank = '0') then
      if (row < Upper_Blank or row > Lower_Blank) then
        Red   <= Red1 or Red2;
        Green <= Green1 or Green2;
        Blue  <= Blue1 or Blue2;

      else
        Red   <= "0000";
        Green <= "0000";
        Blue  <= "0000";

      end if;

    else
      Red   <= "0000";
      Green <= "0000";
      Blue  <= "0000";

    end if;
  end process;
end Behavioral;
