library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity REG_MUX is
port (RegDst: in STD_LOGIC;
		INSTR_20TO16: in STD_LOGIC_VECTOR(4 downto 0);	
		INSTR_15TO11: in STD_LOGIC_VECTOR(4 downto 0);	
		WriteRegisterIN: out STD_LOGIC_VECTOR(4 downto 0));
end REG_MUX;

architecture Behavioral of REG_MUX is

begin

WriteRegisterIN <= INSTR_20TO16 when RegDst = '0' else
							INSTR_15TO11;

end Behavioral;