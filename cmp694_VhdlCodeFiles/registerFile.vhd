library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;


entity registerFile is
    Port ( readReg1  : in  STD_LOGIC_VECTOR (4 downto 0);
           readReg2  : in  STD_LOGIC_VECTOR (4 downto 0);
           wrtReg    : in  STD_LOGIC_VECTOR (4 downto 0);
           wrtData   : in  STD_LOGIC_VECTOR (31 downto 0);
           wrtEnbl   : in  STD_LOGIC;
           readData1 : out STD_LOGIC_VECTOR (31 downto 0);
           readData2 : out STD_LOGIC_VECTOR (31 downto 0));
end registerFile;

architecture registers of registerFile is

type regFile is array (0 to 31) of std_logic_vector (31 downto 0);
signal procRegFile : regFile;

begin

readData1 <= procRegFile(conv_integer(readReg1));
readData2 <= procRegFile(conv_integer(readReg2));

process(wrtEnbl)
begin

if(wrtEnbl = '1') then
	procRegFile(conv_integer(wrtReg)) <= wrtData; 
end if;

end process;

end registers;

