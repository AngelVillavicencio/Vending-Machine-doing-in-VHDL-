library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity decodificador is 
	port(	signal w	: in std_logic_vector(1 downto 0);
			signal en: in std_logic;
			signal y	: out std_logic_vector(3 downto 0));
end decodificador;
architecture struc_4 of decodificador is
	signal en_w : std_logic_vector(2 downto 0);
begin
	en_w <= en & w;
	y <= "0001" when (en_w = "100") else
		  "0010" when (en_w = "101") else
		  "0100" when (en_w = "110") else
		  "1000" when (en_w = "111") else
		  "0000" when (en_w(2)= '0') else
		  "----";
end struc_4;