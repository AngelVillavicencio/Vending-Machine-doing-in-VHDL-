library ieee;
use ieee.std_logic_1164.all;

entity enganche is
	port(signal start,stop,clk,reset_n,en: in std_logic;
		  signal f: out std_logic);
end enganche;

architecture structural of enganche is
	signal y_stop,y_start,f_int: std_logic;
begin

	seq: process (reset_n,clk,en)
	begin
	
		if(reset_n='0') then
			f_int<='0';
		elsif rising_edge(clk) then
			if(en='1') then
				f_int<=y_stop;
			end if;
		end if;
	
	end process seq;
	
	y_stop<='0' when(stop='1') else
				y_start;
 
	y_start<= f_int when(start='0') else
				'1';

	f<=f_int;

end structural;