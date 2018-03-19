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
use IEEE.NUMERIC_STD.ALL;

entity bresenham_line is
  generic (Start_Col, Start_Row, Finish_Col, Finish_Row : Integer);

  Port (hcount,vcount : in STD_LOGIC_VECTOR(10 downto 0); blank, vsync : in STD_LOGIC;
        Line_Red, Line_Green, Line_Blue : in STD_LOGIC_VECTOR (3 downto 0);
        Red,Green,Blue : out STD_LOGIC_VECTOR(3 downto 0);
        Line_Col_In, Line_Row_In : in STD_LOGIC_VECTOR(10 downto 0);
        Line_Col_Out, Line_Row_Out : out STD_LOGIC_VECTOR(10 downto 0)
        );

end bresenham_line;

architecture Behavioral of bresenham_line is


begin
  -- process(hcount, vcount, blank, vsync)
  -- process(hcount, vcount, blank, vsync, line_row_in, line_col_in)
  process(hcount)
    VARIABLE row, col, drow, dcol, err, line_row, line_col : INTEGER;

  begin
    row := conv_integer(vcount);
    col := conv_integer(hcount);

    -- Protection to only run once
    if ( col /= line_col and row /= line_row ) then
      if ( row = 1 and col = 1 ) then
        -- NEW FRAME
        -- Calculate deltas
        drow := Finish_Row - Start_Row;
        dcol := Finish_Col - Start_Col;

        -- Reset the error calculation
        err := 2 * drow - dcol;

        -- Reset the row and column
        line_row_out <= "00000001010"; -- 10
        line_col_out <= "00000001010"; -- 10

        Red   <= "0000";
        Green <= "0000";
        Blue  <= "0000";

        -- Red   <= "1111";
        -- Green <= "1111";
        -- Blue  <= "1111";

      -- line_col < Finish_Col leaves out last pixel, change back to <= after testing
      -- elsif (row = line_row and col = line_col and line_col < Finish_Col) then
      -- elsif ((row = line_row and col = line_col) and line_col < Finish_Col) then
      -- elsif (row = line_row and col = line_col) then
      elsif (row = conv_integer(line_row_in) and col = conv_integer(line_col_in)) then
        -- Line present
        -- Red   <= Line_Red;
        -- Green <= Line_Green;
        -- Blue  <= Line_Blue;
        Red   <= "1111";
        Green <= "1111";
        Blue  <= "1111";

        -- Increment column
        line_col_out <= line_col_in + 1;

        -- if (err > 0) then
        --   -- Increment row being drawn
        --   if ( Start_Row > Finish_Row ) then
        --     line_row := line_row + 1;
        --   elsif ( Start_Row < Finish_Row) then
        --     line_row := line_row - 1;
        --   end if;

        --   -- Subtract error
        --   err := err - (2 * dcol);

        -- else
        --   -- Add to error
        --   err := err + (2 * drow);

        --   -- line_row := 10; -- THIS SHOULDN'T BE HERE!! JUST FOR TESTING!!

      -- end if;
      else
        -- Not on line
        Red   <= "0000";
        Green <= "0000";
        Blue  <= "0000";

      end if;

      line_col := col;
      line_row := row;

    end if;
  end process;
end Behavioral;
