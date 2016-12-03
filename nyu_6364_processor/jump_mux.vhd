library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity jump_mux is
port(jump_address: in std_logic_vector (31 downto 0);
		pcsrc_mux_out: in std_logic_vector (31 downto 0);
		pcplus4: out std_logic_vector (31 downto 0);
		jump_signal: in std_logic
		);
end jump_mux;

architecture Behavioral of jump_mux is

begin

pcplus4 <= jump_address when jump_signal = '1' else
				pcsrc_mux_out;

end Behavioral;