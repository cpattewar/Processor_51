LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY fpgaLevel_test IS
END fpgaLevel_test;
 
ARCHITECTURE behavior OF fpgaLevel_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT fpgaLevel
    PORT(
         clr : IN  std_logic;
         clkSelector : IN  std_logic;
         buttonClk : IN  std_logic;
         clk : IN  std_logic;
         sw : IN  std_logic_vector(11 downto 0);
         g2a : OUT  std_logic_vector(7 downto 0);
         anode : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clr : std_logic := '0';
   signal clkSelector : std_logic := '0';
   signal buttonClk : std_logic := '0';
   signal clk : std_logic := '0';
   signal sw : std_logic_vector(11 downto 0) := (others => '0');

 	--Outputs
   signal g2a : std_logic_vector(7 downto 0);
   signal anode : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant clkSelector_period : time := 20 ns;
   constant buttonClk_period : time := 20 ns;
   constant clk_period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: fpgaLevel PORT MAP (
          clr => clr,
          clkSelector => clkSelector,
          buttonClk => buttonClk,
          clk => clk,
          sw => sw,
          g2a => g2a,
          anode => anode
        );

   -- Clock process definitions
   clkSelector_process :process
   begin
		clkSelector <= '0';
		wait for 1 s;
		clkSelector <= '1';
		wait for 1 s;
   end process;
 
   buttonClk_process :process
   begin
		buttonClk <= '0';
		wait for 10 ns;
		buttonClk <= '1';
		wait for 10 ns;
   end process;
 
   clk_process :process
   begin
		clk <= '1';
		wait for clk_period/2;
		clk <= '0';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   proc_clr: process
   begin		
      clr <= '1';
		wait for 20 ns;
		clr <= '0';
		wait for 1 s;
   end process;

	proc_sw: process
   begin		
      sw <= x"000";
		wait for 20 ns;
		sw <= x"001";
		wait for 20 ns;
		sw <= x"002";
		wait for 20 ns;
		sw <= x"003";
		wait for 20 ns;
		sw <= x"004";
		wait for 20 ns;
		sw <= x"005";
		wait for 20 ns;
		sw <= x"006";
		wait for 20 ns;
		sw <= x"007";
		wait for 20 ns;
		sw <= x"008";
		wait for 20 ns;
		sw <= x"009";
		wait for 20 ns;
		sw <= x"00a";
		wait for 20 ns;
		sw <= x"00b";
		wait for 20 ns;
		sw <= x"00c";
		wait for 20 ns;
		sw <= x"00d";
		wait for 20 ns;
		sw <= x"00e";
		wait for 20 ns;
		sw <= x"00f";
		wait for 20 ns;
		sw <= x"010";
		wait for 20 ns;
		sw <= x"011";
		wait for 20 ns;
		sw <= x"012";
		wait for 20 ns;
		sw <= x"013";
		wait for 20 ns;
		sw <= x"014";
		wait for 20 ns;
		sw <= x"015";
		wait for 20 ns;
		sw <= x"016";
		wait for 20 ns;
		sw <= x"017";
		wait for 20 ns;
		sw <= x"018";
		wait for 20 ns;
		sw <= x"019";
		wait for 20 ns;
		sw <= x"02a";
		wait for 20 ns;
		sw <= x"02b";
		wait for 20 ns;
		sw <= x"02c";
		wait for 20 ns;
		sw <= x"02d";
		wait for 20 ns;
		sw <= x"02e";
		wait for 20 ns;
		sw <= x"02f";
		wait for 20 ns;
		sw <= x"030";
		wait for 20 ns;
		sw <= x"031";
		wait for 20 ns;
		sw <= x"032";
		wait for 20 ns;
		sw <= x"033";
		wait for 20 ns;
		sw <= x"034";
		wait for 20 ns;
   end process;

END;
