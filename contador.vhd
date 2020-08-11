library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity contador is 
	port(	signal clk	: in std_logic;
			signal en	: in std_logic;
			signal reset: in std_logic;
			signal reset_sync: in std_logic;
			signal q		: out std_logic_vector(9 downto 0));
end contador;

architecture struc of contador is 
	signal q_reg, q_next : unsigned(9 downto 0);
begin
	seq: process(reset, clk)
	begin
		if (reset ='0') then
		q_reg <= (others => '0');
		elsif rising_edge(clk) then
		q_reg <= q_next;
		end if;
	end process seq;
	
	comb1 : process(q_reg, en, reset_sync )
			begin
			
			if (en  = '1') then
				if (reset_sync = '1') then
				q_next <= (others=>'0');
				else 
				q_next <= (q_reg + 1);
				end if;
			else 
				q_next <= q_reg;
			end if;
	end process comb1;
	
	q <= std_logic_vector(q_reg);
		
end struc;
			