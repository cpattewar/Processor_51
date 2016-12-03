library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;

entity dataMemory is
    Port ( addr     : in  STD_LOGIC_VECTOR (31 downto 0);
           wrtData  : in  STD_LOGIC_VECTOR (31 downto 0);
           readEnbl : in  STD_LOGIC;
           wrtEnbl  : in  STD_LOGIC;
           readData : out STD_LOGIC_VECTOR (31 downto 0));
end dataMemory;

architecture data of dataMemory is

type dataMem is array (0 to 63) of std_logic_vector (31 downto 0);
signal procDataMem : dataMem;

begin

process(readEnbl)
begin
if(readEnbl = '1') then
	readData <= procDataMem(conv_integer(addr));
end if; 
end process;

process(wrtEnbl)
begin
if(wrtEnbl = '1') then
	procDataMem(conv_integer(addr)) <= wrtData;
end if; 
end process;

end data;

