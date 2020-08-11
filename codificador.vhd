library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity codificador is 
	port(	signal w	: in std_logic_vector(3 downto 0);
			signal z	: out std_logic;
			signal y	: out std_logic_vector(1 downto 0));
end codificador;
architecture struc_2 of codificador is
	constant zeros : std_logic_vector(3 downto 0) := (others => '0');
begin
	y <= "11" when (w(3) = '1') else
		  "10" when (w(2) = '1') else
		  "01" when (w(1) = '1') else
		  "00" when (w(0) = '1') else
		  "--";
	z <= '1' when (w = zeros) else '0';
end struc_2;