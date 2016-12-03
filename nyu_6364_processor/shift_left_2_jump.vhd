library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity shift_left_2_jump is
port (INSTR_25to0: in std_logic_vector (25 downto 0);
		pc4: in std_logic_vector (31 downto 0);
		J_address: out std_logic_vector (31 downto 0));
end shift_left_2_jump;

architecture Behavioral of shift_left_2_jump is

begin

J_address <= pc4(31 downto 28) & INSTR_25to0(25 downto 0) & "00";

end Behavioral;