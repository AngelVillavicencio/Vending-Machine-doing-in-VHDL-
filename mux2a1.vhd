library ieee;
use ieee.std_logic_1164.all;

entity mux2a1 is
	port(	signal sel 	: in std_logic;
			signal a	  	: in std_logic_vector(7 downto 0);
			signal b		: in std_logic_vector(7 downto 0);
			signal f		: out std_logic_vector(7 downto 0));
end mux2a1;

architecture struc_0 of mux2a1 is
	constant DONT_CARE : std_logic_vector(7 downto 0) := (others => '-');
begin

	f <= a when (sel = '1') else
		  b when (sel = '0') else 
		  DONT_CARE;
end struc_0;