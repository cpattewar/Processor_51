library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity branch_adder is
port (Pcplus4: in STD_LOGIC_VECTOR (31 downto 0);
		shiftleftout: in STD_LOGIC_VECTOR (31 downto 0);
		branchaddout: out STD_LOGIC_VECTOR (31 downto 0));
end branch_adder;

architecture Behavioral of branch_adder is

begin

branchaddout <= Pcplus4 + shiftleftout;

end Behavioral;