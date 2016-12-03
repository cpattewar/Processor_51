library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity myalu is
port (IN1: in STD_LOGIC_VECTOR (31 downto 0);
		IN2: in STD_LOGIC_VECTOR (31 downto 0);
		alucontrol: in STD_LOGIC_VECTOR (5 downto 0);
		ZERO: out STD_LOGIC;
		RESULT: out STD_LOGIC_VECTOR (31 downto 0));
end myalu;

architecture Behavioral of myalu is

signal ADD : STD_LOGIC_VECTOR (31 downto 0);
signal SUB : STD_LOGIC_VECTOR (31 downto 0);
signal ANDR : STD_LOGIC_VECTOR (31 downto 0);
signal ORR : STD_LOGIC_VECTOR (31 downto 0);
signal NORR : STD_LOGIC_VECTOR (31 downto 0);
signal SHL : std_logic_vector (31 downto 0);
signal SHR : std_logic_vector (31 downto 0);

begin

ORR <= IN1 or IN2;

ANDR <= IN1 and IN2;

NORR <= IN1 nor IN2;

ADD <= IN1 + IN2;

SUB <= IN1 - IN2;

with IN2(4 downto 0) select
SHL <= IN1(30 downto 0) & IN1(31) when "00001",
			IN1(29 downto 0) & IN1(31 downto 30) when "00010",
			IN1(28 downto 0) & IN1(31 downto 29) when "00011",
			IN1(27 downto 0) & IN1(31 downto 28) when "00100",
			IN1(26 downto 0) & IN1(31 downto 27) when "00101",
			IN1(25 downto 0) & IN1(31 downto 26) when "00110",
			IN1(24 downto 0) & IN1(31 downto 25) when "00111",
			IN1(23 downto 0) & IN1(31 downto 24) when "01000",
			IN1(22 downto 0) & IN1(31 downto 23) when "01001",
			IN1(21 downto 0) & IN1(31 downto 22) when "01010",
			IN1(20 downto 0) & IN1(31 downto 21) when "01011",
			IN1(19 downto 0) & IN1(31 downto 20) when "01100",
			IN1(18 downto 0) & IN1(31 downto 19) when "01101",
			IN1(17 downto 0) & IN1(31 downto 18) when "01110",
			IN1(16 downto 0) & IN1(31 downto 17) when "01111",
			IN1(15 downto 0) & IN1(31 downto 16) when "10000",
			IN1(14 downto 0) & IN1(31 downto 15) when "10001",
			IN1(13 downto 0) & IN1(31 downto 14) when "10010",
			IN1(12 downto 0) & IN1(31 downto 13) when "10011",
			IN1(11 downto 0) & IN1(31 downto 12) when "10100",
			IN1(10 downto 0) & IN1(31 downto 11) when "10101",
			IN1(9 downto 0) & IN1(31 downto 10) when "10110",
			IN1(8 downto 0) & IN1(31 downto 9) when "10111",
			IN1(7 downto 0) & IN1(31 downto 8) when "11000",
			IN1(6 downto 0) & IN1(31 downto 7) when "11001",
			IN1(5 downto 0) & IN1(31 downto 6) when "11010",
			IN1(4 downto 0) & IN1(31 downto 5) when "11011",
			IN1(3 downto 0) & IN1(31 downto 4) when "11100",
			IN1(2 downto 0) & IN1(31 downto 3) when "11101",
			IN1(1 downto 0) & IN1(31 downto 2) when "11110",
			IN1(0) & IN1(31 downto 1) when "11111",
			IN1 when others; 	

with IN2(4 downto 0) select
SHR <= IN1(30 downto 0) & IN1(31) when "11111",
			IN1(29 downto 0) & IN1(31 downto 30) when "11110",
			IN1(28 downto 0) & IN1(31 downto 29) when "11101",
			IN1(27 downto 0) & IN1(31 downto 28) when "11100",
			IN1(26 downto 0) & IN1(31 downto 27) when "11011",
			IN1(25 downto 0) & IN1(31 downto 26) when "11010",
			IN1(24 downto 0) & IN1(31 downto 25) when "11001",
			IN1(23 downto 0) & IN1(31 downto 24) when "11000",
			IN1(22 downto 0) & IN1(31 downto 23) when "10111",
			IN1(21 downto 0) & IN1(31 downto 22) when "10110",
			IN1(20 downto 0) & IN1(31 downto 21) when "10101",
			IN1(19 downto 0) & IN1(31 downto 20) when "10100",
			IN1(18 downto 0) & IN1(31 downto 19) when "10011",
			IN1(17 downto 0) & IN1(31 downto 18) when "10010",
			IN1(16 downto 0) & IN1(31 downto 17) when "10001",
			IN1(15 downto 0) & IN1(31 downto 16) when "10000",
			IN1(14 downto 0) & IN1(31 downto 15) when "01111",
			IN1(13 downto 0) & IN1(31 downto 14) when "01110",
			IN1(12 downto 0) & IN1(31 downto 13) when "01101",
			IN1(11 downto 0) & IN1(31 downto 12) when "01100",
			IN1(10 downto 0) & IN1(31 downto 11) when "01011",
			IN1(9 downto 0) & IN1(31 downto 10) when "01010",
			IN1(8 downto 0) & IN1(31 downto 9) when "01001",
			IN1(7 downto 0) & IN1(31 downto 8) when "01000",
			IN1(6 downto 0) & IN1(31 downto 7) when "00111",
			IN1(5 downto 0) & IN1(31 downto 6) when "00110",
			IN1(4 downto 0) & IN1(31 downto 5) when "00101",
			IN1(3 downto 0) & IN1(31 downto 4) when "00100",
			IN1(2 downto 0) & IN1(31 downto 3) when "00011",
			IN1(1 downto 0) & IN1(31 downto 2) when "00010",
			IN1(0) & IN1(31 downto 1) when "00001",
			IN1 when others;

RESULT <= ADD when alucontrol = "010000" else -- ADD
				ADD when alucontrol = "000001" else -- ADDI
				SUB when alucontrol = "010001" else	-- SUB
				SUB when alucontrol = "000010" else -- SUBI
				ANDR when alucontrol = "010010" else -- AND
				ANDR when alucontrol = "000011" else -- ANDI
				ORR when alucontrol = "010011" else -- OR
				NORR when alucontrol = "010100" else -- NOR
				ORR when alucontrol = "000100" else -- ORI
				SHL when alucontrol = "000101" else -- SHL
				SHR when alucontrol = "000110" else -- SHR
				ADD when alucontrol = "000111" else	-- LW
				ADD when alucontrol = "001000" else -- SW
          	X"00000000";

ZERO <= '1' when ((IN1 = IN2) and (alucontrol = "001010")) else --beq
			'1' when ((IN1 /= IN2) and (alucontrol = "001011")) else --bne
			'1' when ((IN1 < IN2) and (alucontrol = "001001")) else --blt
			'0';

end Behavioral;