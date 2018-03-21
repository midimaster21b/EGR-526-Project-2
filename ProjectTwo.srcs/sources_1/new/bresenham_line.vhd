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
        Red,Green,Blue : out STD_LOGIC_VECTOR(3 downto 0)
        -- Line_Col_In, Line_Row_In : in STD_LOGIC_VECTOR(10 downto 0);
        -- Line_Col_Out, Line_Row_Out : out STD_LOGIC_VECTOR(10 downto 0)
        );

end bresenham_line;

architecture Behavioral of bresenham_line is

begin
  -- process(hcount, vcount, blank, vsync)
  -- process(hcount, vcount, blank, vsync, line_row_in, line_col_in)
  process(hcount)
    VARIABLE err : INTEGER range -1300 to 1000;
    variable dcol, col, line_col, col_iter : INTEGER range 1 to 640;
    variable drow, row, line_row, row_iter : INTEGER range 1 to 480;
    variable Red_Out, Green_Out, Blue_Out : STD_LOGIC_VECTOR := "0000";

  begin
    row := conv_integer(vcount);
    col := conv_integer(hcount);

    drow := Finish_Row - Start_Row;
    dcol := Finish_Col - Start_Col;

    -- Calculate initial error
    -- Max: 2 * 480
    -- Min: -640
    err := 2 * drow - dcol;

    row_iter := Start_Row;
    col_iter := Start_Col;

    -- Used for determining next
    line_col := Start_Col;

    Red_Out   := "0000";
    Green_Out := "0000";
    Blue_Out  := "0000";

    for col_iter in Start_Col to Finish_Col loop
      -- for row_iter in Start_Row to Finish_Row loop

      -- if (col_iter = line_col and row_iter = line_row) then
      if (col = col_iter and row = row_iter) then
        Red_Out   := "1111";
        Green_Out := "1111";
        Blue_Out  := "1111";
      end if;

      if err > 0 then
        -- Increment row
        -- y = y + 1;
        -- line_col := line_col + 1;
        row_iter := row_iter + 1;

        -- D = D - 2*dx
        -- Min: -1280
        err := err - (2 * dcol);
      end if;

      -- D = D + 2*dy
      -- Max: 960
      err := err + (2 * drow);

    -- end loop;
    end loop;

    Red   <= Red_Out;
    Green <= Green_Out;
    Blue  <= Blue_Out;

    -- for row_iter in 1 to 480 loop
    --   for col_iter in 1 to 640 loop
    --     if (col_iter >= Start_Row and col_iter <= Finish_Row) and (row_iter >= Start_row and row_iter <= Finish_Row) then
    --       if (err > 0)
    --     end if;
    --   end loop;
    -- end loop;

  end process;
end Behavioral;
