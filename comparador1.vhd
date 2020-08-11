library ieee;
use ieee.std_logic_1164.all;

entity comparador1 is
	port(	signal a	: in std_logic_vector(7 downto 0);
			signal b	: in std_logic_vector(7 downto 0);
			signal f	: out std_logic);
end comparador1;
architecture struc_3 of comparador1 is
begin
	f <= '1' when (a >= b) else
		  '0';
end struc_3;