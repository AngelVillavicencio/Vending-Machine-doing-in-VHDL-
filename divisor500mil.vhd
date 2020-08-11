library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity divisor500mil is
	generic( n	: natural := 500000);
	
	port(	signal clk	 : in std_logic;
			signal reset : in std_logic;
			signal clk_o: out std_logic);
end divisor500mil;

architecture behave_0 of divisor500mil is
	signal clk_o_reg, clk_o_next : std_logic;
	signal q_reg, q_next : unsigned(18 downto 0);
begin
	seq: process(reset, clk)
	begin
		if (reset ='0') then
		clk_o_reg <= '0';
		q_reg <= (others => '0');
		elsif rising_edge(clk) then
		clk_o_reg <= clk_o_next;
		q_reg <= q_next;
		end if;
	end process seq;
	
	comb: process(q_reg)
	begin
		if (q_reg = (n-1)) then
		clk_o_next <= '1';
		q_next <= (others =>'0');
		else 
		clk_o_next <= '0';
		q_next <= q_reg +1;
		end if;
	end process comb;
	
	clk_o <= clk_o_reg;
		
	
end behave_0;