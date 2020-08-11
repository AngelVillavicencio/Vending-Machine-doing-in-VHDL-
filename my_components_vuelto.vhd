library ieee;
use ieee.std_logic_1164.all;

package my_components_vuelto is
	
	component registro_vuelto is
	port( signal en		: in std_logic;
		signal clock	: in std_logic;
		signal reset_n	: in std_logic;
		signal d			: in std_logic_vector(7 downto 0);
		signal q			: out std_logic_vector(7 downto 0));
	end component;
	
	component mux4a1_vuelto is
	port( signal sel	: in std_logic_vector(1 downto 0);
		signal a		: in std_logic_vector(7 downto 0);
		signal b		: in std_logic_vector(7 downto 0);
		signal c		: in std_logic_vector(7 downto 0);
		signal d		: in std_logic_vector(7 downto 0);
		signal f		: out std_logic_vector(7 downto 0));
	end component;
	
	component complemento_dos is
   port(signal a :  in std_logic_vector(7 downto 0);
       signal f : out std_logic_vector(7 downto 0));
	end component;
end package;
