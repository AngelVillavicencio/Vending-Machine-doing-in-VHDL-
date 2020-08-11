library ieee;
use ieee.std_logic_1164.all;

package my_componentsdelmaq_eg1 is
component teclado is 
	port(	signal reset_n	: in std_logic;
			signal clock_50: in std_logic;
			signal filas	: in std_logic_vector(3 downto 0);
			signal display	: out std_logic_vector(6 downto 0);
			signal columnas: out std_logic_vector(3 downto 0);
			signal z_n1		: out std_logic;
			signal in_hexa : out std_logic_vector(3 downto 0));
end component;


component input_eval is
	port(	signal reset_n			   : in std_logic;
			signal valido			   : in std_logic;
			signal clock_50		   : in std_logic;
			signal valor			   : in std_logic_vector(3 downto 0);
			
			signal D_dec			   : out std_logic_vector(6 downto 0);
			signal D_uni			   : out std_logic_vector(6 downto 0);
			signal D_uni_p			   : out std_logic;
			signal D_dec_cent		   : out std_logic_vector(6 downto 0);
			signal D_uni_cent		   : out std_logic_vector(6 downto 0);
			
			signal display_valu     : out std_logic_vector(6 downto 0);
			
			
			signal qA				   : out std_logic_vector(3 downto 0);
			signal qP			   	: out std_logic_vector(3 downto 0);
			signal qc				   : out std_logic_vector(3 downto 0);
			signal producto		   : out std_logic_vector(3 downto 0);
			signal entreg			   : out std_logic;
			signal decena_vga_saldo : out std_logic_vector(3 downto 0);
	      signal unidad_vga_saldo : out std_logic_vector(3 downto 0);	
	      signal decimal_vga_saldo: out std_logic_vector(3 downto 0);
			signal decena_vga_vuelto      : out  std_logic_vector(3 downto 0);
		   signal unidad_vga_vuelto      : out  std_logic_vector(3 downto 0);
		   signal decimal_vga_vuelto     : out  std_logic_vector(3 downto 0));
end component;


component VGA_MAQUINA is 
	port(	
		signal clock_50: 	in  std_logic;
		signal reset_n : 	in  std_logic;
    	signal entrega : 	in  std_logic;
		signal DIS_VUELTO:in  std_logic;
		
		----SALDO----------
		signal decena_vga_saldo      : in  std_logic_vector(3 downto 0);
		signal unidad_vga_saldo      : in  std_logic_vector(3 downto 0);
		signal decimal_vga_saldo     : in  std_logic_vector(3 downto 0);
		---------
		----VUELTO-----
		signal decena_vga_vuelto      : in  std_logic_vector(3 downto 0);
		signal unidad_vga_vuelto      : in  std_logic_vector(3 downto 0);
		signal decimal_vga_vuelto     : in  std_logic_vector(3 downto 0);
		--------------------
		----CANTIDAD DE PRODUCTOS---
		signal qA		: 	in  std_logic_vector(3 downto 0);
		signal qP		: 	in  std_logic_vector(3 downto 0);
		signal qc		: 	in  std_logic_vector(3 downto 0);
		-------------
		---PRODUCTO SELECCIONADO----
		signal producto:  in  std_logic_vector(3 downto 0);
		--------------
		signal VGA_R   : 	out std_logic_vector(3 downto 0);
		signal VGA_G   : 	out std_logic_vector(3 downto 0);
		signal VGA_B   : 	out std_logic_vector(3 downto 0);
		signal VGA_HS  : 	out std_logic;
		signal VGA_vS  : 	out std_logic);	
		
end component;


end package;