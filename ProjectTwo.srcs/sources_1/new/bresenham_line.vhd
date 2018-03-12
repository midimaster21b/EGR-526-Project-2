----------------------------------------------------------------------------------
-- Company:
-- Engineer: Joshua Edgcombe
--
-- Create Date: 03/11/2018 09:31:37 PM
-- Design Name:
-- Module Name: bresenham_line - Behavioral
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

entity bresenham_line is
  generic (Start_Col, Start_Row, Finish_Col, Finish_Row : Integer);

  Port (hcount,vcount : in STD_LOGIC_VECTOR(10 downto 0); blank : in STD_LOGIC;
        Line_Red, Line_Green, Line_Blue : in STD_LOGIC_VECTOR (3 downto 0);
        Red,Green,Blue : out STD_LOGIC_VECTOR(3 downto 0)
        );

end bresenham_line;

architecture Behavioral of bresenham_line is


begin
  process(hcount, vcount, blank)
    VARIABLE row, col, delta_y, delta_x, drow, dcol, err, line_row, line_col : INTEGER;

  begin
    row := conv_integer(vcount);
    col := conv_integer(hcount);

    if ( row = 0 and col = 0 ) then
      -- NEW FRAME
      -- Calculate deltas
      drow := Finish_Row - Start_Row;
      dcol := Finish_Col - Start_Col;

      -- Reset the error calculation
      err := 2 * drow - dcol;

      -- Reset the row and column
      line_row := Start_Row;
      line_col := Start_Col;

      Red   <= "0000";
      Green <= "0000";
      Blue  <= "0000";

    elsif (row = line_row and col >= line_col and col < Finish_Col) then
      -- Line present
      Red   <= Line_Red;
      Green <= Line_Green;
      Blue  <= Line_Blue;

      if (err > 0) then
        -- Increment row being drawn
        -- line_row := line_row + 1;
        -- line_col := col-1;

        -- Subtract error
        err := err - (2 * dcol);

      else
        -- Add to error
        err := err + (2 * drow);

      end if;
    else
      -- Not on line
      Red   <= "0000";
      Green <= "0000";
      Blue  <= "0000";

    end if;
  end process;
end Behavioral;
