library ieee;
use ieee.std_logic_1164.all;

entity detec_fs is
	port(signal w,clock,resetn,en: in std_logic;
		  signal z: out std_logic);
end detec_fs;

architecture structural of detec_fs is
	signal y: std_logic;
begin

	seq: process (resetn,clock,en)
	begin
	
		if(resetn='0') then
			y<='0';
		elsif rising_edge(clock) then
			if(en='1') then
				y<=w;
			end if;
		end if;
	
	end process seq;
	
	z<= (w and not(y));

end structural;