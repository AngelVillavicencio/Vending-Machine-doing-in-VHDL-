library ieee;
use ieee.std_logic_1164.all;

entity ffd is
	port(	signal en : in std_logic;
			signal reset: in std_logic;
			signal clk: in std_logic;
			signal d	 : in std_logic;
			signal q	 : out std_logic);
end ffd;
architecture behave of ffd is
	signal q_reg, q_next: std_logic;
begin
	seq : process(clk, reset)
	begin
	if (reset = '0') then
		q_reg <= '0';
	elsif rising_edge(clk) then
		q_reg <= q_next;
	end if;
	end process seq;
	
	q_next <= d when (en='1') else q_reg;
	q <= q_reg;
end behave;