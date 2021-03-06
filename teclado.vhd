library ieee;
use ieee.std_logic_1164.all;
use work.my_componentsdelteclado.all;
use ieee.numeric_std.all;

entity teclado is 
	port(	signal reset_n	: in std_logic;
			signal clock_50: in std_logic;
			signal filas	: in std_logic_vector(3 downto 0);
			signal display	: out std_logic_vector(6 downto 0);
			signal columnas: out std_logic_vector(3 downto 0);
			signal z_n1		: out std_logic;
			signal in_hexa : out std_logic_vector(3 downto 0));
end teclado;
architecture structural of teclado is
	signal en_df		: std_logic;
	signal filas_sync	: std_logic_vector(3 downto 0);
	signal filas_1		: std_logic_vector(3 downto 0);
	signal z_n			: std_logic;
	signal fila_bin	: std_logic_vector(1 downto 0);
	signal col_bin		: std_logic_vector(1 downto 0);
	signal en_1			: std_logic;
	signal columna_1	: std_logic_vector(3 downto 0);
	signal m0			: std_logic_vector(3 downto 0);
	signal m1			: std_logic_vector(3 downto 0);
	signal m2			: std_logic_vector(3 downto 0);
	signal m3			: std_logic_vector(3 downto 0);
	signal m4			: std_logic_vector(3 downto 0);
	signal m5			: std_logic_vector(6 downto 0);
	signal m6 			: std_logic_vector(6 downto 0);
	signal control 	: std_logic_vector(1 downto 0);
begin
	filas_1 <= not(filas(3)) & not(filas(2)) & not(filas(1)) & not(filas(0));
	en_1 <= '1';
	columnas <= not(columna_1(3)) & not(columna_1(2)) & not(columna_1(1)) & not(columna_1(0)); 
	m6 <= "0101011";
	control <= std_logic_vector(unsigned(col_bin) + 2);
	
	U0: divisor5millones port map (reset => reset_n, clk => clock_50, d => en_df);
	U1: synchronizer port map (reset => reset_n, clk => clock_50, en => en_df, d => filas_1, q => filas_sync);
	U2: codificador port map (w => filas_sync, z => z_n, y => fila_bin);
	U3: contador4 port map (reset => reset_n, clk => clock_50, en => en_df, q => col_bin);
	U4: decodificador port map (w => col_bin, en => en_1, y => columna_1);
	U5: mux4a1 port map (sel => fila_bin, a => x"d", b => x"C", c => x"b", d => x"A", f => m0);
	U6: mux4a1 port map (sel => fila_bin, a => x"F", b => x"9", c => x"6", d => x"3", f => m1);
	U7: mux4a1 port map (sel => fila_bin, a => x"0", b => x"8", c => x"5", d => x"2", f => m2);
	U8: mux4a1 port map (sel => fila_bin, a => x"E", b => x"7", c => x"4", d => x"1", f => m3);
	U9: mux4a1 port map (sel => control, a => m0, b => m1, c => m2, d => m3, f => m4);
	U10: hexa_0 port map (a => m4, f => m5);
	U11: mux2_1 port map (sel => z_n, a => m5, b => m6, f =>display);

	z_n1 <= z_n;
	in_hexa <= m4;
end structural;