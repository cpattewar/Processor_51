library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;

entity PC_ADD is
port(PC:	in STD_LOGIC_VECTOR (31 downto 0);
		RESULT:	out  STD_LOGIC_VECTOR (31 downto 0)
		);
end PC_ADD;

architecture Behavioral of PC_ADD is

signal TPC : STD_LOGIC_VECTOR (31 downto 0);

begin

TPC <= PC + 1;
RESULT <= TPC;

end Behavioral;