library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity contador4 is 
	generic ( n : natural := 4);
	port(	signal reset : in std_logic;
			signal en	 : in std_logic;
			signal clk	 : in std_logic;
			signal q		 : out std_logic_vector(1 downto 0));
end contador4;
architecture struc_3 of contador4 is
	signal q_next, q_reg : unsigned(1 downto 0);
begin
	seq: process(reset, clk)
	begin
		if (reset ='0') then
			q_reg <= (others => '0');
		elsif rising_edge(clk) then 
			q_reg <= q_next;
		end if;
	end process seq;
	
	comb: process(en, q_reg)
	begin
		if (en ='1') then
			if (q_reg = (n-1)) then
				q_next <= (others => '0');
			else
				q_next <= q_reg + 1;
			end if;
		else 
			q_next <= q_reg;
		end if;
	end process comb;
	q <= std_logic_vector(q_reg);
end struc_3;