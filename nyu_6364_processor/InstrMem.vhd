library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.Numeric_std.all;

entity InstrMem is
Port (readAddr : in  STD_LOGIC_VECTOR (31 downto 0);
		Instr : out STD_LOGIC_VECTOR (31 downto 0));
end InstrMem;

architecture Behavioral of InstrMem is

type ARRAY_256 is ARRAY (0 to 2047) of STD_LOGIC_VECTOR(31 downto 0);

signal MemContent: ARRAY_256 := (others => (others => '0'));

begin

Instr <= MemContent(to_integer(unsigned(readAddr(31 downto 0))));

end Behavioral;