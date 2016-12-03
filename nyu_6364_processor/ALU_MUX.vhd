library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ALU_MUX is
port (ALUSrc: in STD_LOGIC;
		READDATA2: in STD_LOGIC_VECTOR(31 downto 0);	
		SIGNEXTOUT: in STD_LOGIC_VECTOR(31 downto 0);
		ALU_IN2: out STD_LOGIC_VECTOR(31 downto 0)
		);
end ALU_MUX;

architecture Behavioral of ALU_MUX is

begin

ALU_IN2 <= READDATA2 when ALUSrc = '0' else
				SIGNEXTOUT;

end Behavioral;