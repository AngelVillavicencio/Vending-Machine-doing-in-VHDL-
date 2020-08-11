library ieee;
use ieee.std_logic_1164.all;

package my_componentdeladder is
	component fulladder is
	port(	signal cin : in std_logic;
			signal a: in std_logic;
			signal b: in std_logic;
			signal cout	 : out std_logic;
			signal s	 : out std_logic);
	end component;
end package;
