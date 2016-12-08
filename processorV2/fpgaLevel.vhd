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
		  g2a, cathode : out std_logic_vector(7 downto 0));
end fpgaLevel;

architecture Behavioral of fpgaLevel is

-- instruction memory
COMPONENT instMem
	PORT(addr : IN std_logic_vector(31 downto 0);          
		  inst : OUT std_logic_vector(31 downto 0));
END COMPONENT;

-- register file
type regFile is array (0 to 31) of std_logic_vector (31 downto 0);
signal procRegFile : regFile := (x"00000000",x"00000000",x"00000000",x"00000000",
											x"00000000",x"00000000",x"00000000",x"00000000",
											x"00000000",x"00000000",x"00000000",x"00000000",
											x"00000000",x"00000000",x"00000000",x"00000000",
											x"00000000",x"00000000",x"00000000",x"00000000",
											x"00000000",x"00000000",x"00000000",x"00000000",
											x"00000000",x"00000000",x"00000000",x"00000000",
											x"00000000",x"00000000",x"00000000",x"00000000");

-- Data Memory
type dataMem is array (0 to 63) of std_logic_vector (31 downto 0);
signal procDataMem : dataMem := (X"00000000",X"00000001",X"00000002",X"00000003",
											X"00000004",X"00000000",X"00000000",X"00000000",
											X"00000000",X"00000000",X"00000000",X"00000000",
											X"00000000",X"00000000",X"00000000",X"00000000",
											X"00000000",X"00000000",X"00000000",X"00000000",
											X"00000000",X"00000000",X"00000000",X"00000000",
											X"00000000",X"00000000",X"00000000",X"00000000",
											X"00000000",X"00000000",X"00000000",X"00000000",
											X"00000000",X"00000000",X"00000000",X"00000000",
											X"00000000",X"00000000",X"00000000",X"00000000",
											X"00000000",X"00000000",X"00000000",X"00000000",
											X"00000000",X"00000000",X"00000000",X"00000000",
											X"00000000",X"00000000",X"00000000",X"00000000",
											X"00000000",X"00000000",X"00000000",X"00000000",
											X"00000000",X"00000000",X"00000000",X"00000000",
											X"00000000",X"00000000",X"00000000",X"00000000");

-- decoder
COMPONENT decoder
	PORT(instruction : IN std_logic_vector(31 downto 0);          
		  iType       : OUT std_logic;
		  loadInst    : OUT std_logic;
		  storeInst   : OUT std_logic;
		  ALUop       : OUT std_logic_vector(5 downto 0);
		  HaltFlag    : OUT std_logic;
		  branchInst  : OUT std_logic;
		  jumpInst    : OUT std_logic);
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
signal HaltFlag : std_logic;
signal ALUop    : std_logic_vector(5 downto 0);
signal isBranch : std_logic;
signal isJump   : std_logic;

-- ALU signals
signal ALUop2    : std_logic_vector(31 downto 0);   
signal ALUresult : std_logic_vector(31 downto 0); 
signal branchOp  : std_logic;

-- write back signals
signal loadData : std_logic_vector(31 downto 0) := (others => '0'); 

-- 7 segment display module
COMPONENT display
	PORT(
		clk          : IN std_logic;
		clr          : IN std_logic;
		vctr2Display : IN std_logic_vector(31 downto 0);          
		g2a          : OUT std_logic_vector(7 downto 0);
		cathode      : OUT std_logic_vector(7 downto 0)
		);
END COMPONENT;

begin

-- next PC
PC_1 <= PC + '1';
PC_1_imm <= PC + '1' + imm;

process(clk, clr)
begin
if(clk'event and clk = '1') then
	if (clr = '1') then PC <= x"00000000";
	elsif(isBranch = '1' and  branchOp = '1') then PC <= PC_1_imm;
	elsif(isJump = '1') then PC <= PC_1(31 downto 26) & instruction(25 downto 0);
	else if (HaltFlag='1') then
		PC <= PC;
	else PC <= PC_1;
	end if;
end if;
end if;
end process;

myInstMem: instMem PORT MAP(
		addr => PC, 
		inst => instruction);

-- write register value selection MUX
with isItype select
	writeRegister <= instruction(15 downto 11) when '0',
						  instruction(20 downto 16) when others;

-- write enable
writeEnable <= not(isStore or isJump or isBranch);
regData1 <= procRegFile(conv_integer(instruction(25 downto 21)));
regData2 <= procRegFile(conv_integer(instruction(20 downto 16)));

process(writeEnable,clk)
begin
if (clr = '1') then
	procRegFile <= (others => (others => '0'));
elsif(clk'event and clk='1' and writeEnable = '1') then
	procRegFile(conv_integer(writeRegister)) <= writeBackData; 
end if;

end process;

myDecoder: decoder PORT MAP(
		instruction => instruction,
		iType       => isItype,
		loadInst    => isLoad,
		storeInst   => isStore,
		ALUop       => ALUop,
		branchInst  => isBranch,
		HaltFlag		=> HaltFlag,
		jumpInst    => isJump);

-- ALU operator
imm <= instruction(15 downto 0);

-- sign extended signal selection MUX
with imm(15) select
	sgnExtdImm <= x"0000" & imm when '0',
					  x"1111" & imm when others;

-- ALU operator2 selection MUX					  
with isItype select
	ALUop2 <= regData2 when '0',
				 sgnExtdImm when others;

myALU: ALU PORT MAP(
		op1    => regData1,
		op2    => ALUop2,
		ALUop  => ALUop,
		result => ALUresult);
		
branchOp <= ALUresult(0);

--Data Memory
process(isLoad, clk, procDataMem, ALUresult)
begin
if(isLoad = '1') then
	loadData <= procDataMem(conv_integer(ALUresult));
end if; 
end process;

process(isStore, clk, regData2, ALUresult)
begin
if(clk'event and clk = '1' and isStore = '1') then
	procDataMem(conv_integer(ALUresult)) <= regData2;
end if; 
end process;

-- write back data selection MUX
with isLoad select
	writeBackData <= ALUresult when '0',
				        loadData when others;
						  
my7SegmentDisplay: display PORT MAP(
		clk          => clk,
		clr          => clr,
		vctr2Display => writeBackData,
		g2a          => g2a,
		cathode      => cathode);

end Behavioral;