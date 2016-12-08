library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ALU is
    Port ( op1    : in STD_LOGIC_VECTOR (31 downto 0);
           op2 	: in STD_LOGIC_VECTOR (31 downto 0);
			  ALUop  : in STD_LOGIC_VECTOR (5 downto 0);
           result : out STD_LOGIC_VECTOR (31 downto 0));
end ALU;

architecture operations of ALU is

signal addOp   : std_logic_vector (31 downto 0);
signal subOp   : std_logic_vector (31 downto 0);
signal andOp   : std_logic_vector (31 downto 0);
signal orOp    : std_logic_vector (31 downto 0);
signal norOp   : std_logic_vector (31 downto 0);
signal lftShft : std_logic_vector (31 downto 0);
signal rgtShft : std_logic_vector (31 downto 0);
signal blt 		: std_logic_vector (31 downto 0);
signal beq 		: std_logic_vector (31 downto 0);
signal bne 		: std_logic_vector (31 downto 0);

signal zero    : std_logic_vector (31 downto 0);

begin

-- add
addOp <= op1 + op2;

-- sub
subOp <= op1 - op2;

-- and
andOp <= op1 and op2;

-- or
orOp <= op1 or op2;

-- nor
norOp <= op1 nor op2;

-- zero array for zero padding
zero <= (others => '0');

-- left shift
with op2(4 downto 0) select
lftShft <= op1(30 downto 0) & zero(31) when "00001",
		     op1(29 downto 0) & zero(31 downto 30) when "00010",
		     op1(28 downto 0) & zero(31 downto 29) when "00011",
	     	  op1(27 downto 0) & zero(31 downto 28) when "00100",
		     op1(26 downto 0) & zero(31 downto 27) when "00101",
		     op1(25 downto 0) & zero(31 downto 26) when "00110",
		     op1(24 downto 0) & zero(31 downto 25) when "00111",
	        op1(23 downto 0) & zero(31 downto 24) when "01000",
		     op1(22 downto 0) & zero(31 downto 23) when "01001",
		     op1(21 downto 0) & zero(31 downto 22) when "01010",
		     op1(20 downto 0) & zero(31 downto 21) when "01011",
	    	  op1(19 downto 0) & zero(31 downto 20) when "01100",
		     op1(18 downto 0) & zero(31 downto 19) when "01101",
		     op1(17 downto 0) & zero(31 downto 18) when "01110",
		     op1(16 downto 0) & zero(31 downto 17) when "01111",
		     op1(15 downto 0) & zero(31 downto 16) when "10000",
		     op1(14 downto 0) & zero(31 downto 15) when "10001",
		     op1(13 downto 0) & zero(31 downto 14) when "10010",
		     op1(12 downto 0) & zero(31 downto 13) when "10011",
		     op1(11 downto 0) & zero(31 downto 12) when "10100",
		     op1(10 downto 0) & zero(31 downto 11) when "10101",
		     op1(9 downto 0) & zero(31 downto 10) when "10110",
		     op1(8 downto 0) & zero(31 downto 9) when "10111",
	 	     op1(7 downto 0) & zero(31 downto 8) when "11000",
		     op1(6 downto 0) & zero(31 downto 7) when "11001",
		     op1(5 downto 0) & zero(31 downto 6) when "11010",
		     op1(4 downto 0) & zero(31 downto 5) when "11011",
		     op1(3 downto 0) & zero(31 downto 4) when "11100",
		     op1(2 downto 0) & zero(31 downto 3) when "11101",
		     op1(1 downto 0) & zero(31 downto 2) when "11110",
		     op1(0) & zero(31 downto 1) when "11111",
		     op1 when others;

-- right shift
with op2(4 downto 0) select
rgtShft <= zero(30 downto 0) & op1(31) when "11111",
		     zero(29 downto 0) & op1(31 downto 30) when "11110",
		     zero(28 downto 0) & op1(31 downto 29) when "11101",
		     zero(27 downto 0) & op1(31 downto 28) when "11100",
		     zero(26 downto 0) & op1(31 downto 27) when "11011",
	        zero(25 downto 0) & op1(31 downto 26) when "11010",
		     zero(24 downto 0) & op1(31 downto 25) when "11001",
		     zero(23 downto 0) & op1(31 downto 24) when "11000",
		     zero(22 downto 0) & op1(31 downto 23) when "10111",
	 	     zero(21 downto 0) & op1(31 downto 22) when "10110",
		     zero(20 downto 0) & op1(31 downto 21) when "10101",
	   	  zero(19 downto 0) & op1(31 downto 20) when "10100",
		     zero(18 downto 0) & op1(31 downto 19) when "10011",
		     zero(17 downto 0) & op1(31 downto 18) when "10010",
		     zero(16 downto 0) & op1(31 downto 17) when "10001",
		     zero(15 downto 0) & op1(31 downto 16) when "10000",
		     zero(14 downto 0) & op1(31 downto 15) when "01111",
		     zero(13 downto 0) & op1(31 downto 14) when "01110",
		     zero(12 downto 0) & op1(31 downto 13) when "01101",
		     zero(11 downto 0) & op1(31 downto 12) when "01100",
		     zero(10 downto 0) & op1(31 downto 11) when "01011",
		     zero(9 downto 0) & op1(31 downto 10) when "01010",
		     zero(8 downto 0) & op1(31 downto 9) when "01001",
		     zero(7 downto 0) & op1(31 downto 8) when "01000",
		     zero(6 downto 0) & op1(31 downto 7) when "00111",
		     zero(5 downto 0) & op1(31 downto 6) when "00110",
		     zero(4 downto 0) & op1(31 downto 5) when "00101",
		     zero(3 downto 0) & op1(31 downto 4) when "00100",
		     zero(2 downto 0) & op1(31 downto 3) when "00011",
		     zero(1 downto 0) & op1(31 downto 2) when "00010",
		     zero(0) & op1(31 downto 1) when "00001",
		     op1 when others;

-- branch if less than
process(op1, op2)
begin
if(op1 < op2) then blt <= (others => '1');
else blt <= (others => '0');
end if;
end process;

-- branch if equal
process(op1, op2)
begin
if(op1 = op2) then beq <= (others => '1');
else beq <= (others => '0');
end if;
end process;

-- branch if not equal
process(op1, op2)
begin
if(op1 /= op2) then bne <= (others => '1');
else bne <= (others => '0');
end if;
end process;


-- result
with ALUop(5 downto 0) select
	result <= addOp when "010000", addOp when "000001", addOp when "000111", addOp when "001000",
				 subOp when "010001", subOp when "000010",
				 andOp when "010010", andOp when "000011",
				 orOp when "010011", orOp when "000100",
				 norOp when "010100",
				 lftShft when "000101",
				 rgtShft when "000110",
				 blt when "001001",
				 beq when "001010",
				 bne when "001011",
				 (others => '0') when others;
				 

end operations;

