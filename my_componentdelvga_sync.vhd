library ieee;
use ieee.std_logic_1164.all;

package my_componentdelvga_sync is

	component divisor is	
	port(	signal clk	 : in std_logic;
			signal reset : in std_logic;
			signal clk_o: out std_logic);
	end component;

	component contador is 
	port(	signal clk	: in std_logic;
			signal en	: in std_logic;
			signal reset: in std_logic;
			signal reset_sync: in std_logic;
			signal q		: out std_logic_vector(9 downto 0));
	end component;
	
end package;