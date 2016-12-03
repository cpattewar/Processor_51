library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity PC is
Port(input : in STD_LOGIC_VECTOR(31 downto 0);
		reset : in STD_LOGIC;
		clock: in std_logic;
		output : out STD_LOGIC_VECTOR(31 downto 0));
end PC;

architecture Behavioral of PC is

begin

process(reset, clock)
	begin
		if (reset = '1') then		  --counter reset
			output <= X"00000000";
		elsif (clock'event and clock = '1') then 
			output <= input;
		end if;
end process;

end Behavioral;