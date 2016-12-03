library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;

entity instMem is
    Port ( addr : in  STD_LOGIC_VECTOR (31 downto 0);
           inst : out  STD_LOGIC_VECTOR (31 downto 0));
end instMem;

architecture Behavioral of instMem is

type instMem is array (0 to 511) of std_logic_vector (31 downto 0);
signal procInstMem : instMem;

begin

inst <= procInstMem(conv_integer(addr));

end Behavioral;

