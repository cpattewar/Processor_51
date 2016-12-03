library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;

entity DataMemory is
port (Address : in std_logic_vector (31 downto 0);
		WriteData : in std_logic_vector (31 downto 0);
		MemRead : in std_logic;
		MemWrite : in std_logic;
		ReadData : out std_logic_vector (31 downto 0));
end DataMemory;

architecture Behavioral of DataMemory is

type reg_array is array (0 to 511) of std_logic_vector(31 downto 0);
signal reg_file : reg_array := (x"00000000", x"00000000", x"46f8e8c5", x"460c6085",
					x"70f83b8a", x"284b8303", x"513e1454", x"f621ed22",
					x"3125065d", x"11a83a5d", x"d427686b", x"713ad82d",
					x"4b792f99", x"2799a4dd", x"a7901c49", x"dede871a",
					x"36c03196", x"a7efc249", x"61a78bb8", x"3b0a1d2b",
					x"4dbfca76", x"ae162167", x"30d76b0a", x"43192304",
					x"f6cc1431", x"65046380", x"00000000", x"abcdef12", others => (others => '0'));

begin

datamemory:process(Address, WriteData, MemRead, MemWrite, reg_file)   
begin 
	if (MemWrite = '1') then
		reg_file(conv_integer(Address)) <= WriteData;
	elsif MemRead = '1' then
		ReadData <= reg_file(conv_integer(Address));
	end if;
end process datamemory;

end Behavioral;