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

  Port (hcount,vcount : in STD_LOGIC_VECTOR(10 downto 0);
        Line_Red, Line_Green, Line_Blue : in STD_LOGIC_VECTOR (3 downto 0);
        Red,Green,Blue : out STD_LOGIC_VECTOR(3 downto 0)
        );

end bresenham_line;

architecture Behavioral of bresenham_line is

begin
  -- process(hcount, vcount, blank, vsync)
  process(hcount)
    VARIABLE err : INTEGER range -1300 to 1000;
    variable dcol, col, col_iter, col_iter_start, col_iter_finish : INTEGER range 1 to 640;
    variable drow, row, row_iter, row_iter_start, row_iter_finish : INTEGER range 1 to 480;
    variable Red_Out, Green_Out, Blue_Out : STD_LOGIC_VECTOR := "0000";

  begin
    row := conv_integer(vcount);
    col := conv_integer(hcount);

    row_iter := Start_Row;
    col_iter := Start_Col;

    row_iter_start := Start_Row;
    row_iter_finish := Finish_Row;
    row_iter := Start_Row;
    col_iter_start := Start_Col;
    col_iter_finish := Finish_Col;
    col_iter := Start_Col;

    if (Finish_Row > Start_Row) then
      drow := Finish_Row - Start_Row;
    --   row_iter_start := Start_Row;
    --   row_iter_finish := Finish_Row;
    --   row_iter := Start_Row;
    else
      drow := Start_Row - Finish_Row;
    --   row_iter_start := Finish_Row;
    --   row_iter_finish := Start_Row;
    --   row_iter := Finish_Row;
    end if;

    if (Finish_Col > Start_Col) then
      dcol := Finish_Col - Start_Col;
    --   col_iter_start := Start_Col;
    --   col_iter_finish := Finish_Col;
    --   col_iter := Start_Col;
    else
      dcol := Start_Col - Finish_Col;
    --   col_iter_start := Finish_Col;
    --   col_iter_finish := Start_Col;
    --   col_iter := Finish_Col;
    end if;

    Red_Out   := "0000";
    Green_Out := "0000";
    Blue_Out  := "0000";

    -- Take appropriate approach based on being a greater number of columns
    -- or rows to iterate through
    if (abs(dcol) > abs(drow)) then
      -- Calculate initial error
      -- Max: 2 * 480
      -- Min: -640
      err := 2 * drow - dcol;

      for col_iter in col_iter_start to col_iter_finish loop

        if (col = col_iter and row = row_iter) then
          Red_Out   := Line_Red;
          Green_Out := Line_Green;
          Blue_Out  := Line_Blue;
        end if;

        if err > 0 then
          -- Increment row
          -- y = y + 1;
          if Finish_Row > Start_Row then
            row_iter := row_iter + 1;
          elsif Finish_Row < Start_Row then
            row_iter := row_iter - 1;
          end if;

          -- D = D - 2*dx
          -- Min: -1280
          err := err - (2 * dcol);
        end if;

        -- D = D + 2*dy
        -- Max: 960
        err := err + (2 * drow);

      -- end loop;
      end loop;
    else
      -- Calculate initial error
      -- Max: 2 * 480
      -- Min: -640
      err := 2 * dcol - drow;

      for row_iter in row_iter_start to row_iter_finish loop

        if (col = col_iter and row = row_iter) then
          Red_Out   := Line_Red;
          Green_Out := Line_Green;
          Blue_Out  := Line_Blue;
        end if;

        if err > 0 then
          -- Increment row
          -- y = y + 1;
          if Finish_Col > Start_Col then
            col_iter := col_iter + 1;
          elsif Finish_Row < Start_Row then
            col_iter := col_iter - 1;
          end if;

          -- D = D - 2*dx
          -- Min: -1280
          err := err - (2 * drow);
        end if;

        -- D = D + 2*dy
        -- Max: 960
        err := err + (2 * dcol);

      -- end loop;
      end loop;
    end if;


    Red   <= Red_Out;
    Green <= Green_Out;
    Blue  <= Blue_Out;

  end process;
end Behavioral;
