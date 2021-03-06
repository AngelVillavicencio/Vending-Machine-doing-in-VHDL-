library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.my_components_vuelto.all;

entity restador is
port(signal saldo	:	in std_logic_vector(7 downto 0);
	  signal sel	:	in std_logic_vector(1 downto 0);
	  signal en_vuelto:	in std_logic;
	  signal clock		:	in std_logic;
	  signal reset_n	:	in std_logic;
	  signal vuelto	: out std_logic_vector(7 downto 0));
end restador;
architecture behav of restador is
	signal y_r	:	std_logic_vector(7 downto 0);
	signal y_r_0:	std_logic_vector(7 downto 0);
	signal y_r_1:	std_logic_vector(7 downto 0);
begin
	U0: mux4a1_vuelto	  port map (sel =>sel, a => "00001111", b=> "00010100", c => "00011001", d => "00000000", f => y_r);
	U1: complemento_dos port map (a => y_r, f => y_r_0);
	y_r_1 <= std_logic_vector(unsigned(y_r_0) + unsigned(saldo));
	U2: registro_vuelto port map (en => en_vuelto, clock => clock, reset_n => reset_n, d => y_r_1, q => vuelto);
end behav;