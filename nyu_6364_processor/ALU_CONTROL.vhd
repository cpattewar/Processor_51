library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity ALU_CONTROL is
port (ALUOP : in STD_LOGIC_VECTOR(5 downto 0);
		FUNCT : in STD_LOGIC_VECTOR (5 downto 0);
		RegDst : out STD_LOGIC;
		ALUSrc : out STD_LOGIC;
		MemtoReg : out STD_LOGIC;
		RegWrite : out STD_LOGIC;
		MemWrite : out STD_LOGIC;
		MemRead : out STD_LOGIC;
		Branch : out STD_LOGIC;
		Jump : out STD_LOGIC;
		ALUcontrol : out STD_LOGIC_VECTOR(5 downto 0);
		clock: in std_logic);
end ALU_CONTROL;

architecture Behavioral of ALU_CONTROL is

begin

--R type instruction
RegDst <= '1' when ((ALUOP = "000000" and FUNCT = "010000") or --add
						(ALUOP = "000000" and FUNCT = "010001") or --sub
						(ALUOP = "000000" and FUNCT = "010010") or --and
						(ALUOP = "000000" and FUNCT = "010011") or --or
						(ALUOP = "000000" and FUNCT = "010100")) else --nor
			'0';

--I type instruction (not branch)
ALUSrc <= '1' after 2 ns when ((ALUOP = "000001") or --addi
										(ALUOP = "000010") or --subi
										(ALUOP = "000011") or --andi
										(ALUOP = "000100") or --ori
										(ALUOP = "000101") or --shl
										(ALUOP = "000110") or --shr
										(ALUOP = "000111") or --lw
										(ALUOP = "001000")) else --sw
			'0';

MemtoReg <= '1' after 2 ns when ((ALUOP = "000111")) else --load
				'0';
		
RegWrite <= ('1' and clock) when ((ALUOP = "000000" and FUNCT = "010000") or --add
											(ALUOP = "000000" and FUNCT = "010001") or --sub
											(ALUOP = "000000" and FUNCT = "010010") or --and
											(ALUOP = "000000" and FUNCT = "010011") or --or
											(ALUOP = "000000" and FUNCT = "010100") or --nor
											(ALUOP = "000001") or --addi
											(ALUOP = "000010") or --subi
											(ALUOP = "000011") or --andi
											(ALUOP = "000100") or --ori
											(ALUOP = "000101") or --shl
											(ALUOP = "000110") or --shr
											(ALUOP = "000111")) else --lw
--											(ALUOP = "001000")) else --sw
		'0';
		
MemWrite <= '1' after 10 ns when ((ALUOP = "001000")) else --store
		'0';

MemRead <= '1' after 2 ns when ((ALUOP = "000111")) else --load
		'0';

Branch <= '1' when ((ALUOP = "001001") or --blt
						(ALUOP = "001010") or --beq
						(ALUOP = "001011")) else --bne
		'0';

Jump <= '1' when ((ALUOP = "001100") or --jmp
						(ALUOP = "111111")) else --hal
			'0';

ALUcontrol <= "100000" after 2 ns when (ALUOP = "000000" and FUNCT = "010000") else --add
					"010001" after 2 ns when (ALUOP = "000000" and FUNCT = "010001") else --sub
					"010010" after 2 ns when (ALUOP = "000000" and FUNCT = "010010") else --and
					"010011" after 2 ns when (ALUOP = "000000" and FUNCT = "010011") else --or
					"010100" after 2 ns when (ALUOP = "000000" and FUNCT = "010100") else --nor
					"000001" after 2 ns when (ALUOP = "000001") else --addi
					"000010" after 2 ns when (ALUOP = "000010") else --subi
					"000011" after 2 ns when (ALUOP = "000011") else --andi
					"000100" after 2 ns when (ALUOP = "000100") else --ori
					"000101" after 2 ns when (ALUOP = "000101") else --shl
					"000110" after 2 ns when (ALUOP = "000110") else --shr
					"000111" after 2 ns when (ALUOP = "000111") else --lw
					"001000" after 2 ns when (ALUOP = "001000") else --sw
					"001001" after 2 ns when (ALUOP = "001001") else --blt
					"001010" after 2 ns when (ALUOP = "001010") else --beq
					"001011" after 2 ns when (ALUOP = "001011") else --bne
					"XXXXXX";

end Behavioral;