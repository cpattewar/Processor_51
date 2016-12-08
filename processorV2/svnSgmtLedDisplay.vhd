library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;

entity display is
    Port ( clk, clr     : in  STD_LOGIC;
			  vctr2Display : in  STD_LOGIC_VECTOR (31 downto 0);
           g2a          : out STD_LOGIC_VECTOR (7 downto 0);
           cathode      : out STD_LOGIC_VECTOR (7 downto 0));
end display;

architecture Behavioral of display is

signal ledShftr   : std_logic_vector(2 downto 0);
signal slwClk     : std_logic_vector(15 downto 0);
signal fourBitSig : std_logic_vector(3 downto 0);

begin


process(clk, clr)
begin
	if(clr = '1') then 
		slwClk <= "0000000000000000"; 
		ledShftr <= "000";
	elsif(clk'event and clk = '1') then
		if (slwClk < "1000000000100000") then 
			slwClk <= slwClk + '1';
		else 
			slwClk <= "0000000000000000";
			ledShftr <= ledShftr + '1';
		end if;
	end if;
end process;


with ledShftr(2 downto 0) select
	fourBitSig <=  vctr2Display(3 downto 0) when "000",
						vctr2Display(7 downto 4) when "001",
						vctr2Display(11 downto 8) when "010",
						vctr2Display(15 downto 12) when "011",
						vctr2Display(19 downto 16) when "100",
						vctr2Display(23 downto 20) when "101",
						vctr2Display(27 downto 24) when "110",
						vctr2Display(31 downto 28) when others;

with ledShftr(2 downto 0) select
	cathode <= "11111110" when "000",
			     "11111101" when "001",
			     "11111011" when "010",
			     "11110111" when "011",
			     "11101111" when "100",
			     "11011111" when "101",
			     "10111111" when "110",
			     "01111111" when others;

with fourBitSig(3 downto 0) select
	g2a <= "11000000" when "0000", -- 0
			 "11111001" when "0001", -- 1
			 "10100100" when "0010", -- 2
			 "10110000" when "0011", -- 3
			 "10011001" when "0100", -- 4
			 "10010010" when "0101", -- 5
			 "10000010" when "0110", -- 6
			 "11111000" when "0111", -- 7
			 "10000000" when "1000", -- 8
			 "10010000" when "1001", -- 9
			 "10001000" when "1010", -- a
			 "10000011" when "1011", -- b
			 "11000110" when "1100", -- c
			 "10100001" when "1101", -- d
			 "10000110" when "1110", -- e
			 "10001110" when others; -- f

end Behavioral;