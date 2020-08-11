library ieee;
use ieee.std_logic_1164.all;
use work.my_componentdeladder.all;

entity adder is
	port(	signal c_in		: in std_logic;
			signal x			: in std_logic_vector(7 downto 0);
			signal y			: in std_logic_vector(7 downto 0);
			signal S			: out std_logic_vector(7 downto 0));
end adder;
architecture struc_0 of adder is
	signal c : std_logic_vector(8 downto 0);
begin
		gen0: for i in 0 to 7 generate
		begin
		U0 : fulladder port map (cin => c(i), a =>x(i), b => y(i), cout => c(i+1), s => S(i));
		end generate gen0;
		
		c(0) <= c_in;
		
end struc_0;



