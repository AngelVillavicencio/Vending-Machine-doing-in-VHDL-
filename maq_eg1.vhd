library ieee;
use ieee.std_logic_1164.all;
use work.my_componentsdelmaq_eg1.all;
use ieee.numeric_std.all;

entity maq_eg1 is
	port (signal clock_50, reset_n: in std_logic;
			signal filas		:  in std_logic_vector(3 downto 0);
			signal D_dec		:  out std_logic_vector(6 downto 0);
			signal D_uni		:  out std_logic_vector(6 downto 0);
			signal D_uni_p		:  out std_logic;
			signal D_dec_cent	:  out std_logic_vector(6 downto 0);
			signal D_uni_cent	:  out std_logic_vector(6 downto 0);
			signal display	   : out std_logic_vector(6 downto 0);
			
			signal display_valu     : out std_logic_vector(6 downto 0);

			signal columnas: out std_logic_vector(3 downto 0);
			
			
			signal VGA_R   : out std_logic_vector(3 downto 0);
			signal VGA_G   : out std_logic_vector(3 downto 0);
			signal VGA_B   : out std_logic_vector(3 downto 0);
			signal VGA_HS  : out std_logic;
			signal VGA_vS  : out std_logic;
			signal DIS_VUELTO:in  std_logic);
end maq_eg1;


architecture structural of maq_eg1 is

	
	signal z_out:  std_logic;
	signal in_hexa:  std_logic_vector(3 downto 0);
	
	
	signal qP			:  std_logic_vector(3 downto 0);
	signal qA			:  std_logic_vector(3 downto 0);
	signal qc			:  std_logic_vector(3 downto 0);
	signal entreg		:  std_logic;
	signal tipo_produc:  std_logic_vector(3 downto 0);
	
	signal decena_vga_saldo       :  std_logic_vector(3 downto 0);
	signal unidad_vga_saldo       :  std_logic_vector(3 downto 0);	
	signal decimal_vga_saldo      :  std_logic_vector(3 downto 0);
	signal decena_vga_vuelto      :  std_logic_vector(3 downto 0);
	signal unidad_vga_vuelto      :  std_logic_vector(3 downto 0);
	signal decimal_vga_vuelto     :  std_logic_vector(3 downto 0);
begin

	teclado1: teclado port map( filas => filas, reset_n => reset_n, clock_50 => clock_50, display => display, columnas => columnas, z_n1 => z_out,  in_hexa => in_hexa);																																																																																																																														
	input_e: input_eval port map(display_valu=>display_valu,reset_n => reset_n, valido => z_out, clock_50 => clock_50, valor => in_hexa, D_dec => D_dec, D_uni => D_uni, D_uni_p => D_uni_p, D_dec_cent => D_dec_cent, D_uni_cent => D_uni_cent, qA => qA, qP => qP, qC => qC,producto=>tipo_produc, entreg => entreg,decena_vga_saldo=>decena_vga_saldo, unidad_vga_saldo =>unidad_vga_saldo,decimal_vga_saldo=>decimal_vga_saldo,decena_vga_vuelto=>decena_vga_vuelto,unidad_vga_vuelto=>unidad_vga_vuelto,decimal_vga_vuelto=>decimal_vga_vuelto );
	vga_maqui : VGA_MAQUINA port map(clock_50=>clock_50,reset_n =>reset_n, entrega =>entreg,DIS_VUELTO=> DIS_VUELTO,decena_vga_saldo =>decena_vga_saldo,unidad_vga_saldo=>unidad_vga_saldo,decimal_vga_saldo=>decimal_vga_saldo,decena_vga_vuelto=>decena_vga_vuelto,unidad_vga_vuelto=>unidad_vga_vuelto,decimal_vga_vuelto=>decimal_vga_vuelto, qA=>qA,qP=>qP,qc=>qc, VGA_R=>VGA_R , VGA_G=>VGA_G, VGA_B=>VGA_B,VGA_HS=>VGA_HS,  VGA_vS=>VGA_vS,producto=>tipo_produc);
	
	
end structural;