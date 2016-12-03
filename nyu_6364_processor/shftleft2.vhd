library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_SIGNED.ALL;

entity shftleft2 is
Port (SHFTLEFT2IN : IN std_logic_vector(31 downto 0);
		SHFTLEFT2OUT : OUT std_logic_vector(31 downto 0));
end shftleft2;

architecture Behavioral of shftleft2 is

begin

SHFTLEFT2OUT <= SHFTLEFT2IN(29 downto 0) & "00";

end Behavioral;