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

entity space_fighter_logic is
  Port(clk_game_logic, reset, left_btn, right_btn, up_btn, down_btn : in STD_LOGIC;
       spaceship_row, spaceship_col : out STD_LOGIC_VECTOR (10 downto 0);
       spaceship_enable : out STD_LOGIC);
end space_fighter_logic;

architecture Behavioral of space_fighter_logic is

  -- Spaceship position
  signal spaceship_row_temp : STD_LOGIC_VECTOR (10 downto 0) := "00011110000"; -- 240
  signal spaceship_col_temp : STD_LOGIC_VECTOR (10 downto 0) := "00011110000"; -- 240
  signal spaceship_enable_temp : STD_LOGIC := '1';

begin

  process (clk_game_logic)
  begin
    if( rising_edge(clk_game_logic) ) then
      -- Handle user input
      if( left_btn = '1' and spaceship_col_temp > 1) then
        spaceship_col_temp <= spaceship_col_temp - 1;
      elsif( right_btn = '1' and spaceship_col_temp < 640) then
        spaceship_col_temp <= spaceship_col_temp + 1;
      elsif( down_btn = '1' and spaceship_row_temp < 480) then
        spaceship_row_temp <= spaceship_row_temp + 1;
      elsif( up_btn = '1' and spaceship_row_temp > 1) then
        spaceship_row_temp <= spaceship_row_temp - 1;
      end if;

    -- HANDLE COLLISION


    end if;

    spaceship_row <= spaceship_row_temp;
    spaceship_col <= spaceship_col_temp;
    spaceship_enable <= spaceship_enable_temp;

  end process;

end Behavioral;
