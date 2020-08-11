library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity divisor5millones is
	generic (n	: natural := 5000000);
	port(	signal reset : in std_logic;
			signal clk : in std_logic;
			signal d : out std_logic);
end divisor5millones;
architecture struc_0 of divisor5millones is
	signal q_reg, q_next : unsigned(22 downto 0);------22---
	signal d_reg, d_next : std_logic;
begin
	seq: process(reset, clk)
	begin
		if(reset = '0') then
			q_reg <= (others => '0');
			d_reg <= '0';
		elsif rising_edge(clk) then 
			q_reg <= q_next;
			d_reg <= d_next;
		end if;
	end process seq;
	
	comb: process(q_reg)
	begin
		if (q_reg =(n-1)) then
			q_next <= (others => '0');
			d_next <= '1';
		else 
			q_next <= q_reg + 1;
			d_next <= '0';
		end if;
	end process comb;
	d <= d_reg;

end struc_0;