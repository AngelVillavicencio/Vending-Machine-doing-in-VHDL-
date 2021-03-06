library ieee;
use ieee.std_logic_1164.all;

entity registro_vuelto is
port( signal en		: in std_logic;
		signal clock	: in std_logic;
		signal reset_n	: in std_logic;
		signal d			: in std_logic_vector(7 downto 0);
		signal q			: out std_logic_vector(7 downto 0));
end registro_vuelto;
architecture structural of registro_vuelto is

begin
	seq: process(reset_n, clock)
	begin
		if(reset_n = '0')then
		q <= (others => '0');
		elsif rising_edge(clock) then
			if (en = '1') then
			q <= d;
			end if;
		end if;
	end process seq;
end structural;