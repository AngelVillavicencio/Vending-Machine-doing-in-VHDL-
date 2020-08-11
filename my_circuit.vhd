library ieee;
use ieee.std_logic_1164.all;

package my_circuit is

	component vga_sync is
	port(	 signal reset_n : in std_logic;
			signal clock_50 : in std_logic;
			signal VGA_HS		: out std_logic;
			signal VGA_VS		: out std_logic;
			signal VGA_blank:  out std_logic;
			signal count_v    : out std_logic_vector(9 downto 0);
			signal count_h    : out std_logic_vector(9 downto 0)
			);
end component;
	
end package;