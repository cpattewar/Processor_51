library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity SIGN_EXT is
port (REG_16_IN : in STD_LOGIC_VECTOR(15 downto 0);
		REG_32_OUT: out STD_LOGIC_VECTOR(31 downto 0));
end SIGN_EXT;

architecture Behavioral of SIGN_EXT is

begin

REG_32_OUT <= (X"FFFF" & REG_16_IN) when (REG_16_IN(15) = '1') 
						else X"0000" & REG_16_IN;

end Behavioral;