----------------------------------------------------------------------------------
-- Company             :    Advanced Hardware Design
-- Engineer            :    Chaitanya Pattewar
-- 
-- Create Date         :    07:48:08 11/16/2016 
-- Design Name         :    Processor_51
-- Module Name         :    fpgaLevel - Behavioral 
-- Project Name        :    ACHD Project
-- Target Devices      :    Artix7 - XC7A100T - 1CSG324
-- Description         :    Processor based on MIPS ISA 
--
-- Additional Comments : 
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;

entity fpgaLevel is
	Port(clr				: in std_logic;
		  clk 			: in std_logic;
		  sw				: in std_logic_vector(15 downto 0);
		  -- buttons
		  a2g, cathode : out std_logic_vector(7 downto 0));
end fpgaLevel;

architecture Behavioral of fpgaLevel is

-- instruction memory
COMPONENT instMem
	PORT(addr : IN std_logic_vector(31 downto 0);          
		  inst : OUT std_logic_vector(31 downto 0));
END COMPONENT;

-- register file
COMPONENT registerFile
	PORT(readReg1  : IN std_logic_vector(4 downto 0);
		  readReg2  : IN std_logic_vector(4 downto 0);
		  wrtReg    : IN std_logic_vector(4 downto 0);
		  wrtData   : IN std_logic_vector(31 downto 0);
		  wrtEnbl   : IN std_logic;          
		  readData1 : OUT std_logic_vector(31 downto 0);
		  readData2 : OUT std_logic_vector(31 downto 0));
END COMPONENT;

-- decoder
COMPONENT decoder
	PORT(instruction : IN std_logic_vector(31 downto 0);          
		  iType       : OUT std_logic;
		  loadInst    : OUT std_logic;
		  storeInst   : OUT std_logic;
		  ALUop       : OUT std_logic_vector(5 downto 0);
		  branchInst  : OUT std_logic;
		  jumpInst    : OUT std_logic);
END COMPONENT;

-- data memory
COMPONENT dataMemory
	PORT(
		addr     : IN std_logic_vector(31 downto 0);
		wrtData  : IN std_logic_vector(31 downto 0);
		readEnbl : IN std_logic;
		wrtEnbl  : IN std_logic;          
		readData : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

-- Arithmetic Logic Unit
COMPONENT ALU
	PORT(
		op1    : IN std_logic_vector(31 downto 0);
		op2    : IN std_logic_vector(31 downto 0);
		ALUop  : IN std_logic_vector(5 downto 0);          
		result : OUT std_logic_vector(31 downto 0));
END COMPONENT;

-- program counter
signal PC       : std_logic_vector(31 downto 0) := x"00000000";			
signal nextPC   : std_logic_vector(31 downto 0) := x"00000000";
signal PC_1     : std_logic_vector(31 downto 0) := x"00000000";
signal PC_1_imm : std_logic_vector(31 downto 0) := x"00000000";

-- instruction
signal instruction : std_logic_vector(31 downto 0);

-- immediate
signal imm        : std_logic_vector(15 downto 0);
signal sgnExtdImm : std_logic_vector(31 downto 0);

-- register file
signal writeRegister : std_logic_vector(4 downto 0);
signal regData1      : std_logic_vector(31 downto 0);
signal regData2      : std_logic_vector(31 downto 0);
signal writeBackData : std_logic_vector(31 downto 0);
signal writeEnable   : std_logic;

-- flags
signal isItype  : std_logic;
signal isLoad   : std_logic;
signal isStore  : std_logic;
signal ALUop    : std_logic;
signal isBranch : std_logic;
signal isJump   : std_logic;

-- ALU signals
signal ALUop2    : std_logic_vector(31 downto 0);   
signal ALUresult : std_logic_vector(31 downto 0); 
signal branchOp  : std_logic;

-- write back signals
signal loadData : std_logic_vector(31 downto 0); 

begin

-- next PC
PC_1 <= PC + '1';
PC_1_imm <= PC + '1' + imm;

process(clk)
begin
if(clk'event and clk = '1') then
	if(isBranch = '1' and  branchOp = '1') then
		NextPC <= PC_1_imm;
	elsif(isJump = '1') then
		NextPC <= PC_1(31 downto 26) & instruction(25 downto 0);
	else
		NextPC <= PC_1;
	end if;
end if;
end process;

Inst_instMem: instMem PORT MAP(
		addr => PC, 
		inst => instruction);

-- write register value selection MUX
with isItype select
	writeRegister <= instruction(15 downto 11) when '0',
						  instruction(20 downto 16) when others;

-- write enable
writeEnable <= not(isStore or isJump or isBranch);

Inst_registerFile: registerFile PORT MAP(
		readReg1  => instruction(25 downto 21),
		readReg2  => instruction(20 downto 16),
		wrtReg    => writeRegister,
		wrtData   => writeBackData,
		wrtEnbl   => writeEnable,
		readData1 => regData1,
		readData2 => regData2);

Inst_decoder: decoder PORT MAP(
		instruction => instruction,
		iType       => isItype,
		loadInst    => isLoad,
		storeInst   => isStore,
		ALUop       => ALUop,
		branchInst  => isBranch,
		jumpInst    => isJump);

-- ALU operator
imm <= instruction(15 downto 0);

-- sign extended signal selection MUX
with imm(15) select
	sgnExtdImm <= x"00000000" & imm when '0',
					  x"11111111" & imm when others;

-- ALU operator2 selection MUX					  
with isItype select
	ALUop2 <= regData2 when '0',
				 sgnExtdImm when others;

Inst_ALU: ALU PORT MAP(
		op1    => regData1,
		op2    => ALUop2,
		ALUop  => ALUop,
		result => ALUresult);
		
branchOp <= ALUresult(0);

Inst_dataMemory: dataMemory PORT MAP(
		addr     => ALUresult,
		wrtData  => regData2,
		readEnbl => isLoad,
		wrtEnbl  => isStore,
		readData => loadData);

-- write back data selection MUX
with isLoad select
	writeBackData <= ALUresult when '0',
				        loadData when others;

end Behavioral;

