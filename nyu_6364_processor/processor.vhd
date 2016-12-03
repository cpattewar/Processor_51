library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.numeric_std.all;

entity processor is
port(reset : in STD_LOGIC;
		clock : in std_logic;
      OUTPUT : out STD_LOGIC_VECTOR(31 downto 0));
end processor;

architecture Behavioral of processor is

component PC
Port(input : in std_logic_vector(31 downto 0);
		reset : in STD_LOGIC;
		clock : in std_logic;
		output : out STD_LOGIC_VECTOR(31 downto 0));
end component;

component InstrMem
Port(readAddr : in STD_LOGIC_VECTOR(31 downto 0);
		Instr : out STD_LOGIC_VECTOR(31 downto 0));
end component;

component ALU_CONTROL
port(ALUOP : in STD_LOGIC_VECTOR(5 downto 0);
		FUNCT : in STD_LOGIC_VECTOR(5 downto 0);
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
end component;

component REG_MUX
port(RegDst : in STD_LOGIC;
		INSTR_20TO16 : in STD_LOGIC_VECTOR(4 downto 0);
		INSTR_15TO11 : in STD_LOGIC_VECTOR(4 downto 0);
		WriteRegisterIN : out STD_LOGIC_VECTOR(4 downto 0));
end component;

component register_file_project
port(read_reg1 : in std_logic_vector(4 downto 0); --first read register
		read_reg2 : in std_logic_vector(4 downto 0); --second read register
		write_reg : in std_logic_vector(4 downto 0); --write register
		write_data : in std_logic_vector(31 downto 0); --data to be written
		write_enable : in std_logic;
		read_data1 : out std_logic_vector(31 downto 0);
		read_data2 : out std_logic_vector(31 downto 0));
end component;

component shftleft2
Port(SHFTLEFT2IN : IN std_logic_vector(31 downto 0);
		SHFTLEFT2OUT : OUT std_logic_vector(31 downto 0));
end component;

component branch_adder
port(Pcplus4 : in STD_LOGIC_VECTOR(31 downto 0);
		shiftleftout : in STD_LOGIC_VECTOR(31 downto 0);
		branchaddout : out STD_LOGIC_VECTOR(31 downto 0));
end component;

component pcsrc_and
port(a : in std_logic;
		b : in std_logic;
		c : out std_logic);
end component;

component PCSRC_MUX
port(PCSrc : in STD_LOGIC;
		PCPLUS4 : in STD_LOGIC_VECTOR(31 downto 0);
		SHFLFT2OUT : in STD_LOGIC_VECTOR(31 downto 0);
		PCin : out STD_LOGIC_VECTOR(31 downto 0));
end component;

component ALU_MUX
port(ALUSrc : in STD_LOGIC;
		ReadData2 : in STD_LOGIC_VECTOR(31 downto 0);	
		SIGNEXTOUT : in STD_LOGIC_VECTOR(31 downto 0);
		ALU_IN2 : out STD_LOGIC_VECTOR(31 downto 0));
end component;

component SIGN_EXT
port(REG_16_IN : in STD_LOGIC_VECTOR(15 downto 0);
		REG_32_OUT : out STD_LOGIC_VECTOR(31 downto 0));
end component;

component myalu
port(IN1 : in STD_LOGIC_VECTOR(31 downto 0);
		IN2 : in STD_LOGIC_VECTOR (31 downto 0);
		alucontrol : in STD_LOGIC_VECTOR(5 downto 0);
		ZERO : out STD_LOGIC;
		RESULT : out STD_LOGIC_VECTOR(31 downto 0));
end component;

component DataMemory
port(Address : in std_logic_vector(31 downto 0);
		WriteData : in std_logic_vector(31 downto 0);
		MemRead : in std_logic;
		MemWrite : in std_logic;
		ReadData : out std_logic_vector(31 downto 0));
end component;

component DATAMEM_MUX
port(MemtoReg : in STD_LOGIC;
		READDATAOUT : in STD_LOGIC_VECTOR(31 downto 0);
		ALUOUT : in STD_LOGIC_VECTOR(31 downto 0);
		WriteData_IN : out STD_LOGIC_VECTOR(31 downto 0));
end component;

component PC_ADD
port(PC : in STD_LOGIC_VECTOR(31 downto 0);
		RESULT :	out STD_LOGIC_VECTOR(31 downto 0));
end component;

component shift_left_2_jump
port(INSTR_25to0 : in std_logic_vector(25 downto 0);
		pc4 : in std_logic_vector(31 downto 0);
		J_address : out std_logic_vector(31 downto 0));
end component;

component jump_mux
port(jump_address : in std_logic_vector(31 downto 0);
		pcsrc_mux_out : in std_logic_vector(31 downto 0);
		pcplus4 : out std_logic_vector(31 downto 0);
		jump_signal : in std_logic);
end component;

--PC control signals
signal tPCout : STD_LOGIC_VECTOR(31 downto 0);

--PC add control signals
signal tPCplus4 :STD_LOGIC_VECTOR(31 downto 0);

--Jump shift left signals
signal tjshiftleft2out: STD_LOGIC_VECTOR(31 downto 0);

--Instruction Memory signals
signal tinstructionout : STD_LOGIC_VECTOR(31 downto 0);

--alu control signals
signal tRegDst : STD_LOGIC;
signal tALUSrc : STD_LOGIC;
signal tMemtoReg : STD_LOGIC;
signal tRegWrite : STD_LOGIC;
signal tMemWrite : STD_LOGIC;
signal tMemRead : STD_LOGIC;
signal tBranch: STD_LOGIC;
signal tJump : STD_LOGIC;
signal tALUcontrol : STD_LOGIC_VECTOR(5 downto 0);

--reg mux signal
signal TWriteRegisterIN: STD_LOGIC_VECTOR(4 downto 0);

--regfile signals
signal tReadData1: STD_LOGIC_VECTOR(31 downto 0);
signal tReadData2: STD_LOGIC_VECTOR(31 downto 0);

--signextend signals
signal treg32out: STD_LOGIC_VECTOR(31 downto 0);

--shift left 2 signals
signal tshiftleft2out : STD_LOGIC_VECTOR(31 downto 0);

--ALU mux signals
signal taluinput2: STD_LOGIC_VECTOR(31 downto 0);

--branch adder signals
signal tbranchaddout : STD_LOGIC_VECTOR(31 downto 0);

--ALU signals
signal tzero: STD_LOGIC;
signal taluresult: STD_LOGIC_VECTOR(31 downto 0);

--PCSrc and signals
signal tPCSrc: STD_LOGIC;

--PCSrc mux signals
signal tPCin: STD_LOGIC_VECTOR(31 downto 0);

--Datamemory signals
signal treaddata: STD_LOGIC_VECTOR(31 downto 0);

--Datamemmux output
signal tWriteDatain: STD_LOGIC_VECTOR(31 downto 0);

-- Update Pc
signal tUpdatePcin: std_logic_vector (31 downto 0);

begin

mypc: PC
Port map(input => tUpdatePcin,
			reset => reset,
			output => tPCout,
			clock => clock);

mypcadd: PC_ADD
port map(PC => tPCout,
			RESULT => tPCplus4);

myinstructionmemory: InstrMem
Port map(readAddr => tPCout,
			Instr => tinstructionout);

myalucontrol: ALU_CONTROL
port map(ALUOP => tinstructionout(31 downto 26),
			FUNCT => tinstructionout(5 downto 0),
			RegDst => tRegDst,
			ALUSrc => tALUSrc,
			MemtoReg => tMemtoReg,
			RegWrite => tRegWrite,
			MemRead => tMemRead,
			Branch => tBranch,
			MemWrite => tMemWrite,
			Jump => tJump,
			ALUcontrol => tALUcontrol,
			clock => clock);

myregmux: REG_MUX
port map(RegDst => tRegDst,
			INSTR_20TO16 => tinstructionout(20 downto 16),
			INSTR_15TO11 => tinstructionout(15 downto 11),
			WriteRegisterIN => TWriteRegisterIN);

myreg: register_file_project
port map(read_reg1 => tinstructionout(25 downto 21),
			read_reg2 => tinstructionout(20 downto 16),
			write_reg => TWriteRegisterIN,
			write_data => tWriteDatain,
			write_enable => tRegWrite,
			read_data1 => tReadData1,
			read_data2 => tReadData2);

mysignext: SIGN_EXT
port map(REG_16_IN => tinstructionout(15 downto 0),
			REG_32_OUT => treg32out);

myshiftleft2: shftleft2
Port map(SHFTLEFT2IN => treg32out,
			SHFTLEFT2OUT => tshiftleft2out);

mybranchadder: branch_adder
port map(Pcplus4 => tPCplus4,
			shiftleftout => tshiftleft2out,
			branchaddout => tbranchaddout);

myalumux: ALU_MUX
port map(ALUSrc => tALUSrc,
			ReadData2 => tReadData2,
			SIGNEXTOUT => treg32out,
			ALU_IN2 => taluinput2);

myyalu: myalu
port map(IN1 => tReadData1,
			IN2 => taluinput2,
			alucontrol => tALUcontrol,
			ZERO => tzero,
			RESULT => taluresult);

mypcsrcand: pcsrc_and
port map(a => TBranch,
			b => tzero,
			c => tPCSrc);

myPCSrcmux: PCSRC_MUX
port map(PCSrc => tPCSrc,
			PCPLUS4 => tPCplus4,
			SHFLFT2OUT => tBranchaddout,
			PCin => tpcin);

mydatamemory: DataMemory
port map(Address => taluresult,
			WriteData => tReadData2,
			MemRead => tMemRead,
			MemWrite => tMemWrite,
			ReadData => treaddata);

mydatamemorymux: DATAMEM_MUX
port map(MemtoReg => tMemtoReg,
			READDATAOUT => treaddata,
			ALUOUT => taluresult,
			WriteData_IN => tWriteDatain);

myshiftleft2jump: shift_left_2_jump
port map(INSTR_25to0 => tinstructionout(25 downto 0),
			pc4 => tPCplus4,
			J_address => tjshiftleft2out);

myjumpmux: jump_mux
port map(jump_address => tjshiftleft2out,
			pcsrc_mux_out => tpcin,
			pcplus4 => tUpdatePcin,
			jump_signal=> tJump);

OUTPUT <= tWriteDatain;

end Behavioral;