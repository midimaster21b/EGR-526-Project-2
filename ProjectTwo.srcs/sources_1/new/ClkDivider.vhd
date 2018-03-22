----------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date: 02/15/2018 01:05:29 AM
-- Design Name:
-- Module Name: ClkDivider - Behavioral
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

entity ClkDivider is
  Generic ( OutputClkFreq : Integer := 1; InputClkFreq : Integer := 100000000 );
  Port (signal InputClock : in STD_LOGIC; signal OutputClock : out STD_LOGIC := '0' );
end ClkDivider;

architecture Behavioral of ClkDivider is
  -- 28 Bits required for 100 MHz clock
  signal counter : STD_LOGIC_VECTOR (27 downto 0) := "0000000000000000000000000000";
  signal ClkOut  : STD_LOGIC := '0';
begin

  process(InputClock)
  begin
    if rising_edge(InputClock) then
      counter <= counter + 1;

      if counter = ((InputClkFreq / OutputClkFreq) / 2) then
        counter <= "0000000000000000000000000000";
        ClkOut <= not(ClkOut);
      end if;
    end if;

    OutputClock <= ClkOut;
  end process;

end Behavioral;
