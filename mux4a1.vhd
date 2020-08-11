library ieee;
use ieee.std_logic_1164.all;

entity mux4a1 is 
	port(	signal sel: in std_logic_vector(1 downto 0);
			signal a	: in std_logic_vector(3 downto 0);
			signal b	: in std_logic_vector(3 downto 0);
			signal c	: in std_logic_vector(3 downto 0);
			signal d	: in std_logic_vector(3 downto 0);
			signal f	: out std_logic_vector(3 downto 0));
end mux4a1;
architecture struc_5 of mux4a1 is
begin
	f <= a when (sel = "00") else
		  b when (sel = "01") else
		  c when (sel = "10") else
		  d when (sel = "11") else
		  "----";
end struc_5;