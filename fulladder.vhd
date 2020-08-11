library ieee;
use ieee.std_logic_1164.all;

entity fulladder is
	port(	signal cin : in std_logic;
			signal a: in std_logic;
			signal b: in std_logic;
			signal cout	 : out std_logic;
			signal s	 : out std_logic);
end fulladder;
architecture behave_3 of fulladder is
begin
	s <= a xor b xor cin;
	cout <= (a and b)or (b and cin) or (cin and a);
	
end behave_3;