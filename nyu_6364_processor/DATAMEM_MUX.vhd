library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity DATAMEM_MUX is
port (MemtoReg: in STD_LOGIC;
		READDATAOUT: in STD_LOGIC_VECTOR(31 downto 0);	
		ALUOUT: in STD_LOGIC_VECTOR(31 downto 0);	
		WRITEDATA_IN: out STD_LOGIC_VECTOR(31 downto 0)
		);
end DATAMEM_MUX;

architecture Behavioral of DATAMEM_MUX is

begin

WRITEDATA_IN <= ALUOUT when MemtoReg = '0' else
						READDATAOUT;

end Behavioral;