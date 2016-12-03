library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity pcsrc_and is
port(
	a:in std_logic;
	b:in std_logic;
	c:out std_logic);
end pcsrc_and;

architecture Behavioral of pcsrc_and is

begin

c <=a and b;

end Behavioral;