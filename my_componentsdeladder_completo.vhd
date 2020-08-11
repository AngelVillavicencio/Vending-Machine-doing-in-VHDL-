library ieee;
use ieee.std_logic_1164.all;

package my_componentsdeladder_completo is
	component adder is
	port(	signal c_in		: in std_logic;
			signal x			: in std_logic_vector(7 downto 0);
			signal y			: in std_logic_vector(7 downto 0);
			signal S			: out std_logic_vector(7 downto 0));
	end component;
end package;
