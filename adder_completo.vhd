library ieee;
use ieee.std_logic_1164.all;
use work.my_componentsdeladder_completo.all;

entity adder_completo is
	port(	signal A		: in std_logic_vector(7 downto 0);
			signal B		: in std_logic_vector(7 downto 0);
			signal C		: in std_logic_vector(7 downto 0);
			signal D		: in std_logic_vector(7 downto 0);
			signal E		: in std_logic_vector(7 downto 0);
			signal F		: out std_logic_vector(7 downto 0));
end adder_completo;
architecture struc_2 of adder_completo is
	signal m0	: std_logic_vector(7 downto 0);
	signal m1	: std_logic_vector(7 downto 0);
	signal m2	: std_logic_vector(7 downto 0);
	
begin
	U0: adder port map (c_in =>'0', x =>A , y =>B, s => m0);
	U1: adder port map (c_in =>'0', x =>m0, y =>C, s => m1);
	U2: adder port map (c_in =>'0', x =>m1, y =>D, s => m2);
	U3: adder port map (c_in =>'0', x =>m2, y =>E, s => F);

end struc_2;