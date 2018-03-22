----------------------------------------------------------------------------------
-- Company:
-- Engineer: Joshua Edgcombe
--
-- Create Date: 03/01/2018 06:13:19 PM
-- Design Name:
-- Module Name: pixel_mux - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

entity pixel_mux is
Port (hcount,vcount : in STD_LOGIC_VECTOR(10 downto 0);
      blank : in STD_LOGIC;
      RED_IN_1, RED_IN_2, GREEN_IN_1, GREEN_IN_2, BLUE_IN_1, BLUE_IN_2 : STD_LOGIC_VECTOR (3 downto 0);
      Red_Out, Green_Out, Blue_Out : out STD_LOGIC_VECTOR (3 downto 0));
end pixel_mux;

architecture Behavioral of pixel_mux is

begin

  process(hcount, vcount)
  begin
    Red_Out   <= Red_In_1 or Red_In_2;
    Blue_Out  <= Blue_In_1 or Blue_In_2;
    Green_Out <= Green_In_1 or Green_In_2;
  end process;

end Behavioral;
