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
begin
  process(hcount,vcount,blank)
    VARIABLE row, col : INTEGER;
  begin
    row := conv_integer(vcount);
    col := conv_integer(hcount);

    if(((col = row and row < 210) or -- top left diag
        (640 - col = row and row < 210) or -- top right diag
        (row = 210 and (col > 210 and col < 430)) or -- top line
        (col = 210 and (row > 210 and row < 310)) or -- left line
        (col = 430 and (row > 210 and row < 310)) or -- right line
        (row = 310 and (col > 210 and col < 430)) or -- bottom line 
        (row = ((-170/210)*col) + 480 and row > 310) or -- bottom left diag
        (row = 100))  and -- bottom right diag 
       blank='0') then
      Red <= "1111";       -- White Cockpit
      Green <= "1111";
      Blue <= "1111";

    elsif(blank = '0') then -- Gray space
      Red <= "0010";
      Green <= "0010";
      Blue <= "0010";
      
    else -- Black outside screen
      Red <= "0000";
      Green <= "0000";
      Blue <= "0000";

    end if;

  end process;

end Behavioral;

