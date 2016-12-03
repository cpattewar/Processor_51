library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity PCSRC_MUX is
port (PCSrc: in STD_LOGIC;
		PCPLUS4: in STD_LOGIC_VECTOR(31 downto 0);	
		SHFLFT2OUT: in STD_LOGIC_VECTOR(31 downto 0);	
		PCin: out STD_LOGIC_VECTOR(31 downto 0));
end PCSRC_MUX;

architecture Behavioral of PCSRC_MUX is

begin

PCin <= PCPLUS4 when PCSrc = '0' else
			SHFLFT2OUT;

end Behavioral;