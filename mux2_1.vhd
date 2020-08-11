library ieee;
use ieee.std_logic_1164.all;

entity mux2_1 is 
	port(	signal sel: in std_logic;
			signal a	: in std_logic_vector(6 downto 0);
			signal b	: in std_logic_vector(6 downto 0);
			signal f	: out std_logic_vector(6 downto 0));
end mux2_1;
architecture struc_6 of mux2_1 is
begin
	f <= a when (sel = '0') else
		  b when (sel = '1') else
		  "-------";
end struc_6;