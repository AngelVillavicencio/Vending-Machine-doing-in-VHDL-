library ieee;
use ieee.std_logic_1164.all;
use work.my_componentdelvga_sync.all;
use ieee.numeric_std.all;

entity vga_sync is
	port(	 signal reset_n : in std_logic;
			signal clock_50 : in std_logic;
			signal VGA_HS		: out std_logic;
			signal VGA_VS		: out std_logic;
			signal VGA_blank:  out std_logic;
			signal count_v    : out std_logic_vector(9 downto 0);
			signal count_h    : out std_logic_vector(9 downto 0)
			);
end vga_sync;

architecture struc_1 of vga_sync is
	signal en_25	: std_logic;
	signal en_26	: std_logic;
	signal rst_sync1: std_logic;
	signal rst_sync2: std_logic;
	signal cuenta_v: std_logic_vector(9 downto 0);
	signal cuenta_h: std_logic_vector(9 downto 0);
	signal s1      : std_logic;
	signal s2      : std_logic;
begin
	U0: divisor port map (clk => clock_50, reset => reset_n, clk_o => en_25);
	U1: contador port map (clk => clock_50, reset =>reset_n,reset_sync =>rst_sync1 , en => en_25, q => cuenta_h);
	en_26 <= rst_sync1 and en_25;	
	U2: contador port map (clk => clock_50, reset =>reset_n,reset_sync=>rst_sync2 , en =>en_26, q => cuenta_v);
		count_v<= cuenta_v;
		count_h<= cuenta_h;
	p1 : process(cuenta_h)
	begin	
		if (unsigned(cuenta_h) = 799) then
		rst_sync1 <= '1';
		else 
		rst_sync1 <= '0';
		end if;
		if (unsigned(cuenta_h) > 639) then
		s1 <= '0';
		else 
		s1 <= '1';
		end if;
		if (unsigned(cuenta_h) > 655) then
			if( unsigned(cuenta_h) <752) then 
				VGA_HS <= '0';
			else 
				VGA_HS <= '1';
		end if;
		else 
			VGA_HS <= '1';
		end if;
	end process p1 ;
	
	p2 : process(cuenta_v)
	begin	
		if (unsigned(cuenta_v) = 519) then
		rst_sync2 <= '1';
		else 
		rst_sync2 <= '0';
		end if;
		if (unsigned(cuenta_v) > 479) then
		s2 <= '0';
		else 
		s2 <= '1';
		end if;
		if (unsigned(cuenta_v) > 488 and unsigned(cuenta_v) <491) then
		VGA_VS <= '0';
		else 
		VGA_VS <= '1';
		end if;
	
	end process p2 ;
	
VGA_blank <= s1 and s2; 

end struc_1;