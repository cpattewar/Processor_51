library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity decoder is
    Port ( instruction : in  STD_LOGIC_VECTOR (31 downto 0);
           iType       : out  STD_LOGIC;
           loadInst    : out  STD_LOGIC;
           storeInst   : out  STD_LOGIC;
           ALUop       : out  STD_LOGIC_VECTOR (5 downto 0);
           branchInst  : out  STD_LOGIC;
			  HaltFlag    : out STD_LOGIC;
           jumpInst    : out  STD_LOGIC);
end decoder;

architecture decodeFlags of decoder is

begin

-- I type inst flag
with instruction(31 downto 26) select
	iType <= '1' when "000001",
				'1' when "000010",
				'1' when "000011",
				'1' when "000100",
				'1' when "000101",
				'1' when "000110",
				'1' when "000111",
				'1' when "001000",
				'0' when others;

-- load inst flag 
with instruction(31 downto 26) select
	loadInst <= '1' when "000111",
					'0' when others;

-- store inst flag					
with instruction(31 downto 26) select
	storeInst <= '1' when "001000",
					 '0' when others;

-- ALU operation	 
with instruction(31 downto 26) select
	ALUop <= instruction(5 downto 0) when "000000",
				instruction(31 downto 26) when others;

-- branch inst flag
with instruction(31 downto 26) select
	branchInst <= '1' when "001001",
					  '1' when "001010",
					  '1' when "001011",
					  '0' when others;

-- jump inst flag
with instruction(31 downto 26) select
	jumpInst <= '1' when "001100",
				   '0' when others;

-- halt inst flag
with instruction(31 downto 26) select
	HaltFlag <=	'1' when "111111",
					'0' when others;

end decodeFlags;

