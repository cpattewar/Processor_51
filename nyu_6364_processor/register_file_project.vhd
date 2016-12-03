library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity register_file_project is
port(read_reg1 : in std_logic_vector(4 downto 0); --first read register
     read_reg2 : in std_logic_vector(4 downto 0); --second read register
     write_reg : in std_logic_vector(4 downto 0);  --write register
     write_data : in std_logic_vector(31 downto 0); --data to be written
     write_enable : in std_logic;
     read_data1 : out std_logic_vector(31 downto 0);
     read_data2 : out std_logic_vector(31 downto 0));
end register_file_project;

architecture Behavioral of register_file_project is

type reg_array is array(0 to 31) of std_logic_vector (31 downto 0);
signal regs:reg_array := (others => (others => '0'));

begin

regfile: process(write_enable, write_data, write_reg)
begin
	if(write_enable = '1') then
		regs(to_integer(unsigned(write_reg))) <= write_data; --write reg
end if;
end process regfile;

read_data1 <= regs(to_integer(unsigned(read_reg1))); --read register 1
read_data2 <= regs(to_integer(unsigned(read_reg2))); --read register 2

end Behavioral;