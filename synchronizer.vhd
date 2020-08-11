library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity synchronizer is 
	port(	signal reset : in std_logic;
			signal clk	 : in std_logic;
			signal en	 : in std_logic;
			signal d		 : in std_logic_vector(3 downto 0);
			signal q		 : out std_logic_vector(3 downto 0));
end synchronizer;
architecture struc_1 of synchronizer is
	signal d_n : std_logic_vector(3 downto 0); 
begin
	seq: process(reset, clk)
	begin
		if (reset ='0') then
			d_n <= (others => '0');
			q <= (others => '0');
		elsif rising_edge(clk) then
			if (en = '1') then
				d_n <= d;
				q <=  d_n;
			end if;
		end if;
	end process seq;
end struc_1;