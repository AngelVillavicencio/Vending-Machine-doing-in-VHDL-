library ieee;
use ieee.std_logic_1164.all;
use work.my_circuit.all;
use ieee.numeric_std.all;

entity VGA_MAQUINA is 
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
		
end VGA_MAQUINA;

architecture circuit of VGA_MAQUINA is 

signal VGA_blank : std_logic;
signal count_v   : std_logic_vector(9 downto 0);
signal count_h   : std_logic_vector(9 downto 0);
constant verde     : std_logic_vector(11 downto 0):="000011110000";
constant azul      : std_logic_vector(11 downto 0):="000000001111";
constant rojo      : std_logic_vector(11 downto 0):="111100000000";
constant gris      : std_logic_vector(11 downto 0):="011101110111";
constant amarillo  : std_logic_vector(11 downto 0):="111111110000";
constant blanco    : std_logic_vector(11 downto 0):="111111111111";
constant negro     : std_logic_vector(11 downto 0):="000000000000";
constant cian      : std_logic_vector(11 downto 0):="000011111111";

constant verde_0     : std_logic_vector(2 downto 0):="000";
constant azul_0     : std_logic_vector(2 downto 0):="001";
constant rojo_0     : std_logic_vector(2 downto 0):="010";
constant gris_0     : std_logic_vector(2 downto 0):="011";
constant amarillo_0 : std_logic_vector(2 downto 0):="100";
constant blanco_0  : std_logic_vector(2 downto 0):="101";
constant negro_0    : std_logic_vector(2 downto 0):="111";
constant cian_0     : std_logic_vector(2 downto 0) :="110";

constant num : natural := 50; --------DESFACE DE PRECIO DE PRODUCTO(COLUMNAS)------
constant num2 : natural := 210; --------DESFACE DE NUMEROS CANTIDAD(COLUMNAS)------

constant num3 : natural := 244;  --------DESFACE DEL NUMERO DE LA unidad DE LA CAJA SALDO(COLUMNAS)------
constant num4 : natural := 283;  --------DESFACE DEL NUMERO DE LA unidad DE LA CAJA SALDO(FILAS)------

constant num5 : natural := 50;     --------DESFACE DEL NUMERO DE LA DERECHA DE LA CAJA SALDO tomando como referencia el numero de la izquierda(COLUMNAS)------

constant num8 : natural := 350   ; -----------DESFACE DE NUMEROS DE VUELTO(DECENA DE VUELTO) con respecto a los numeros de saldo --------------
constant num6 : natural := 400   ; -----------DESFACE DE NUMEROS DE VUELTO con respecto a los numeros de saldo --------------

constant num7 : natural := 294   ; -----------DESFACE de saldo para la decena del saldo --------------

signal color     : std_logic_vector(2 downto 0);
signal salida_color_1: std_logic_vector(11 downto 0);
signal salida_color_2 : std_logic_vector(11 downto 0);
signal contador_vertical   : unsigned(9 downto 0);
signal contador_horizontal   : unsigned(9 downto 0);
signal cont_verti   : unsigned(9 downto 0);
signal cont_horiz   : unsigned(9 downto 0);

begin 
A1: vga_sync port map( reset_n => reset_n,clock_50 => clock_50, VGA_HS => VGA_HS, VGA_VS => VGA_vS, VGA_blank => VGA_blank,count_v=> count_v, count_h => count_h );
cont_verti   <= unsigned(count_h);
cont_horiz <= unsigned(count_v);
 

A2: process(decena_vga_saldo,unidad_vga_saldo,decimal_vga_saldo,decena_vga_vuelto,unidad_vga_vuelto,decimal_vga_vuelto ,cont_verti,cont_horiz,entrega,qC,qP,qA,producto,DIS_VUELTO)
	begin 

	----BORDE DE LA MAQUINA ----  
	
	if (((cont_verti >= 211) and (cont_verti <= 475 ) and (cont_horiz >= 128 ) and (cont_horiz <= 132)) or 
			 ((cont_verti >= 211) and (cont_verti <= 215 ) and (cont_horiz >= 133 ) and (cont_horiz <= 297)) or 
			 ((cont_verti >= 211) and (cont_verti <= 475 ) and (cont_horiz >= 348 ) and (cont_horiz <= 352)) or
			 ((cont_verti >= 470) and (cont_verti <= 475 ) and (cont_horiz >= 133 ) and (cont_horiz <= 347)) or
			 ((cont_verti >= 216) and (cont_verti <= 470 ) and (cont_horiz >= 183 ) and (cont_horiz <= 187)) or
			 ((cont_verti >= 216) and (cont_verti <= 470 ) and (cont_horiz >= 238 ) and (cont_horiz <= 242)) or
			 ((cont_verti >= 216) and (cont_verti <= 470 ) and (cont_horiz >= 293 ) and (cont_horiz <= 297)) or
       	 ((cont_verti >= 366) and (cont_verti <= 370 ) and (cont_horiz >= 133 ) and (cont_horiz <= 292)) or 			 
			 ----borde de PRECIO EXACTO----
			 ((DIS_VUELTO ='1')and(cont_verti >= 445) and (cont_verti <= 626 ) and (cont_horiz >= 12 ) and (cont_horiz <= 15)) or 
			 ((DIS_VUELTO ='1')and(cont_verti >= 445) and (cont_verti <= 626 ) and (cont_horiz >= 110 ) and (cont_horiz <= 114)) or 
			 ((DIS_VUELTO ='1')and(cont_verti >= 626) and (cont_verti <= 629 ) and (cont_horiz >= 15 ) and (cont_horiz <= 110)) or
			 ((DIS_VUELTO ='1')and(cont_verti >= 442) and (cont_verti <= 445 ) and (cont_horiz >= 15 ) and (cont_horiz <= 110)) or 
			 ----borde de cantidad de producto---
			 ((cont_verti >= 158) and (cont_verti <= 211 ) and (cont_horiz >= 128 ) and (cont_horiz <= 132)) or 
			 ((cont_verti >= 158) and (cont_verti <= 162 ) and (cont_horiz >= 133 ) and (cont_horiz <= 347)) or 
			 ((cont_verti >= 162) and (cont_verti <= 211 ) and (cont_horiz >= 183 ) and (cont_horiz <= 187)) or
			 ((cont_verti >= 162) and (cont_verti <= 211 ) and (cont_horiz >= 238 ) and (cont_horiz <= 242)) or
			 ((cont_verti >= 162) and (cont_verti <= 211 ) and (cont_horiz >= 293 ) and (cont_horiz <= 297)) or
       	 ((cont_verti >= 158) and (cont_verti <= 211 ) and (cont_horiz >= 347 ) and (cont_horiz <= 352)) or 
			----BORDE DEL SALDO--------
			 ((cont_verti >= 45) and (cont_verti <= 226 ) and (cont_horiz >= 360 ) and (cont_horiz <= 363)) or 
			 ((cont_verti >= 42) and (cont_verti <= 45 ) and (cont_horiz >= 363 ) and (cont_horiz <= 466)) or 
			 ((cont_verti >= 45) and (cont_verti <= 226 ) and (cont_horiz >= 466 ) and (cont_horiz <= 470)) or
			 ((cont_verti >= 226) and (cont_verti <= 229 ) and (cont_horiz >= 363 ) and (cont_horiz <= 466)) or
			 ((cont_verti >= 45 ) and (cont_verti <= 226 ) and (cont_horiz >= 409 ) and (cont_horiz <=414 )) or
			 ((cont_verti >= 73 ) and (cont_verti <= 78 ) and (cont_horiz >= 409 ) and (cont_horiz <=470 )) or
			 ------BORDE DE VUELTO 
			 ((cont_verti >= 45+400) and (cont_verti <= 226+400 ) and (cont_horiz >= 360 ) and (cont_horiz <= 363)) or 
			 ((cont_verti >= 42+400) and (cont_verti <= 45 +400) and (cont_horiz >= 363 ) and (cont_horiz <= 466)) or 
			 ((cont_verti >= 45+400) and (cont_verti <= 226+400 ) and (cont_horiz >= 466 ) and (cont_horiz <= 470)) or
			 ((cont_verti >= 226+400) and (cont_verti <= 229+400 ) and (cont_horiz >= 363 ) and (cont_horiz <= 466)) or
			 ((cont_verti >= 45 +400) and (cont_verti <= 226+400 ) and (cont_horiz >= 409 ) and (cont_horiz <=414 )) or
			 ((cont_verti >= 472) and (cont_verti <= 476) and (cont_horiz >= 409 ) and (cont_horiz <=470 ))or
			 
			
-----------------------SALDO---------------------------
			---s---
			((cont_verti >= 55) and (cont_verti <= 80 ) and (cont_horiz >= 366 ) and (cont_horiz <= 371))or
			((cont_verti >= 55) and (cont_verti <= 60 ) and (cont_horiz >= 371 ) and (cont_horiz <= 388))or 
			((cont_verti >= 60) and (cont_verti <= 80 ) and (cont_horiz >= 384 ) and (cont_horiz <= 388))or 
			((cont_verti >= 75) and (cont_verti <= 80 ) and (cont_horiz >= 388 ) and (cont_horiz <= 406))or
			((cont_verti >= 55) and (cont_verti <= 75 ) and (cont_horiz >= 402 ) and (cont_horiz <= 406))or
			---A---
			((cont_verti >=85 ) and (cont_verti <= 90 ) and (cont_horiz >=366  ) and (cont_horiz <=406 ))or
			((cont_verti >= 90) and (cont_verti <= 105 ) and (cont_horiz >=366  ) and (cont_horiz <= 371))or 
			((cont_verti >=90 ) and (cont_verti <= 105 ) and (cont_horiz >= 384 ) and (cont_horiz <=388 ))or 
			((cont_verti >= 105) and (cont_verti <= 110 ) and (cont_horiz >=366  ) and (cont_horiz <=406 ))or
			---L---
			((cont_verti >=115 ) and (cont_verti <=120  ) and (cont_horiz >= 366 ) and (cont_horiz <=406 ))or 
			((cont_verti >= 120) and (cont_verti <=140  ) and (cont_horiz >= 402 ) and (cont_horiz <= 406))or
			---D---
			((cont_verti >= 145) and (cont_verti <=150  ) and (cont_horiz >= 366 ) and (cont_horiz <=406 ))or
			((cont_verti >= 150) and (cont_verti <=  165) and (cont_horiz >= 368 ) and (cont_horiz <= 376))or 
			((cont_verti >=150 ) and (cont_verti <= 165 ) and (cont_horiz >= 397 ) and (cont_horiz <=404 ))or 
			((cont_verti >= 165) and (cont_verti <= 170 ) and (cont_horiz >= 376 ) and (cont_horiz <=397 ))or
			---O---
			((cont_verti >=175 ) and (cont_verti <= 180 ) and (cont_horiz >= 366 ) and (cont_horiz <=406 ))or 
			((cont_verti >= 180) and (cont_verti <= 195 ) and (cont_horiz >=366  ) and (cont_horiz <= 371))or 
			((cont_verti >= 180) and (cont_verti <=195  ) and (cont_horiz >= 402 ) and (cont_horiz <= 406))or
			((cont_verti >= 195) and (cont_verti <=200  ) and (cont_horiz >= 366 ) and (cont_horiz <= 406))or

-----------------------FIN SALDO---------------------------				
	
----------------------VUELTO-----------------------

	      ---V---
			((cont_verti >= 450) and (cont_verti <= 455 ) and (cont_horiz >= 368 ) and (cont_horiz <= 390))or
			((cont_verti >= 455) and (cont_verti <= 460 ) and (cont_horiz >= 390 ) and (cont_horiz <= 400))or 
			((cont_verti >= 460) and (cont_verti <= 465 ) and (cont_horiz >= 400 ) and (cont_horiz <= 405))or 
			((cont_verti >= 465) and (cont_verti <= 470 ) and (cont_horiz >= 390 ) and (cont_horiz <= 400))or
			((cont_verti >= 470) and (cont_verti <= 475 ) and (cont_horiz >= 368 ) and (cont_horiz <= 390))or
			---U---
			((cont_verti >=480 ) and (cont_verti <= 485 ) and (cont_horiz >=368  ) and (cont_horiz <=405 ))or
			((cont_verti >= 485) and (cont_verti <= 500 ) and (cont_horiz >=400  ) and (cont_horiz <= 405))or 
			((cont_verti >=500 ) and (cont_verti <= 505 ) and (cont_horiz >= 368 ) and (cont_horiz <=405 ))or 
			---E---
			((cont_verti >=510 ) and (cont_verti <=515  ) and (cont_horiz >= 368 ) and (cont_horiz <=405 ))or 
			((cont_verti >= 515) and (cont_verti <=535  ) and (cont_horiz >= 368 ) and (cont_horiz <= 373))or
			((cont_verti >= 515) and (cont_verti <= 525 ) and (cont_horiz >=384  ) and (cont_horiz <=389 ))or
			((cont_verti >= 515) and (cont_verti <= 535 ) and (cont_horiz >=400  ) and (cont_horiz <=405 ))or
			---L---
			((cont_verti >= 540) and (cont_verti <=545  ) and (cont_horiz >= 368 ) and (cont_horiz <=405 ))or
			((cont_verti >= 545) and (cont_verti <= 565) and (cont_horiz >= 400 ) and (cont_horiz <= 405))or
			---T---
			((cont_verti >=570 ) and (cont_verti <= 595 ) and (cont_horiz >= 368 ) and (cont_horiz <=373 ))or 
			((cont_verti >= 580) and (cont_verti <= 585 ) and (cont_horiz >= 373 ) and (cont_horiz <=405 ))or
			----O---
			((cont_verti >=600 ) and (cont_verti <= 605 ) and (cont_horiz >= 368 ) and (cont_horiz <=405 ))or 
			((cont_verti >= 605) and (cont_verti <= 615 ) and (cont_horiz >=368  ) and (cont_horiz <= 373))or 
			((cont_verti >=615 ) and (cont_verti <=620  ) and (cont_horiz >= 368 ) and (cont_horiz <= 405))or
			((cont_verti >= 605) and (cont_verti <=615  ) and (cont_horiz >= 400 ) and (cont_horiz <= 405))) then


----------------------FIN VUELTO-----------------------			
			color <= negro_0;
			
	else color <= blanco_0;

	end if;
------agua----
		if (((cont_verti >= 216) and (cont_verti <= 217 ) and (cont_horiz >= 133 ) and (cont_horiz <= 182)) or
			 ((cont_verti >= 218) and (cont_verti <= 222 ) and (cont_horiz >= 133 ) and (cont_horiz <= 139)) or
			 ((cont_verti >= 218) and (cont_verti <= 222 ) and (cont_horiz >= 155 ) and (cont_horiz <= 159)) or
			 ((cont_verti >= 218) and (cont_verti <= 222 ) and (cont_horiz >= 175 ) and (cont_horiz <= 182)) or
			 ((cont_verti >= 223) and (cont_verti <= 237 ) and (cont_horiz >= 133 ) and (cont_horiz <= 134)) or
			 ((cont_verti >= 223) and (cont_verti <= 237 ) and (cont_horiz >= 140 ) and (cont_horiz <= 154)) or
			 ((cont_verti >= 223) and (cont_verti <= 237 ) and (cont_horiz >= 160 ) and (cont_horiz <= 182)) or
			 ((cont_verti >= 238) and (cont_verti <= 242 ) and (cont_horiz >= 133 ) and (cont_horiz <= 139)) or
			 ((cont_verti >= 238) and (cont_verti <= 242 ) and (cont_horiz >= 155 ) and (cont_horiz <= 159)) or
			 ((cont_verti >= 238) and (cont_verti <= 242 ) and (cont_horiz >= 175 ) and (cont_horiz <= 182)) or
			 ((cont_verti >= 243) and (cont_verti <= 247 ) and (cont_horiz >= 133 ) and (cont_horiz <= 182)) or
			 ((cont_verti >= 248) and (cont_verti <= 252 ) and (cont_horiz >= 133 ) and (cont_horiz <= 139)) or
			 ((cont_verti >= 248) and (cont_verti <= 252 ) and (cont_horiz >= 155 ) and (cont_horiz <= 159)) or
			 ((cont_verti >= 248) and (cont_verti <= 252 ) and (cont_horiz >= 175 ) and (cont_horiz <= 182)) or
			 ((cont_verti >= 253) and (cont_verti <= 267 ) and (cont_horiz >= 133 ) and (cont_horiz <= 134)) or
			 ((cont_verti >= 253) and (cont_verti <= 267 ) and (cont_horiz >= 140 ) and (cont_horiz <= 154)) or
			 ((cont_verti >= 253) and (cont_verti <= 267 ) and (cont_horiz >= 160 ) and (cont_horiz <= 174)) or
			 ((cont_verti >= 253) and (cont_verti <= 267 ) and (cont_horiz >= 180 ) and (cont_horiz <= 182)) or
			 ((cont_verti >= 268) and (cont_verti <= 272 ) and (cont_horiz >= 133 ) and (cont_horiz <= 159)) or
			 ((cont_verti >= 268) and (cont_verti <= 272 ) and (cont_horiz >= 175 ) and (cont_horiz <= 182)) or
			 ((cont_verti >= 273) and (cont_verti <= 277 ) and (cont_horiz >= 133 ) and (cont_horiz <= 182)) or
			 ((cont_verti >= 278) and (cont_verti <= 282 ) and (cont_horiz >= 133 ) and (cont_horiz <= 139)) or
			 ((cont_verti >= 278) and (cont_verti <= 282 ) and (cont_horiz >= 155 ) and (cont_horiz <= 159)) or
			 ((cont_verti >= 278) and (cont_verti <= 282 ) and (cont_horiz >= 175 ) and (cont_horiz <= 182)) or
			 ((cont_verti >= 283) and (cont_verti <= 297 ) and (cont_horiz >= 133 ) and (cont_horiz <= 174)) or
			 ((cont_verti >= 283) and (cont_verti <= 297 ) and (cont_horiz >= 180 ) and (cont_horiz <= 182)) or
			 ((cont_verti >= 298) and (cont_verti <= 302 ) and (cont_horiz >= 133 ) and (cont_horiz <= 139)) or
			 ((cont_verti >= 298) and (cont_verti <= 302 ) and (cont_horiz >= 155 ) and (cont_horiz <= 159)) or
			 ((cont_verti >= 298) and (cont_verti <= 302 ) and (cont_horiz >= 175 ) and (cont_horiz <= 182)) or
			 ((cont_verti >= 303) and (cont_verti <= 307 ) and (cont_horiz >= 133 ) and (cont_horiz <= 182)) or
			 ((cont_verti >= 308) and (cont_verti <= 312 ) and (cont_horiz >= 133 ) and (cont_horiz <= 139)) or
			 ((cont_verti >= 218) and (cont_verti <= 222 ) and (cont_horiz >= 155 ) and (cont_horiz <= 159)) or
			 ((cont_verti >= 308) and (cont_verti <= 312 ) and (cont_horiz >= 175 ) and (cont_horiz <= 182)) or
			 ((cont_verti >= 313) and (cont_verti <= 327 ) and (cont_horiz >= 133 ) and (cont_horiz <= 134)) or
			 ((cont_verti >= 313) and (cont_verti <= 327 ) and (cont_horiz >= 140 ) and (cont_horiz <= 154)) or 
			 ((cont_verti >= 313) and (cont_verti <= 327 ) and (cont_horiz >= 160 ) and (cont_horiz <= 182)) or
			 ((cont_verti >= 328) and (cont_verti <= 332 ) and (cont_horiz >= 133 ) and (cont_horiz <= 139)) or
			 ((cont_verti >= 328) and (cont_verti <= 332 ) and (cont_horiz >= 155 ) and (cont_horiz <= 159)) or
			 ((cont_verti >= 328) and (cont_verti <= 332 ) and (cont_horiz >= 175 ) and (cont_horiz <= 182)) or
			 ((cont_verti >= 333) and (cont_verti <= 365 ) and (cont_horiz >= 133 ) and (cont_horiz <= 182)))then
				color <= verde_0;
			end if;
------pepsi------
		if (((cont_verti >= 216) and (cont_verti <= 217 ) and (cont_horiz >= 188 ) and (cont_horiz <= 237)) or
			((cont_verti >= 218) and (cont_verti <= 222 ) and (cont_horiz >= 188 ) and (cont_horiz <= 194)) or
			((cont_verti >= 218) and (cont_verti <= 222 ) and (cont_horiz >= 210 ) and (cont_horiz <= 214)) or
			((cont_verti >= 218) and (cont_verti <= 222 ) and (cont_horiz >= 230 ) and (cont_horiz <= 237)) or
			((cont_verti >= 223) and (cont_verti <= 237 ) and (cont_horiz >= 188 ) and (cont_horiz <= 189)) or
			((cont_verti >= 223) and (cont_verti <= 237 ) and (cont_horiz >= 195 ) and (cont_horiz <= 209)) or
			((cont_verti >= 223) and (cont_verti <= 237 ) and (cont_horiz >= 215 ) and (cont_horiz <= 237)) or
			((cont_verti >= 238) and (cont_verti <= 242 ) and (cont_horiz >= 188 ) and (cont_horiz <= 194)) or
			((cont_verti >= 238) and (cont_verti <= 242 ) and (cont_horiz >= 210 ) and (cont_horiz <= 237)) or
			((cont_verti >= 243) and (cont_verti <= 247 ) and (cont_horiz >= 188 ) and (cont_horiz <= 237)) or
			((cont_verti >= 248) and (cont_verti <= 252 ) and (cont_horiz >= 188 ) and (cont_horiz <= 194)) or
			((cont_verti >= 248) and (cont_verti <= 252 ) and (cont_horiz >= 210 ) and (cont_horiz <= 214)) or
			((cont_verti >= 248) and (cont_verti <= 252 ) and (cont_horiz >= 230 ) and (cont_horiz <= 237)) or
			((cont_verti >= 253) and (cont_verti <= 267 ) and (cont_horiz >= 188 ) and (cont_horiz <= 189)) or
			((cont_verti >= 253) and (cont_verti <= 267 ) and (cont_horiz >= 195 ) and (cont_horiz <= 209)) or
			((cont_verti >= 253) and (cont_verti <= 267 ) and (cont_horiz >= 215 ) and (cont_horiz <= 229)) or
			((cont_verti >= 253) and (cont_verti <= 267 ) and (cont_horiz >= 235 ) and (cont_horiz <= 237)) or
			((cont_verti >= 268) and (cont_verti <= 277 ) and (cont_horiz >= 188 ) and (cont_horiz <= 237)) or
			((cont_verti >= 278) and (cont_verti <= 282 ) and (cont_horiz >= 188 ) and (cont_horiz <= 194)) or
			((cont_verti >= 278) and (cont_verti <= 282 ) and (cont_horiz >= 210 ) and (cont_horiz <= 214)) or
			((cont_verti >= 278) and (cont_verti <= 282 ) and (cont_horiz >= 230 ) and (cont_horiz <= 237)) or
			((cont_verti >= 283) and (cont_verti <= 297 ) and (cont_horiz >= 188 ) and (cont_horiz <= 189)) or
			((cont_verti >= 283) and (cont_verti <= 297 ) and (cont_horiz >= 195 ) and (cont_horiz <= 209)) or
			((cont_verti >= 283) and (cont_verti <= 297 ) and (cont_horiz >= 215 ) and (cont_horiz <= 237)) or
			((cont_verti >= 298) and (cont_verti <= 302 ) and (cont_horiz >= 188 ) and (cont_horiz <= 194)) or
			((cont_verti >= 298) and (cont_verti <= 302 ) and (cont_horiz >= 210 ) and (cont_horiz <= 237)) or
			((cont_verti >= 303) and (cont_verti <= 307 ) and (cont_horiz >= 188 ) and (cont_horiz <= 237)) or
			((cont_verti >= 308) and (cont_verti <= 312 ) and (cont_horiz >= 188 ) and (cont_horiz <= 194)) or
			((cont_verti >= 308) and (cont_verti <= 312 ) and (cont_horiz >= 210 ) and (cont_horiz <= 237)) or
			((cont_verti >= 313) and (cont_verti <= 327 ) and (cont_horiz >= 188 ) and (cont_horiz <= 189)) or
			((cont_verti >= 313) and (cont_verti <= 327 ) and (cont_horiz >= 195 ) and (cont_horiz <= 209)) or
			((cont_verti >= 313) and (cont_verti <= 327 ) and (cont_horiz >= 215 ) and (cont_horiz <= 229)) or
			((cont_verti >= 313) and (cont_verti <= 327 ) and (cont_horiz >= 235 ) and (cont_horiz <= 237)) or
			((cont_verti >= 328) and (cont_verti <= 332 ) and (cont_horiz >= 188 ) and (cont_horiz <= 214)) or
			((cont_verti >= 328) and (cont_verti <= 332 ) and (cont_horiz >= 230 ) and (cont_horiz <= 237)) or
			((cont_verti >= 333) and (cont_verti <= 357 ) and (cont_horiz >= 188 ) and (cont_horiz <= 237)) or
			((cont_verti >= 358) and (cont_verti <= 362 ) and (cont_horiz >= 188 ) and (cont_horiz <= 194)) or
			((cont_verti >= 358) and (cont_verti <= 362 ) and (cont_horiz >= 210 ) and (cont_horiz <= 214)) or
			((cont_verti >= 358) and (cont_verti <= 362 ) and (cont_horiz >= 230 ) and (cont_horiz <= 237)) or
			((cont_verti >= 363) and (cont_verti <= 365 ) and (cont_horiz >= 188 ) and (cont_horiz <= 237)))then
				color <= azul_0;
			end if;
-------coke-------
		if (((cont_verti >= 216) and (cont_verti <= 217 ) and (cont_horiz >= 243 ) and (cont_horiz <= 292)) or
			((cont_verti >= 218) and (cont_verti <= 222 ) and (cont_horiz >= 243 ) and (cont_horiz <= 249)) or
			((cont_verti >= 218) and (cont_verti <= 222 ) and (cont_horiz >= 265 ) and (cont_horiz <= 269)) or
			((cont_verti >= 218) and (cont_verti <= 222 ) and (cont_horiz >= 285 ) and (cont_horiz <= 292)) or
			((cont_verti >= 223) and (cont_verti <= 237 ) and (cont_horiz >= 243 ) and (cont_horiz <= 244)) or
			((cont_verti >= 223) and (cont_verti <= 237 ) and (cont_horiz >= 250 ) and (cont_horiz <= 284)) or
			((cont_verti >= 223) and (cont_verti <= 237 ) and (cont_horiz >= 290 ) and (cont_horiz <= 292)) or
			((cont_verti >= 238) and (cont_verti <= 247 ) and (cont_horiz >= 243 ) and (cont_horiz <= 292)) or
			((cont_verti >= 248) and (cont_verti <= 252 ) and (cont_horiz >= 243 ) and (cont_horiz <= 249)) or
			((cont_verti >= 248) and (cont_verti <= 252 ) and (cont_horiz >= 265 ) and (cont_horiz <= 269)) or
			((cont_verti >= 248) and (cont_verti <= 252 ) and (cont_horiz >= 285 ) and (cont_horiz <= 292)) or
			((cont_verti >= 253) and (cont_verti <= 267 ) and (cont_horiz >= 243 ) and (cont_horiz <= 244)) or
			((cont_verti >= 253) and (cont_verti <= 267 ) and (cont_horiz >= 250 ) and (cont_horiz <= 284)) or
			((cont_verti >= 253) and (cont_verti <= 267 ) and (cont_horiz >= 290 ) and (cont_horiz <= 292)) or
			((cont_verti >= 268) and (cont_verti <= 272 ) and (cont_horiz >= 243 ) and (cont_horiz <= 249)) or
			((cont_verti >= 268) and (cont_verti <= 272 ) and (cont_horiz >= 265 ) and (cont_horiz <= 269)) or
			((cont_verti >= 268) and (cont_verti <= 272 ) and (cont_horiz >= 285 ) and (cont_horiz <= 292)) or
			((cont_verti >= 273) and (cont_verti <= 277 ) and (cont_horiz >= 243 ) and (cont_horiz <= 292)) or
			((cont_verti >= 278) and (cont_verti <= 282 ) and (cont_horiz >= 243 ) and (cont_horiz <= 249)) or
			((cont_verti >= 278) and (cont_verti <= 282 ) and (cont_horiz >= 265 ) and (cont_horiz <= 269)) or
			((cont_verti >= 278) and (cont_verti <= 282 ) and (cont_horiz >= 285 ) and (cont_horiz <= 292)) or
			((cont_verti >= 283) and (cont_verti <= 297 ) and (cont_horiz >= 243 ) and (cont_horiz <= 264)) or
			((cont_verti >= 283) and (cont_verti <= 297 ) and (cont_horiz >= 270 ) and (cont_horiz <= 292)) or
			((cont_verti >= 298) and (cont_verti <= 302 ) and (cont_horiz >= 243 ) and (cont_horiz <= 249)) or
			((cont_verti >= 298) and (cont_verti <= 302 ) and (cont_horiz >= 265 ) and (cont_horiz <= 269)) or
			((cont_verti >= 298) and (cont_verti <= 302 ) and (cont_horiz >= 285 ) and (cont_horiz <= 292)) or
			((cont_verti >= 303) and (cont_verti <= 307 ) and (cont_horiz >= 243 ) and (cont_horiz <= 292)) or
			((cont_verti >= 308) and (cont_verti <= 312 ) and (cont_horiz >= 243 ) and (cont_horiz <= 249)) or
			((cont_verti >= 308) and (cont_verti <= 312 ) and (cont_horiz >= 265 ) and (cont_horiz <= 269)) or
			((cont_verti >= 308) and (cont_verti <= 312 ) and (cont_horiz >= 285 ) and (cont_horiz <= 292)) or
			((cont_verti >= 313) and (cont_verti <= 327 ) and (cont_horiz >= 243 ) and (cont_horiz <= 244)) or
			((cont_verti >= 313) and (cont_verti <= 327 ) and (cont_horiz >= 250 ) and (cont_horiz <= 264)) or
			((cont_verti >= 313) and (cont_verti <= 327 ) and (cont_horiz >= 270 ) and (cont_horiz <= 284)) or
			((cont_verti >= 313) and (cont_verti <= 327 ) and (cont_horiz >= 290 ) and (cont_horiz <= 292)) or
			((cont_verti >= 328) and (cont_verti <= 365 ) and (cont_horiz >= 243 ) and (cont_horiz <= 292)))then
				color <=rojo_0;
		end if;
		
---PRECIO EXACTO---

if(DIS_VUELTO='1')then 
         ----P------
		if (((cont_verti >= 455) and (cont_verti <= 460 ) and (cont_horiz >= 20 ) and (cont_horiz <= 50)) or
			((cont_verti >= 460) and (cont_verti <= 475 ) and (cont_horiz >= 20 ) and (cont_horiz <= 25)) or
			((cont_verti >= 460) and (cont_verti <= 475 ) and (cont_horiz >= 35 ) and (cont_horiz <= 40)) or
			((cont_verti >= 475) and (cont_verti <= 480 ) and (cont_horiz >= 20 ) and (cont_horiz <= 40))or 
			---R---
			((cont_verti >= 490) and (cont_verti <= 495 ) and (cont_horiz >= 20 ) and (cont_horiz <= 50))or
			((cont_verti >= 496) and (cont_verti <= 510 ) and (cont_horiz >= 20 ) and (cont_horiz <= 25))or 
			((cont_verti >= 510) and (cont_verti <= 515 ) and (cont_horiz >= 20 ) and (cont_horiz <= 40))or 
			((cont_verti >= 495) and (cont_verti <= 510 ) and (cont_horiz >= 35 ) and (cont_horiz <= 40))or
			((cont_verti >=505 ) and (cont_verti <= 510 ) and (cont_horiz >= 40 ) and (cont_horiz <=50 ))or 
			---e---
			((cont_verti >= 525) and (cont_verti <= 530 ) and (cont_horiz >= 20 ) and (cont_horiz <= 50))or
			((cont_verti >= 530) and (cont_verti <= 545 ) and (cont_horiz >= 20 ) and (cont_horiz <= 25))or 
			((cont_verti >= 530) and (cont_verti <= 540 ) and (cont_horiz >= 35 ) and (cont_horiz <= 40))or 
			((cont_verti >= 530) and (cont_verti <= 545 ) and (cont_horiz >= 45 ) and (cont_horiz <= 50))or
		---c----
	      ((cont_verti >= 555) and (cont_verti <= 560 ) and (cont_horiz >= 20 ) and (cont_horiz <= 50))or
			((cont_verti >= 560) and (cont_verti <= 575 ) and (cont_horiz >= 20 ) and (cont_horiz <= 25))or 
			((cont_verti >= 560) and (cont_verti <= 575 ) and (cont_horiz >= 45 ) and (cont_horiz <= 50))or 
			---i---
			((cont_verti >= 580) and (cont_verti <= 585 ) and (cont_horiz >= 20 ) and (cont_horiz <= 50))or
			----o----	
			 ((cont_verti >= 590) and (cont_verti <= 595 ) and (cont_horiz >= 20 ) and (cont_horiz <= 50))or
			((cont_verti >= 610) and (cont_verti <= 615 ) and (cont_horiz >= 20 ) and (cont_horiz <= 50))or 
			((cont_verti >= 595) and (cont_verti <= 610 ) and (cont_horiz >= 20 ) and (cont_horiz <= 25))or 
			((cont_verti >= 595) and (cont_verti <= 610 ) and (cont_horiz >= 45 ) and (cont_horiz <= 50))or
			
			---exacto---
			---e---
			
			((cont_verti >= 455) and (cont_verti <= 459 ) and (cont_horiz >= 70 ) and (cont_horiz <= 105))or
			((cont_verti >= 459) and (cont_verti <= 471 ) and (cont_horiz >= 70 ) and (cont_horiz <= 75))or 
			((cont_verti >= 459) and (cont_verti <= 465 ) and (cont_horiz >= 85 ) and (cont_horiz <= 90))or 
			((cont_verti >= 459) and (cont_verti <= 471 ) and (cont_horiz >= 100 ) and (cont_horiz <= 105))or
			---x---
			((cont_verti >= 476) and (cont_verti <= 478 ) and (cont_horiz >= 100 ) and (cont_horiz <= 105))or
			((cont_verti >= 478) and (cont_verti <= 480 ) and (cont_horiz >= 90 ) and (cont_horiz <= 100))or 
			((cont_verti >= 480) and (cont_verti <= 483 ) and (cont_horiz >= 85 ) and (cont_horiz <= 90))or 
			((cont_verti >= 483) and (cont_verti <= 486 ) and (cont_horiz >= 85 ) and (cont_horiz <= 90))or
			((cont_verti >= 486) and (cont_verti <= 488 ) and (cont_horiz >= 90 ) and (cont_horiz <= 100))or 
			((cont_verti >= 488) and (cont_verti <= 492 ) and (cont_horiz >= 100 ) and (cont_horiz <= 105))or
			((cont_verti >= 476) and (cont_verti <= 478 ) and (cont_horiz >= 70 ) and (cont_horiz <= 75))or
			((cont_verti >= 478) and (cont_verti <= 480 ) and (cont_horiz >= 75 ) and (cont_horiz <= 80))or 
			((cont_verti >= 480) and (cont_verti <= 483 ) and (cont_horiz >= 80 ) and (cont_horiz <= 85))or 
			((cont_verti >= 483) and (cont_verti <= 486 ) and (cont_horiz >= 80 ) and (cont_horiz <= 85))or
			((cont_verti >= 486) and (cont_verti <= 488 ) and (cont_horiz >= 75 ) and (cont_horiz <= 80))or 
			((cont_verti >= 488) and (cont_verti <= 492 ) and (cont_horiz >= 70 ) and (cont_horiz <= 75))or 
			---a---
			((cont_verti >= 497) and (cont_verti <= 501 ) and (cont_horiz >= 70 ) and (cont_horiz <= 105))or
			((cont_verti >= 512) and (cont_verti <= 516 ) and (cont_horiz >= 70 ) and (cont_horiz <= 105))or
			((cont_verti >= 501) and (cont_verti <= 512 ) and (cont_horiz >= 70 ) and (cont_horiz <= 75))or 
			((cont_verti >= 501) and (cont_verti <= 512 ) and (cont_horiz >= 85 ) and (cont_horiz <= 90))or 
			---c---
			
			((cont_verti >= 521) and (cont_verti <= 526 ) and (cont_horiz >= 70 ) and (cont_horiz <= 105))or
			((cont_verti >= 526) and (cont_verti <= 537 ) and (cont_horiz >= 70 ) and (cont_horiz <= 75))or 
			((cont_verti >= 526) and (cont_verti <= 537 ) and (cont_horiz >= 100 ) and (cont_horiz <= 105))or
			---T---
			((cont_verti >= 541) and (cont_verti <= 554 ) and (cont_horiz >= 70 ) and (cont_horiz <= 75))or
			((cont_verti >= 545) and (cont_verti <= 549 ) and (cont_horiz >= 75 ) and (cont_horiz <= 105))or 
			---O---
			((cont_verti >= 559) and (cont_verti <= 564 ) and (cont_horiz >= 70 ) and (cont_horiz <= 105))or
			((cont_verti >= 576) and (cont_verti <= 580 ) and (cont_horiz >= 70 ) and (cont_horiz <= 105))or
			((cont_verti >= 564) and (cont_verti <= 576 ) and (cont_horiz >= 70 ) and (cont_horiz <= 75))or 
			((cont_verti >= 564) and (cont_verti <= 576 ) and (cont_horiz >= 100 ) and (cont_horiz <= 105)))
			
		then
				color <=rojo_0;
		end if;


end if;
------------------------CANTIDAD DE SALDO --------------------------------

-----numero de decena del saldo -----
if ((decena_vga_saldo = "0000") and (((cont_verti >= 371-num7) and (cont_verti <= 383-num7 ) and (cont_horiz >= 133 +num4) and (cont_horiz <= 182+num4)) or 
						((cont_verti >= 384-num7) and (cont_verti <= 388 -num7) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 139+num4)) or
						((cont_verti >= 384-num7) and (cont_verti <= 388 -num7) and (cont_horiz >= 155 +num4) and (cont_horiz <= 159+num4)) or
						((cont_verti >= 384-num7) and (cont_verti <= 388 -num7) and (cont_horiz >= 175 +num4) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 389-num7) and (cont_verti <= 403- num7 ) and (cont_horiz >= 133 +num4) and (cont_horiz <= 134+num4)) or
						((cont_verti >= 389-num7) and (cont_verti <= 403- num7 ) and (cont_horiz >= 140 +num4) and (cont_horiz <= 174+num4)) or
						((cont_verti >= 389-num7) and (cont_verti <= 403- num7 ) and (cont_horiz >= 180 +num4) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 404-num7) and (cont_verti <= 408- num7 ) and (cont_horiz >= 133 +num4) and (cont_horiz <= 139+num4)) or
						((cont_verti >= 404-num7) and (cont_verti <= 408 -num7) and (cont_horiz >= 155+num4 ) and (cont_horiz <= 159+num4)) or
						((cont_verti >= 404-num7) and (cont_verti <= 408 -num7) and (cont_horiz >= 175 +num4) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 409-num7) and (cont_verti <= 420 -num7 ) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 182+num4))))then
						color <= cian_0;
						end if;
if((decena_vga_saldo = "0001") and (((cont_verti >= 371-num7) and (cont_verti <= 403-num7 ) and (cont_horiz >= 133 +num4) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 404-num7) and (cont_verti <= 408 -num7) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 139+num4)) or
						((cont_verti >= 404-num7) and (cont_verti <= 408-num7 ) and (cont_horiz >= 155+num4 ) and (cont_horiz <= 159+num4)) or
						((cont_verti >= 404-num7) and (cont_verti <= 408-num7 ) and (cont_horiz >= 175+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 409-num7) and (cont_verti <= 420 -num7) and (cont_horiz >= 133 +num4) and (cont_horiz <= 182+num4))))then
						color <= cian_0;
						end if;
if((decena_vga_saldo = "0010") and (((cont_verti >= 371-num7) and (cont_verti <= 383 -num7) and (cont_horiz >= 133 +num4) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 384-num7) and (cont_verti <= 388 -num7) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 159+num4)) or
						((cont_verti >= 384-num7) and (cont_verti <= 388 -num7) and (cont_horiz >= 175+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 389-num7) and (cont_verti <= 403-num7 ) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 134+num4)) or
						((cont_verti >= 389-num7) and (cont_verti <= 403 -num7) and (cont_horiz >= 140+num4 ) and (cont_horiz <= 154+num4)) or
						((cont_verti >= 389-num7) and (cont_verti <= 403-num7 ) and (cont_horiz >= 160+num4 ) and (cont_horiz <= 174+num4)) or
						((cont_verti >= 389-num7) and (cont_verti <= 403-num7 ) and (cont_horiz >= 180+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 404-num7) and (cont_verti <= 408-num7 ) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 139+num4)) or
						((cont_verti >= 404-num7) and (cont_verti <= 408-num7 ) and (cont_horiz >= 155+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 409-num7) and (cont_verti <= 420-num7 ) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 182+num4))))then
						color <= cian_0;
						end if;
if((decena_vga_saldo = "0011") and (((cont_verti >= 371-num7) and (cont_verti <= 388-num7 ) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 389-num7) and (cont_verti <= 403-num7 ) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 134+num4)) or
						((cont_verti >= 389-num7) and (cont_verti <= 403-num7 ) and (cont_horiz >= 140+num4 ) and (cont_horiz <= 154+num4)) or
						((cont_verti >= 389-num7) and (cont_verti <= 403-num7 ) and (cont_horiz >= 160+num4 ) and (cont_horiz <= 174+num4)) or
						((cont_verti >= 389-num7) and (cont_verti <= 403-num7 ) and (cont_horiz >= 180+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 404-num7) and (cont_verti <= 408-num7 ) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 139+num4)) or
						((cont_verti >= 404-num7) and (cont_verti <= 408-num7 ) and (cont_horiz >= 155 +num4) and (cont_horiz <= 159+num4)) or
						((cont_verti >= 404-num7) and (cont_verti <= 408-num7 ) and (cont_horiz >= 175 +num4) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 409-num7) and (cont_verti <= 420-num7 ) and (cont_horiz >= 133 +num4) and (cont_horiz <= 182+num4))))then
						color <= cian_0;
						end if;
if((decena_vga_saldo = "0100") and (((cont_verti >= 371-num7) and (cont_verti <= 383-num7 ) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 384-num7) and (cont_verti <= 388-num7 ) and (cont_horiz >= 133 +num4) and (cont_horiz <= 139+num4)) or
						((cont_verti >= 384-num7) and (cont_verti <= 388-num7 ) and (cont_horiz >= 155+num4 ) and (cont_horiz <= 159+num4)) or
						((cont_verti >= 384-num7) and (cont_verti <= 388-num7 ) and (cont_horiz >= 175+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 389-num7) and (cont_verti <= 403-num7 ) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 154+num4)) or
						((cont_verti >= 389-num7) and (cont_verti <= 403-num7 ) and (cont_horiz >= 160+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 404-num7) and (cont_verti <= 408-num7 ) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 139+num4)) or
						((cont_verti >= 404-num7) and (cont_verti <= 408-num7 ) and (cont_horiz >= 155+num4 ) and (cont_horiz <= 159+num4)) or
						((cont_verti >= 404-num7) and (cont_verti <= 408-num7 ) and (cont_horiz >= 175+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 409-num7) and (cont_verti <= 420-num7 ) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 384-num7) and (cont_verti <= 388-num7 ) and (cont_horiz >= 160+num4 ) and (cont_horiz <= 182+num4))))then
						color <= cian_0;
						end if;
if((decena_vga_saldo = "0101") and (((cont_verti >= 371-num7) and (cont_verti <= 383-num7 ) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 384-num7) and (cont_verti <= 388 -num7) and (cont_horiz >= 133 +num4) and (cont_horiz <= 139+num4)) or
						((cont_verti >= 384-num7) and (cont_verti <= 388-num7 ) and (cont_horiz >= 155+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 389-num7) and (cont_verti <= 403-num7 ) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 134+num4)) or
						((cont_verti >= 389-num7) and (cont_verti <= 403-num7 ) and (cont_horiz >= 140+num4 ) and (cont_horiz <= 154+num4)) or
						((cont_verti >= 389-num7) and (cont_verti <= 403-num7 ) and (cont_horiz >= 160+num4 ) and (cont_horiz <= 174+num4)) or
						((cont_verti >= 389-num7) and (cont_verti <= 403-num7 ) and (cont_horiz >= 180+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 404-num7) and (cont_verti <= 408-num7 ) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 159+num4)) or
						((cont_verti >= 404-num7) and (cont_verti <= 408-num7 ) and (cont_horiz >= 175+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 409-num7) and (cont_verti <= 420-num7 ) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 182+num4))))then
						color <= cian_0;
						end if;
if((decena_vga_saldo = "0110") and (((cont_verti >= 371-num7) and (cont_verti <= 383-num7) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 384-num7) and (cont_verti <= 388-num7 ) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 139+num4)) or
						((cont_verti >= 384-num7) and (cont_verti <= 388-num7 ) and (cont_horiz >= 155 +num4) and (cont_horiz <= 159+num4)) or
						((cont_verti >= 384-num7) and (cont_verti <= 388-num7 ) and (cont_horiz >= 175+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 389-num7) and (cont_verti <= 403-num7 ) and (cont_horiz >= 133 +num4) and (cont_horiz <= 134+num4)) or
						((cont_verti >= 389-num7) and (cont_verti <= 403-num7 ) and (cont_horiz >= 140+num4 ) and (cont_horiz <= 154+num4)) or
						((cont_verti >= 389-num7) and (cont_verti <= 403-num7 ) and (cont_horiz >= 160+num4 ) and (cont_horiz <= 174+num4)) or
						((cont_verti >= 389-num7) and (cont_verti <= 403-num7 ) and (cont_horiz >= 180+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 404-num7) and (cont_verti <= 408-num7 ) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 159+num4)) or
						((cont_verti >= 404-num7) and (cont_verti <= 408-num7 ) and (cont_horiz >= 175+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 409-num7) and (cont_verti <= 420-num7 ) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 182+num4))))then
						color <= cian_0;
						end if;
if((decena_vga_saldo = "0111") and (((cont_verti >= 371-num7) and (cont_verti <= 388-num7 ) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 389-num7) and (cont_verti <= 403-num7 ) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 134+num4)) or
						((cont_verti >= 389-num7) and (cont_verti <= 403-num7 ) and (cont_horiz >= 140+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 404-num7) and (cont_verti <= 408-num7 ) and (cont_horiz >= 133 +num4) and (cont_horiz <= 139+num4)) or
						((cont_verti >= 404-num7) and (cont_verti <= 408-num7 ) and (cont_horiz >= 155 +num4) and (cont_horiz <= 159+num4)) or
						((cont_verti >= 404-num7) and (cont_verti <= 408-num7 ) and (cont_horiz >= 175+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 409-num7) and (cont_verti <= 420-num7 ) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 182+num4))))then
						color <= cian_0;
						end if;
if((decena_vga_saldo = "1000") and (((cont_verti >= 371-num7) and (cont_verti <= 383-num7 ) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 384-num7) and (cont_verti <= 388-num7) and (cont_horiz >= 133 +num4) and (cont_horiz <= 139+num4)) or
						((cont_verti >= 384-num7) and (cont_verti <= 388-num7 ) and (cont_horiz >= 155+num4 ) and (cont_horiz <= 159+num4)) or
						((cont_verti >= 384-num7) and (cont_verti <= 388-num7 ) and (cont_horiz >= 175+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 389-num7) and (cont_verti <= 403-num7) and (cont_horiz >= 133 +num4) and (cont_horiz <= 134+num4)) or
						((cont_verti >= 389-num7) and (cont_verti <= 403-num7 ) and (cont_horiz >= 140 +num4) and (cont_horiz <= 154+num4)) or
						((cont_verti >= 389-num7) and (cont_verti <= 403-num7 ) and (cont_horiz >= 160+num4 ) and (cont_horiz <= 174+num4)) or
						((cont_verti >= 389-num7) and (cont_verti <= 403-num7 ) and (cont_horiz >= 180+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 404-num7) and (cont_verti <= 408-num7 ) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 139+num4)) or
						((cont_verti >= 404-num7) and (cont_verti <= 408-num7 ) and (cont_horiz >= 155+num4 ) and (cont_horiz <= 159+num4)) or
						((cont_verti >= 404-num7) and (cont_verti <= 408-num7 ) and (cont_horiz >= 175+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 409-num7) and (cont_verti <= 420-num7 ) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 182+num4))))then
						color <= cian_0;
						end if;
if((decena_vga_saldo = "1001") and (((cont_verti >= 371-num7) and (cont_verti <= 383-num7 ) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 384-num7) and (cont_verti <= 388-num7) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 139+num4)) or
						((cont_verti >= 384-num7) and (cont_verti <= 388-num7 ) and (cont_horiz >= 155+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 389-num7) and (cont_verti <= 403-num7 ) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 134+num4)) or
						((cont_verti >= 389-num7) and (cont_verti <= 403-num7 ) and (cont_horiz >= 140+num4 ) and (cont_horiz <= 154+num4)) or
						((cont_verti >= 389-num7) and (cont_verti <= 403-num7) and (cont_horiz >= 160+num4 ) and (cont_horiz <= 174+num4)) or
						((cont_verti >= 389-num7) and (cont_verti <= 403-num7) and (cont_horiz >= 180+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 404-num7) and (cont_verti <= 408-num7) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 139+num4)) or
						((cont_verti >= 404-num7) and (cont_verti <= 408-num7) and (cont_horiz >= 155+num4 ) and (cont_horiz <= 159+num4)) or
						((cont_verti >= 404-num7) and (cont_verti <= 408-num7) and (cont_horiz >= 175+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 409-num7) and (cont_verti <= 420-num7 ) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 182+num4))))then
						color <= cian_0;
						end if;

-----numero de decena del saldo------

----------------NUMERO DE LA unidad--------------------
if ((unidad_vga_saldo = "0000") and (((cont_verti >= 371-num3) and (cont_verti <= 383-num3 ) and (cont_horiz >= 133 +num4) and (cont_horiz <= 182+num4)) or 
						((cont_verti >= 384-num3) and (cont_verti <= 388 -num3) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 139+num4)) or
						((cont_verti >= 384-num3) and (cont_verti <= 388 -num3) and (cont_horiz >= 155 +num4) and (cont_horiz <= 159+num4)) or
						((cont_verti >= 384-num3) and (cont_verti <= 388 -num3) and (cont_horiz >= 175 +num4) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 389-num3) and (cont_verti <= 403-num3 ) and (cont_horiz >= 133 +num4) and (cont_horiz <= 134+num4)) or
						((cont_verti >= 389-num3) and (cont_verti <= 403-num3 ) and (cont_horiz >= 140 +num4) and (cont_horiz <= 174+num4)) or
						((cont_verti >= 389-num3) and (cont_verti <= 403-num3 ) and (cont_horiz >= 180 +num4) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 404-num3) and (cont_verti <= 408-num3 ) and (cont_horiz >= 133 +num4) and (cont_horiz <= 139+num4)) or
						((cont_verti >= 404-num3) and (cont_verti <= 408 -num3) and (cont_horiz >= 155+num4 ) and (cont_horiz <= 159+num4)) or
						((cont_verti >= 404-num3) and (cont_verti <= 408 -num3) and (cont_horiz >= 175 +num4) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 409-num3) and (cont_verti <= 420-num3 ) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 182+num4))))then
						color <= cian_0;
						end if;
if((unidad_vga_saldo = "0001") and (((cont_verti >= 371-num3) and (cont_verti <= 403-num3 ) and (cont_horiz >= 133 +num4) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 404-num3) and (cont_verti <= 408 -num3) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 139+num4)) or
						((cont_verti >= 404-num3) and (cont_verti <= 408-num3 ) and (cont_horiz >= 155+num4 ) and (cont_horiz <= 159+num4)) or
						((cont_verti >= 404-num3) and (cont_verti <= 408-num3 ) and (cont_horiz >= 175+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 409-num3) and (cont_verti <= 420 -num3) and (cont_horiz >= 133 +num4) and (cont_horiz <= 182+num4))))then
						color <= cian_0;
						end if;
if((unidad_vga_saldo = "0010") and (((cont_verti >= 371-num3) and (cont_verti <= 383 -num3) and (cont_horiz >= 133 +num4) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 384-num3) and (cont_verti <= 388 -num3) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 159+num4)) or
						((cont_verti >= 384-num3) and (cont_verti <= 388 -num3) and (cont_horiz >= 175+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 389-num3) and (cont_verti <= 403-num3 ) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 134+num4)) or
						((cont_verti >= 389-num3) and (cont_verti <= 403 -num3) and (cont_horiz >= 140+num4 ) and (cont_horiz <= 154+num4)) or
						((cont_verti >= 389-num3) and (cont_verti <= 403-num3 ) and (cont_horiz >= 160+num4 ) and (cont_horiz <= 174+num4)) or
						((cont_verti >= 389-num3) and (cont_verti <= 403-num3 ) and (cont_horiz >= 180+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 404-num3) and (cont_verti <= 408-num3 ) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 139+num4)) or
						((cont_verti >= 404-num3) and (cont_verti <= 408-num3 ) and (cont_horiz >= 155+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 409-num3) and (cont_verti <= 420-num3 ) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 182+num4))))then
						color <= cian_0;
						end if;
if((unidad_vga_saldo = "0011") and (((cont_verti >= 371-num3) and (cont_verti <= 388-num3 ) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 389-num3) and (cont_verti <= 403-num3 ) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 134+num4)) or
						((cont_verti >= 389-num3) and (cont_verti <= 403-num3 ) and (cont_horiz >= 140+num4 ) and (cont_horiz <= 154+num4)) or
						((cont_verti >= 389-num3) and (cont_verti <= 403-num3 ) and (cont_horiz >= 160+num4 ) and (cont_horiz <= 174+num4)) or
						((cont_verti >= 389-num3) and (cont_verti <= 403-num3 ) and (cont_horiz >= 180+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 404-num3) and (cont_verti <= 408-num3 ) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 139+num4)) or
						((cont_verti >= 404-num3) and (cont_verti <= 408-num3 ) and (cont_horiz >= 155 +num4) and (cont_horiz <= 159+num4)) or
						((cont_verti >= 404-num3) and (cont_verti <= 408-num3 ) and (cont_horiz >= 175 +num4) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 409-num3) and (cont_verti <= 420-num3 ) and (cont_horiz >= 133 +num4) and (cont_horiz <= 182+num4))))then
						color <= cian_0;
						end if;
if((unidad_vga_saldo = "0100") and (((cont_verti >= 371-num3) and (cont_verti <= 383-num3 ) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 384-num3) and (cont_verti <= 388-num3 ) and (cont_horiz >= 133 +num4) and (cont_horiz <= 139+num4)) or
						((cont_verti >= 384-num3) and (cont_verti <= 388-num3 ) and (cont_horiz >= 155+num4 ) and (cont_horiz <= 159+num4)) or
						((cont_verti >= 384-num3) and (cont_verti <= 388-num3 ) and (cont_horiz >= 175+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 389-num3) and (cont_verti <= 403-num3 ) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 154+num4)) or
						((cont_verti >= 389-num3) and (cont_verti <= 403-num3 ) and (cont_horiz >= 160+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 404-num3) and (cont_verti <= 408-num3 ) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 139+num4)) or
						((cont_verti >= 404-num3) and (cont_verti <= 408-num3 ) and (cont_horiz >= 155+num4 ) and (cont_horiz <= 159+num4)) or
						((cont_verti >= 404-num3) and (cont_verti <= 408-num3 ) and (cont_horiz >= 175+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 409-num3) and (cont_verti <= 420-num3 ) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 384-num3) and (cont_verti <= 388-num3 ) and (cont_horiz >= 160+num4 ) and (cont_horiz <= 182+num4))))then
						color <= cian_0;
						end if;
if((unidad_vga_saldo = "0101") and (((cont_verti >= 371-num3) and (cont_verti <= 383-num3 ) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 384-num3) and (cont_verti <= 388 -num3) and (cont_horiz >= 133 +num4) and (cont_horiz <= 139+num4)) or
						((cont_verti >= 384-num3) and (cont_verti <= 388-num3 ) and (cont_horiz >= 155+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 389-num3) and (cont_verti <= 403-num3 ) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 134+num4)) or
						((cont_verti >= 389-num3) and (cont_verti <= 403-num3 ) and (cont_horiz >= 140+num4 ) and (cont_horiz <= 154+num4)) or
						((cont_verti >= 389-num3) and (cont_verti <= 403-num3 ) and (cont_horiz >= 160+num4 ) and (cont_horiz <= 174+num4)) or
						((cont_verti >= 389-num3) and (cont_verti <= 403-num3 ) and (cont_horiz >= 180+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 404-num3) and (cont_verti <= 408-num3 ) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 159+num4)) or
						((cont_verti >= 404-num3) and (cont_verti <= 408-num3 ) and (cont_horiz >= 175+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 409-num3) and (cont_verti <= 420-num3 ) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 182+num4))))then
						color <= cian_0;
						end if;
if((unidad_vga_saldo = "0110") and (((cont_verti >= 371-num3) and (cont_verti <= 383-num3) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 384-num3) and (cont_verti <= 388-num3 ) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 139+num4)) or
						((cont_verti >= 384-num3) and (cont_verti <= 388-num3 ) and (cont_horiz >= 155 +num4) and (cont_horiz <= 159+num4)) or
						((cont_verti >= 384-num3) and (cont_verti <= 388-num3 ) and (cont_horiz >= 175+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 389-num3) and (cont_verti <= 403-num3 ) and (cont_horiz >= 133 +num4) and (cont_horiz <= 134+num4)) or
						((cont_verti >= 389-num3) and (cont_verti <= 403-num3 ) and (cont_horiz >= 140+num4 ) and (cont_horiz <= 154+num4)) or
						((cont_verti >= 389-num3) and (cont_verti <= 403-num3 ) and (cont_horiz >= 160+num4 ) and (cont_horiz <= 174+num4)) or
						((cont_verti >= 389-num3) and (cont_verti <= 403-num3 ) and (cont_horiz >= 180+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 404-num3) and (cont_verti <= 408-num3 ) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 159+num4)) or
						((cont_verti >= 404-num3) and (cont_verti <= 408-num3 ) and (cont_horiz >= 175+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 409-num3) and (cont_verti <= 420-num3 ) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 182+num4))))then
						color <= cian_0;
						end if;
if((unidad_vga_saldo = "0111") and (((cont_verti >= 371-num3) and (cont_verti <= 388-num3 ) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 389-num3) and (cont_verti <= 403-num3 ) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 134+num4)) or
						((cont_verti >= 389-num3) and (cont_verti <= 403-num3 ) and (cont_horiz >= 140+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 404-num3) and (cont_verti <= 408-num3 ) and (cont_horiz >= 133 +num4) and (cont_horiz <= 139+num4)) or
						((cont_verti >= 404-num3) and (cont_verti <= 408-num3 ) and (cont_horiz >= 155 +num4) and (cont_horiz <= 159+num4)) or
						((cont_verti >= 404-num3) and (cont_verti <= 408-num3 ) and (cont_horiz >= 175+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 409-num3) and (cont_verti <= 420-num3 ) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 182+num4))))then
						color <= cian_0;
						end if;
if((unidad_vga_saldo = "1000") and (((cont_verti >= 371-num3) and (cont_verti <= 383-num3 ) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 384-num3) and (cont_verti <= 388 -num3) and (cont_horiz >= 133 +num4) and (cont_horiz <= 139+num4)) or
						((cont_verti >= 384-num3) and (cont_verti <= 388-num3 ) and (cont_horiz >= 155+num4 ) and (cont_horiz <= 159+num4)) or
						((cont_verti >= 384-num3) and (cont_verti <= 388-num3 ) and (cont_horiz >= 175+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 389-num3) and (cont_verti <= 403 -num3) and (cont_horiz >= 133 +num4) and (cont_horiz <= 134+num4)) or
						((cont_verti >= 389-num3) and (cont_verti <= 403-num3 ) and (cont_horiz >= 140 +num4) and (cont_horiz <= 154+num4)) or
						((cont_verti >= 389-num3) and (cont_verti <= 403-num3 ) and (cont_horiz >= 160+num4 ) and (cont_horiz <= 174+num4)) or
						((cont_verti >= 389-num3) and (cont_verti <= 403-num3 ) and (cont_horiz >= 180+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 404-num3) and (cont_verti <= 408-num3 ) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 139+num4)) or
						((cont_verti >= 404-num3) and (cont_verti <= 408-num3 ) and (cont_horiz >= 155+num4 ) and (cont_horiz <= 159+num4)) or
						((cont_verti >= 404-num3) and (cont_verti <= 408-num3 ) and (cont_horiz >= 175+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 409-num3) and (cont_verti <= 420-num3 ) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 182+num4))))then
						color <= cian_0;
						end if;
if((unidad_vga_saldo = "1001") and (((cont_verti >= 371-num3) and (cont_verti <= 383-num3 ) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 384-num3) and (cont_verti <= 388 -num3) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 139+num4)) or
						((cont_verti >= 384-num3) and (cont_verti <= 388-num3 ) and (cont_horiz >= 155+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 389-num3) and (cont_verti <= 403-num3 ) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 134+num4)) or
						((cont_verti >= 389-num3) and (cont_verti <= 403-num3 ) and (cont_horiz >= 140+num4 ) and (cont_horiz <= 154+num4)) or
						((cont_verti >= 389-num3) and (cont_verti <= 403 -num3) and (cont_horiz >= 160+num4 ) and (cont_horiz <= 174+num4)) or
						((cont_verti >= 389-num3) and (cont_verti <= 403 -num3) and (cont_horiz >= 180+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 404-num3) and (cont_verti <= 408 -num3) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 139+num4)) or
						((cont_verti >= 404-num3) and (cont_verti <= 408 -num3) and (cont_horiz >= 155+num4 ) and (cont_horiz <= 159+num4)) or
						((cont_verti >= 404-num3) and (cont_verti <= 408 -num3) and (cont_horiz >= 175+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 409-num3) and (cont_verti <= 420-num3 ) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 182+num4))))then
						color <= cian_0;
						end if;



-----------------NUMERO DE LA decimal --------------------------------


if ((decimal_vga_saldo = "0000") and (((cont_verti >= 371-num3+num5) and (cont_verti <= 383-num3+num5 ) and (cont_horiz >= 133 +num4) and (cont_horiz <= 182+num4)) or 
						((cont_verti >= 384-num3+num5) and (cont_verti <= 388 -num3+num5) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 139+num4)) or
						((cont_verti >= 384-num3+num5) and (cont_verti <= 388 -num3+num5) and (cont_horiz >= 155 +num4) and (cont_horiz <= 159+num4)) or
						((cont_verti >= 384-num3+num5) and (cont_verti <= 388 -num3+num5) and (cont_horiz >= 175 +num4) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 389-num3+num5) and (cont_verti <= 403-num3 +num5) and (cont_horiz >= 133 +num4) and (cont_horiz <= 134+num4)) or
						((cont_verti >= 389-num3+num5) and (cont_verti <= 403-num3+num5 ) and (cont_horiz >= 140 +num4) and (cont_horiz <= 174+num4)) or
						((cont_verti >= 389-num3+num5) and (cont_verti <= 403-num3+num5 ) and (cont_horiz >= 180 +num4) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 404-num3+num5) and (cont_verti <= 408-num3+num5 ) and (cont_horiz >= 133 +num4) and (cont_horiz <= 139+num4)) or
						((cont_verti >= 404-num3+num5) and (cont_verti <= 408 -num3+num5) and (cont_horiz >= 155+num4 ) and (cont_horiz <= 159+num4)) or
						((cont_verti >= 404-num3+num5) and (cont_verti <= 408 -num3+num5) and (cont_horiz >= 175 +num4) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 409-num3+num5) and (cont_verti <= 420-num3 +num5) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 182+num4))))then
						color <= cian_0;
						end if;
if((decimal_vga_saldo = "0001") and (((cont_verti >= 371-num3+num5) and (cont_verti <= 403-num3+num5 ) and (cont_horiz >= 133 +num4) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 404-num3+num5) and (cont_verti <= 408 -num3+num5) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 139+num4)) or
						((cont_verti >= 404-num3+num5) and (cont_verti <= 408-num3+num5 ) and (cont_horiz >= 155+num4 ) and (cont_horiz <= 159+num4)) or
						((cont_verti >= 404-num3+num5) and (cont_verti <= 408-num3+num5 ) and (cont_horiz >= 175+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 409-num3+num5) and (cont_verti <= 420 -num3+num5) and (cont_horiz >= 133 +num4) and (cont_horiz <= 182+num4))))then
						color <= cian_0;
						end if;
if((decimal_vga_saldo = "0010") and (((cont_verti >= 371-num3+num5) and (cont_verti <= 383 -num3+num5) and (cont_horiz >= 133 +num4) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 384-num3+num5) and (cont_verti <= 388 -num3+num5) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 159+num4)) or
						((cont_verti >= 384-num3+num5) and (cont_verti <= 388 -num3+num5) and (cont_horiz >= 175+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 389-num3+num5) and (cont_verti <= 403-num3+num5 ) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 134+num4)) or
						((cont_verti >= 389-num3+num5) and (cont_verti <= 403 -num3+num5) and (cont_horiz >= 140+num4 ) and (cont_horiz <= 154+num4)) or
						((cont_verti >= 389-num3+num5) and (cont_verti <= 403-num3 +num5) and (cont_horiz >= 160+num4 ) and (cont_horiz <= 174+num4)) or
						((cont_verti >= 389-num3+num5) and (cont_verti <= 403-num3+num5 ) and (cont_horiz >= 180+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 404-num3+num5) and (cont_verti <= 408-num3+num5 ) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 139+num4)) or
						((cont_verti >= 404-num3+num5) and (cont_verti <= 408-num3+num5 ) and (cont_horiz >= 155+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 409-num3+num5) and (cont_verti <= 420-num3+num5 ) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 182+num4))))then
						color <= cian_0;
						end if;
if((decimal_vga_saldo = "0011") and (((cont_verti >= 371-num3+num5) and (cont_verti <= 388-num3+num5 ) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 389-num3+num5) and (cont_verti <= 403-num3+num5 ) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 134+num4)) or
						((cont_verti >= 389-num3+num5) and (cont_verti <= 403-num3+num5 ) and (cont_horiz >= 140+num4 ) and (cont_horiz <= 154+num4)) or
						((cont_verti >= 389-num3+num5) and (cont_verti <= 403-num3+num5 ) and (cont_horiz >= 160+num4 ) and (cont_horiz <= 174+num4)) or
						((cont_verti >= 389-num3+num5) and (cont_verti <= 403-num3+num5 ) and (cont_horiz >= 180+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 404-num3+num5) and (cont_verti <= 408-num3+num5 ) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 139+num4)) or
						((cont_verti >= 404-num3+num5) and (cont_verti <= 408-num3+num5 ) and (cont_horiz >= 155 +num4) and (cont_horiz <= 159+num4)) or
						((cont_verti >= 404-num3+num5) and (cont_verti <= 408-num3+num5 ) and (cont_horiz >= 175 +num4) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 409-num3+num5) and (cont_verti <= 420-num3+num5 ) and (cont_horiz >= 133 +num4) and (cont_horiz <= 182+num4))))then
						color <= cian_0;
						end if;
if((decimal_vga_saldo = "0100") and (((cont_verti >= 371-num3+num5) and (cont_verti <= 383-num3+num5 ) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 384-num3+num5) and (cont_verti <= 388-num3 +num5) and (cont_horiz >= 133 +num4) and (cont_horiz <= 139+num4)) or
						((cont_verti >= 384-num3+num5) and (cont_verti <= 388-num3+num5 ) and (cont_horiz >= 155+num4 ) and (cont_horiz <= 159+num4)) or
						((cont_verti >= 384-num3+num5) and (cont_verti <= 388-num3+num5 ) and (cont_horiz >= 175+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 389-num3+num5) and (cont_verti <= 403-num3 +num5) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 154+num4)) or
						((cont_verti >= 389-num3+num5) and (cont_verti <= 403-num3 +num5) and (cont_horiz >= 160+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 404-num3+num5) and (cont_verti <= 408-num3 +num5) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 139+num4)) or
						((cont_verti >= 404-num3+num5) and (cont_verti <= 408-num3 +num5) and (cont_horiz >= 155+num4 ) and (cont_horiz <= 159+num4)) or
						((cont_verti >= 404-num3+num5) and (cont_verti <= 408-num3 +num5) and (cont_horiz >= 175+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 409-num3+num5) and (cont_verti <= 420-num3+num5 ) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 384-num3+num5) and (cont_verti <= 388-num3+num5 ) and (cont_horiz >= 160+num4 ) and (cont_horiz <= 182+num4))))then
						color <= cian_0;
						end if;
if((decimal_vga_saldo = "0101") and (((cont_verti >= 371-num3+num5) and (cont_verti <= 383-num3 +num5) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 384-num3+num5) and (cont_verti <= 388 -num3+num5) and (cont_horiz >= 133 +num4) and (cont_horiz <= 139+num4)) or
						((cont_verti >= 384-num3+num5) and (cont_verti <= 388-num3+num5 ) and (cont_horiz >= 155+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 389-num3+num5) and (cont_verti <= 403-num3+num5 ) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 134+num4)) or
						((cont_verti >= 389-num3+num5) and (cont_verti <= 403-num3+num5 ) and (cont_horiz >= 140+num4 ) and (cont_horiz <= 154+num4)) or
						((cont_verti >= 389-num3+num5) and (cont_verti <= 403-num3+num5 ) and (cont_horiz >= 160+num4 ) and (cont_horiz <= 174+num4)) or
						((cont_verti >= 389-num3+num5) and (cont_verti <= 403-num3+num5 ) and (cont_horiz >= 180+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 404-num3+num5) and (cont_verti <= 408-num3 +num5) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 159+num4)) or
						((cont_verti >= 404-num3+num5) and (cont_verti <= 408-num3+num5 ) and (cont_horiz >= 175+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 409-num3+num5) and (cont_verti <= 420-num3+num5 ) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 182+num4))))then
						color <= cian_0;
						end if;
if((decimal_vga_saldo = "0110") and (((cont_verti >= 371-num3+num5) and (cont_verti <= 383-num3+num5) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 384-num3+num5) and (cont_verti <= 388-num3+num5 ) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 139+num4)) or
						((cont_verti >= 384-num3+num5) and (cont_verti <= 388-num3+num5 ) and (cont_horiz >= 155 +num4) and (cont_horiz <= 159+num4)) or
						((cont_verti >= 384-num3+num5) and (cont_verti <= 388-num3+num5 ) and (cont_horiz >= 175+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 389-num3+num5) and (cont_verti <= 403-num3+num5) and (cont_horiz >= 133 +num4) and (cont_horiz <= 134+num4)) or
						((cont_verti >= 389-num3+num5) and (cont_verti <= 403-num3+num5 ) and (cont_horiz >= 140+num4 ) and (cont_horiz <= 154+num4)) or
						((cont_verti >= 389-num3+num5) and (cont_verti <= 403-num3+num5 ) and (cont_horiz >= 160+num4 ) and (cont_horiz <= 174+num4)) or
						((cont_verti >= 389-num3+num5) and (cont_verti <= 403-num3+num5 ) and (cont_horiz >= 180+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 404-num3+num5) and (cont_verti <= 408-num3+num5 ) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 159+num4)) or
						((cont_verti >= 404-num3+num5) and (cont_verti <= 408-num3+num5 ) and (cont_horiz >= 175+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 409-num3+num5) and (cont_verti <= 420-num3+num5 ) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 182+num4))))then
						color <= cian_0;
						end if;
if((decimal_vga_saldo = "0111") and (((cont_verti >= 371-num3+num5) and (cont_verti <= 388-num3+num5 ) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 389-num3+num5) and (cont_verti <= 403-num3 +num5) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 134+num4)) or
						((cont_verti >= 389-num3+num5) and (cont_verti <= 403-num3+num5 ) and (cont_horiz >= 140+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 404-num3+num5) and (cont_verti <= 408-num3+num5 ) and (cont_horiz >= 133 +num4) and (cont_horiz <= 139+num4)) or
						((cont_verti >= 404-num3+num5) and (cont_verti <= 408-num3+num5 ) and (cont_horiz >= 155 +num4) and (cont_horiz <= 159+num4)) or
						((cont_verti >= 404-num3+num5) and (cont_verti <= 408-num3+num5 ) and (cont_horiz >= 175+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 409-num3+num5) and (cont_verti <= 420-num3 +num5) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 182+num4))))then
						color <= cian_0;
						end if;
if((decimal_vga_saldo = "1000") and (((cont_verti >= 371-num3+num5) and (cont_verti <= 383-num3+num5 ) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 384-num3+num5) and (cont_verti <= 388 -num3+num5) and (cont_horiz >= 133 +num4) and (cont_horiz <= 139+num4)) or
						((cont_verti >= 384-num3+num5) and (cont_verti <= 388-num3+num5 ) and (cont_horiz >= 155+num4 ) and (cont_horiz <= 159+num4)) or
						((cont_verti >= 384-num3+num5) and (cont_verti <= 388-num3+num5 ) and (cont_horiz >= 175+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 389-num3+num5) and (cont_verti <= 403 -num3+num5) and (cont_horiz >= 133 +num4) and (cont_horiz <= 134+num4)) or
						((cont_verti >= 389-num3+num5) and (cont_verti <= 403-num3+num5 ) and (cont_horiz >= 140 +num4) and (cont_horiz <= 154+num4)) or
						((cont_verti >= 389-num3+num5) and (cont_verti <= 403-num3+num5 ) and (cont_horiz >= 160+num4 ) and (cont_horiz <= 174+num4)) or
						((cont_verti >= 389-num3+num5) and (cont_verti <= 403-num3+num5 ) and (cont_horiz >= 180+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 404-num3+num5) and (cont_verti <= 408-num3+num5 ) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 139+num4)) or
						((cont_verti >= 404-num3+num5) and (cont_verti <= 408-num3 +num5) and (cont_horiz >= 155+num4 ) and (cont_horiz <= 159+num4)) or
						((cont_verti >= 404-num3+num5) and (cont_verti <= 408-num3 +num5) and (cont_horiz >= 175+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 409-num3+num5) and (cont_verti <= 420-num3 +num5) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 182+num4))))then
						color <= cian_0;
						end if;
if((decimal_vga_saldo = "1001") and (((cont_verti >= 371-num3+num5) and (cont_verti <= 383-num3+num5 ) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 384-num3+num5) and (cont_verti <= 388 -num3+num5) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 139+num4)) or
						((cont_verti >= 384-num3+num5) and (cont_verti <= 388-num3 +num5) and (cont_horiz >= 155+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 389-num3+num5) and (cont_verti <= 403-num3 +num5) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 134+num4)) or
						((cont_verti >= 389-num3+num5) and (cont_verti <= 403-num3 +num5) and (cont_horiz >= 140+num4 ) and (cont_horiz <= 154+num4)) or
						((cont_verti >= 389-num3+num5) and (cont_verti <= 403 -num3+num5) and (cont_horiz >= 160+num4 ) and (cont_horiz <= 174+num4)) or
						((cont_verti >= 389-num3+num5) and (cont_verti <= 403 -num3+num5) and (cont_horiz >= 180+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 404-num3+num5) and (cont_verti <= 408 -num3+num5) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 139+num4)) or
						((cont_verti >= 404-num3+num5) and (cont_verti <= 408 -num3+num5) and (cont_horiz >= 155+num4 ) and (cont_horiz <= 159+num4)) or
						((cont_verti >= 404-num3+num5) and (cont_verti <= 408 -num3+num5) and (cont_horiz >= 175+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 409-num3+num5) and (cont_verti <= 420-num3 +num5) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 182+num4))))then
						color <= cian_0;
						end if;



------------------------FIN DE CANTIDAD DE SALDO-----------------------------------	
		
		
------------------------CANTIDAD DE VUELTO------------------------------------------
------------DECENA DE VUELTO-----------
if ((decena_vga_vuelto = "0000") and (((cont_verti >= 371-num3+num8) and (cont_verti <= 383-num3+num8 ) and (cont_horiz >= 133 +num4) and (cont_horiz <= 182+num4)) or 
						((cont_verti >= 384-num3+num8) and (cont_verti <= 388 -num3+num8) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 139+num4)) or
						((cont_verti >= 384-num3+num8) and (cont_verti <= 388 -num3+num8) and (cont_horiz >= 155 +num4) and (cont_horiz <= 159+num4)) or
						((cont_verti >= 384-num3+num8) and (cont_verti <= 388 -num3+num8) and (cont_horiz >= 175 +num4) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 389-num3+num8) and (cont_verti <= 403-num3+num8 ) and (cont_horiz >= 133 +num4) and (cont_horiz <= 134+num4)) or
						((cont_verti >= 389-num3+num8) and (cont_verti <= 403-num3+num8 ) and (cont_horiz >= 140 +num4) and (cont_horiz <= 174+num4)) or
						((cont_verti >= 389-num3+num8) and (cont_verti <= 403-num3+num8 ) and (cont_horiz >= 180 +num4) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 404-num3+num8) and (cont_verti <= 408-num3+num8 ) and (cont_horiz >= 133 +num4) and (cont_horiz <= 139+num4)) or
						((cont_verti >= 404-num3+num8) and (cont_verti <= 408 -num3+num8) and (cont_horiz >= 155+num4 ) and (cont_horiz <= 159+num4)) or
						((cont_verti >= 404-num3+num8) and (cont_verti <= 408 -num3+num8) and (cont_horiz >= 175 +num4) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 409-num3+num8) and (cont_verti <= 420-num3+num8) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 182+num4))))then
						color <= cian_0;
						end if;
						if((decena_vga_vuelto = "0001") and (((cont_verti >= 371-num3+num8) and (cont_verti <= 403-num3+num8 ) and (cont_horiz >= 133 +num4) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 404-num3+num8) and (cont_verti <= 408 -num3+num8) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 139+num4)) or
						((cont_verti >= 404-num3+num8) and (cont_verti <= 408-num3+num8 ) and (cont_horiz >= 155+num4 ) and (cont_horiz <= 159+num4)) or
						((cont_verti >= 404-num3+num8) and (cont_verti <= 408-num3+num8 ) and (cont_horiz >= 175+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 409-num3+num8) and (cont_verti <= 420 -num3+num8) and (cont_horiz >= 133 +num4) and (cont_horiz <= 182+num4))))then
						color <= cian_0;
						end if;
						if((decena_vga_vuelto = "0010") and (((cont_verti >= 371-num3+num8) and (cont_verti <= 383 -num3+num8) and (cont_horiz >= 133 +num4) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 384-num3+num8) and (cont_verti <= 388 -num3+num8) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 159+num4)) or
						((cont_verti >= 384-num3+num8) and (cont_verti <= 388 -num3+num8) and (cont_horiz >= 175+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 389-num3+num8) and (cont_verti <= 403-num3 +num8) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 134+num4)) or
						((cont_verti >= 389-num3+num8) and (cont_verti <= 403 -num3+num8) and (cont_horiz >= 140+num4 ) and (cont_horiz <= 154+num4)) or
						((cont_verti >= 389-num3+num8) and (cont_verti <= 403-num3 +num8) and (cont_horiz >= 160+num4 ) and (cont_horiz <= 174+num4)) or
						((cont_verti >= 389-num3+num8) and (cont_verti <= 403-num3 +num8) and (cont_horiz >= 180+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 404-num3+num8) and (cont_verti <= 408-num3 +num8) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 139+num4)) or
						((cont_verti >= 404-num3+num8) and (cont_verti <= 408-num3 +num8) and (cont_horiz >= 155+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 409-num3+num8) and (cont_verti <= 420-num3+num8 ) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 182+num4))))then
						color <= cian_0;
						end if;
						if((decena_vga_vuelto = "0011") and (((cont_verti >= 371-num3+num8) and (cont_verti <= 388-num3+num8 ) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 389-num3+num8) and (cont_verti <= 403-num3 +num8) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 134+num4)) or
						((cont_verti >= 389-num3+num8) and (cont_verti <= 403-num3+num8 ) and (cont_horiz >= 140+num4 ) and (cont_horiz <= 154+num4)) or
						((cont_verti >= 389-num3+num8) and (cont_verti <= 403-num3+num8 ) and (cont_horiz >= 160+num4 ) and (cont_horiz <= 174+num4)) or
						((cont_verti >= 389-num3+num8) and (cont_verti <= 403-num3+num8 ) and (cont_horiz >= 180+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 404-num3+num8) and (cont_verti <= 408-num3+num8 ) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 139+num4)) or
						((cont_verti >= 404-num3+num8) and (cont_verti <= 408-num3+num8 ) and (cont_horiz >= 155 +num4) and (cont_horiz <= 159+num4)) or
						((cont_verti >= 404-num3+num8) and (cont_verti <= 408-num3+num8 ) and (cont_horiz >= 175 +num4) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 409-num3+num8) and (cont_verti <= 420-num3+num8 ) and (cont_horiz >= 133 +num4) and (cont_horiz <= 182+num4))))then
						color <= cian_0;
						end if;
						if((decena_vga_vuelto = "0100") and (((cont_verti >= 371-num3+num8) and (cont_verti <= 383-num3+num8 ) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 384-num3+num8) and (cont_verti <= 388-num3+num8 ) and (cont_horiz >= 133 +num4) and (cont_horiz <= 139+num4)) or
						((cont_verti >= 384-num3+num8) and (cont_verti <= 388-num3+num8 ) and (cont_horiz >= 155+num4 ) and (cont_horiz <= 159+num4)) or
						((cont_verti >= 384-num3+num8) and (cont_verti <= 388-num3+num8) and (cont_horiz >= 175+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 389-num3+num8) and (cont_verti <= 403-num3+num8) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 154+num4)) or
						((cont_verti >= 389-num3+num8) and (cont_verti <= 403-num3+num8 ) and (cont_horiz >= 160+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 404-num3+num8) and (cont_verti <= 408-num3+num8 ) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 139+num4)) or
						((cont_verti >= 404-num3+num8) and (cont_verti <= 408-num3+num8 ) and (cont_horiz >= 155+num4 ) and (cont_horiz <= 159+num4)) or
						((cont_verti >= 404-num3+num8) and (cont_verti <= 408-num3+num8 ) and (cont_horiz >= 175+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 409-num3+num8) and (cont_verti <= 420-num3+num8 ) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 384-num3+num8) and (cont_verti <= 388-num3+num8 ) and (cont_horiz >= 160+num4 ) and (cont_horiz <= 182+num4))))then
						color <= cian_0;
						end if;
						if((decena_vga_vuelto = "0101") and (((cont_verti >= 371-num3+num8) and (cont_verti <= 383-num3+num8 ) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 384-num3+num8) and (cont_verti <= 388-num3+num8) and (cont_horiz >= 133 +num4) and (cont_horiz <= 139+num4)) or
						((cont_verti >= 384-num3+num8) and (cont_verti <= 388-num3+num8 ) and (cont_horiz >= 155+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 389-num3+num8) and (cont_verti <= 403-num3+num8 ) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 134+num4)) or
						((cont_verti >= 389-num3+num8) and (cont_verti <= 403-num3+num8 ) and (cont_horiz >= 140+num4 ) and (cont_horiz <= 154+num4)) or
						((cont_verti >= 389-num3+num8) and (cont_verti <= 403-num3+num8 ) and (cont_horiz >= 160+num4 ) and (cont_horiz <= 174+num4)) or
						((cont_verti >= 389-num3+num8) and (cont_verti <= 403-num3+num8 ) and (cont_horiz >= 180+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 404-num3+num8) and (cont_verti <= 408-num3+num8 ) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 159+num4)) or
						((cont_verti >= 404-num3+num8) and (cont_verti <= 408-num3+num8 ) and (cont_horiz >= 175+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 409-num3+num8) and (cont_verti <= 420-num3+num8 ) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 182+num4))))then
						color <= cian_0;
						end if;
						if((decena_vga_vuelto = "0110") and (((cont_verti >= 371-num3+num8) and (cont_verti <= 383-num3+num8) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 384-num3+num8) and (cont_verti <= 388-num3+num8 ) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 139+num4)) or
						((cont_verti >= 384-num3+num8) and (cont_verti <= 388-num3+num8 ) and (cont_horiz >= 155 +num4) and (cont_horiz <= 159+num4)) or
						((cont_verti >= 384-num3+num8) and (cont_verti <= 388-num3+num8 ) and (cont_horiz >= 175+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 389-num3+num8) and (cont_verti <= 403-num3+num8 ) and (cont_horiz >= 133 +num4) and (cont_horiz <= 134+num4)) or
						((cont_verti >= 389-num3+num8) and (cont_verti <= 403-num3+num8 ) and (cont_horiz >= 140+num4 ) and (cont_horiz <= 154+num4)) or
						((cont_verti >= 389-num3+num8) and (cont_verti <= 403-num3+num8 ) and (cont_horiz >= 160+num4 ) and (cont_horiz <= 174+num4)) or
						((cont_verti >= 389-num3+num8) and (cont_verti <= 403-num3+num8 ) and (cont_horiz >= 180+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 404-num3+num8) and (cont_verti <= 408-num3+num8 ) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 159+num4)) or
						((cont_verti >= 404-num3+num8) and (cont_verti <= 408-num3+num8 ) and (cont_horiz >= 175+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 409-num3+num8) and (cont_verti <= 420-num3+num8 ) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 182+num4))))then
						color <= cian_0;
						end if;
						if((decena_vga_vuelto = "0111") and (((cont_verti >= 371-num3+num8) and (cont_verti <= 388-num3 +num8) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 389-num3+num8) and (cont_verti <= 403-num3 +num8) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 134+num4)) or
						((cont_verti >= 389-num3+num8) and (cont_verti <= 403-num3 +num8) and (cont_horiz >= 140+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 404-num3+num8) and (cont_verti <= 408-num3 +num8) and (cont_horiz >= 133 +num4) and (cont_horiz <= 139+num4)) or
						((cont_verti >= 404-num3+num8) and (cont_verti <= 408-num3 +num8) and (cont_horiz >= 155 +num4) and (cont_horiz <= 159+num4)) or
						((cont_verti >= 404-num3+num8) and (cont_verti <= 408-num3 +num8) and (cont_horiz >= 175+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 409-num3+num8) and (cont_verti <= 420-num3 +num8) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 182+num4))))then
						color <= cian_0;
						end if;
						if((decena_vga_vuelto = "1000") and (((cont_verti >= 371-num3+num8) and (cont_verti <= 383-num3+num8 ) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 384-num3+num8) and (cont_verti <= 388-num3+num8) and (cont_horiz >= 133 +num4) and (cont_horiz <= 139+num4)) or
						((cont_verti >= 384-num3+num8) and (cont_verti <= 388-num3+num8 ) and (cont_horiz >= 155+num4 ) and (cont_horiz <= 159+num4)) or
						((cont_verti >= 384-num3+num8) and (cont_verti <= 388-num3+num8 ) and (cont_horiz >= 175+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 389-num3+num8) and (cont_verti <= 403-num3+num8) and (cont_horiz >= 133 +num4) and (cont_horiz <= 134+num4)) or
						((cont_verti >= 389-num3+num8) and (cont_verti <= 403-num3+num8 ) and (cont_horiz >= 140 +num4) and (cont_horiz <= 154+num4)) or
						((cont_verti >= 389-num3+num8) and (cont_verti <= 403-num3+num8 ) and (cont_horiz >= 160+num4 ) and (cont_horiz <= 174+num4)) or
						((cont_verti >= 389-num3+num8) and (cont_verti <= 403-num3 +num8) and (cont_horiz >= 180+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 404-num3+num8) and (cont_verti <= 408-num3 +num8) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 139+num4)) or
						((cont_verti >= 404-num3+num8) and (cont_verti <= 408-num3 +num8) and (cont_horiz >= 155+num4 ) and (cont_horiz <= 159+num4)) or
						((cont_verti >= 404-num3+num8) and (cont_verti <= 408-num3+num8) and (cont_horiz >= 175+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 409-num3+num8) and (cont_verti <= 420-num3 +num8) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 182+num4))))then
						color <= cian_0;
						end if;
						if((decena_vga_vuelto = "1001") and (((cont_verti >= 371-num3+num8) and (cont_verti <= 383-num3 +num8) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 384-num3+num8) and (cont_verti <= 388-num3+num8) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 139+num4)) or
						((cont_verti >= 384-num3+num8) and (cont_verti <= 388-num3 +num8) and (cont_horiz >= 155+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 389-num3+num8) and (cont_verti <= 403-num3+num8 ) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 134+num4)) or
						((cont_verti >= 389-num3+num8) and (cont_verti <= 403-num3+num8 ) and (cont_horiz >= 140+num4 ) and (cont_horiz <= 154+num4)) or
						((cont_verti >= 389-num3+num8) and (cont_verti <= 403-num3+num8) and (cont_horiz >= 160+num4 ) and (cont_horiz <= 174+num4)) or
						((cont_verti >= 389-num3+num8) and (cont_verti <= 403-num3+num8) and (cont_horiz >= 180+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 404-num3+num8) and (cont_verti <= 408-num3+num8) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 139+num4)) or
						((cont_verti >= 404-num3+num8) and (cont_verti <= 408-num3+num8) and (cont_horiz >= 155+num4 ) and (cont_horiz <= 159+num4)) or
						((cont_verti >= 404-num3+num8) and (cont_verti <= 408-num3+num8) and (cont_horiz >= 175+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 409-num3+num8) and (cont_verti <= 420-num3 +num8) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 182+num4))))then
						color <= cian_0;
						end if;
----------------UNIDAD DE VUELTO--------------------
if ((unidad_vga_vuelto = "0000") and (((cont_verti >= 371-num3+num6) and (cont_verti <= 383-num3+num6 ) and (cont_horiz >= 133 +num4) and (cont_horiz <= 182+num4)) or 
						((cont_verti >= 384-num3+num6) and (cont_verti <= 388 -num3+num6) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 139+num4)) or
						((cont_verti >= 384-num3+num6) and (cont_verti <= 388 -num3+num6) and (cont_horiz >= 155 +num4) and (cont_horiz <= 159+num4)) or
						((cont_verti >= 384-num3+num6) and (cont_verti <= 388 -num3+num6) and (cont_horiz >= 175 +num4) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 389-num3+num6) and (cont_verti <= 403-num3+num6 ) and (cont_horiz >= 133 +num4) and (cont_horiz <= 134+num4)) or
						((cont_verti >= 389-num3+num6) and (cont_verti <= 403-num3+num6 ) and (cont_horiz >= 140 +num4) and (cont_horiz <= 174+num4)) or
						((cont_verti >= 389-num3+num6) and (cont_verti <= 403-num3+num6 ) and (cont_horiz >= 180 +num4) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 404-num3+num6) and (cont_verti <= 408-num3+num6 ) and (cont_horiz >= 133 +num4) and (cont_horiz <= 139+num4)) or
						((cont_verti >= 404-num3+num6) and (cont_verti <= 408 -num3+num6) and (cont_horiz >= 155+num4 ) and (cont_horiz <= 159+num4)) or
						((cont_verti >= 404-num3+num6) and (cont_verti <= 408 -num3+num6) and (cont_horiz >= 175 +num4) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 409-num3+num6) and (cont_verti <= 420-num3+num6) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 182+num4))))then
						color <= cian_0;
						end if;
						if((unidad_vga_vuelto = "0001") and (((cont_verti >= 371-num3+num6) and (cont_verti <= 403-num3+num6 ) and (cont_horiz >= 133 +num4) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 404-num3+num6) and (cont_verti <= 408 -num3+num6) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 139+num4)) or
						((cont_verti >= 404-num3+num6) and (cont_verti <= 408-num3+num6 ) and (cont_horiz >= 155+num4 ) and (cont_horiz <= 159+num4)) or
						((cont_verti >= 404-num3+num6) and (cont_verti <= 408-num3+num6 ) and (cont_horiz >= 175+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 409-num3+num6) and (cont_verti <= 420 -num3+num6) and (cont_horiz >= 133 +num4) and (cont_horiz <= 182+num4))))then
						color <= cian_0;
						end if;
						if((unidad_vga_vuelto = "0010") and (((cont_verti >= 371-num3+num6) and (cont_verti <= 383 -num3+num6) and (cont_horiz >= 133 +num4) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 384-num3+num6) and (cont_verti <= 388 -num3+num6) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 159+num4)) or
						((cont_verti >= 384-num3+num6) and (cont_verti <= 388 -num3+num6) and (cont_horiz >= 175+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 389-num3+num6) and (cont_verti <= 403-num3 +num6) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 134+num4)) or
						((cont_verti >= 389-num3+num6) and (cont_verti <= 403 -num3+num6) and (cont_horiz >= 140+num4 ) and (cont_horiz <= 154+num4)) or
						((cont_verti >= 389-num3+num6) and (cont_verti <= 403-num3 +num6) and (cont_horiz >= 160+num4 ) and (cont_horiz <= 174+num4)) or
						((cont_verti >= 389-num3+num6) and (cont_verti <= 403-num3 +num6) and (cont_horiz >= 180+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 404-num3+num6) and (cont_verti <= 408-num3 +num6) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 139+num4)) or
						((cont_verti >= 404-num3+num6) and (cont_verti <= 408-num3 +num6) and (cont_horiz >= 155+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 409-num3+num6) and (cont_verti <= 420-num3+num6 ) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 182+num4))))then
						color <= cian_0;
						end if;
						if((unidad_vga_vuelto = "0011") and (((cont_verti >= 371-num3+num6) and (cont_verti <= 388-num3+num6 ) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 389-num3+num6) and (cont_verti <= 403-num3 +num6) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 134+num4)) or
						((cont_verti >= 389-num3+num6) and (cont_verti <= 403-num3+num6 ) and (cont_horiz >= 140+num4 ) and (cont_horiz <= 154+num4)) or
						((cont_verti >= 389-num3+num6) and (cont_verti <= 403-num3+num6 ) and (cont_horiz >= 160+num4 ) and (cont_horiz <= 174+num4)) or
						((cont_verti >= 389-num3+num6) and (cont_verti <= 403-num3+num6 ) and (cont_horiz >= 180+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 404-num3+num6) and (cont_verti <= 408-num3+num6 ) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 139+num4)) or
						((cont_verti >= 404-num3+num6) and (cont_verti <= 408-num3+num6 ) and (cont_horiz >= 155 +num4) and (cont_horiz <= 159+num4)) or
						((cont_verti >= 404-num3+num6) and (cont_verti <= 408-num3+num6 ) and (cont_horiz >= 175 +num4) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 409-num3+num6) and (cont_verti <= 420-num3+num6 ) and (cont_horiz >= 133 +num4) and (cont_horiz <= 182+num4))))then
						color <= cian_0;
						end if;
						if((unidad_vga_vuelto = "0100") and (((cont_verti >= 371-num3+num6) and (cont_verti <= 383-num3+num6 ) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 384-num3+num6) and (cont_verti <= 388-num3+num6 ) and (cont_horiz >= 133 +num4) and (cont_horiz <= 139+num4)) or
						((cont_verti >= 384-num3+num6) and (cont_verti <= 388-num3+num6 ) and (cont_horiz >= 155+num4 ) and (cont_horiz <= 159+num4)) or
						((cont_verti >= 384-num3+num6) and (cont_verti <= 388-num3 +num6) and (cont_horiz >= 175+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 389-num3+num6) and (cont_verti <= 403-num3 +num6) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 154+num4)) or
						((cont_verti >= 389-num3+num6) and (cont_verti <= 403-num3+num6 ) and (cont_horiz >= 160+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 404-num3+num6) and (cont_verti <= 408-num3+num6 ) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 139+num4)) or
						((cont_verti >= 404-num3+num6) and (cont_verti <= 408-num3+num6 ) and (cont_horiz >= 155+num4 ) and (cont_horiz <= 159+num4)) or
						((cont_verti >= 404-num3+num6) and (cont_verti <= 408-num3+num6 ) and (cont_horiz >= 175+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 409-num3+num6) and (cont_verti <= 420-num3+num6 ) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 384-num3+num6) and (cont_verti <= 388-num3+num6 ) and (cont_horiz >= 160+num4 ) and (cont_horiz <= 182+num4))))then
						color <= cian_0;
						end if;
						if((unidad_vga_vuelto = "0101") and (((cont_verti >= 371-num3+num6) and (cont_verti <= 383-num3+num6 ) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 384-num3+num6) and (cont_verti <= 388 -num3+num6) and (cont_horiz >= 133 +num4) and (cont_horiz <= 139+num4)) or
						((cont_verti >= 384-num3+num6) and (cont_verti <= 388-num3+num6 ) and (cont_horiz >= 155+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 389-num3+num6) and (cont_verti <= 403-num3+num6 ) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 134+num4)) or
						((cont_verti >= 389-num3+num6) and (cont_verti <= 403-num3+num6 ) and (cont_horiz >= 140+num4 ) and (cont_horiz <= 154+num4)) or
						((cont_verti >= 389-num3+num6) and (cont_verti <= 403-num3+num6 ) and (cont_horiz >= 160+num4 ) and (cont_horiz <= 174+num4)) or
						((cont_verti >= 389-num3+num6) and (cont_verti <= 403-num3+num6 ) and (cont_horiz >= 180+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 404-num3+num6) and (cont_verti <= 408-num3+num6 ) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 159+num4)) or
						((cont_verti >= 404-num3+num6) and (cont_verti <= 408-num3+num6 ) and (cont_horiz >= 175+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 409-num3+num6) and (cont_verti <= 420-num3+num6 ) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 182+num4))))then
						color <= cian_0;
						end if;
						if((unidad_vga_vuelto = "0110") and (((cont_verti >= 371-num3+num6) and (cont_verti <= 383-num3+num6) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 384-num3+num6) and (cont_verti <= 388-num3+num6 ) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 139+num4)) or
						((cont_verti >= 384-num3+num6) and (cont_verti <= 388-num3+num6 ) and (cont_horiz >= 155 +num4) and (cont_horiz <= 159+num4)) or
						((cont_verti >= 384-num3+num6) and (cont_verti <= 388-num3+num6 ) and (cont_horiz >= 175+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 389-num3+num6) and (cont_verti <= 403-num3+num6 ) and (cont_horiz >= 133 +num4) and (cont_horiz <= 134+num4)) or
						((cont_verti >= 389-num3+num6) and (cont_verti <= 403-num3+num6 ) and (cont_horiz >= 140+num4 ) and (cont_horiz <= 154+num4)) or
						((cont_verti >= 389-num3+num6) and (cont_verti <= 403-num3+num6 ) and (cont_horiz >= 160+num4 ) and (cont_horiz <= 174+num4)) or
						((cont_verti >= 389-num3+num6) and (cont_verti <= 403-num3+num6 ) and (cont_horiz >= 180+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 404-num3+num6) and (cont_verti <= 408-num3+num6 ) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 159+num4)) or
						((cont_verti >= 404-num3+num6) and (cont_verti <= 408-num3+num6 ) and (cont_horiz >= 175+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 409-num3+num6) and (cont_verti <= 420-num3+num6 ) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 182+num4))))then
						color <= cian_0;
						end if;
						if((unidad_vga_vuelto = "0111") and (((cont_verti >= 371-num3+num6) and (cont_verti <= 388-num3 +num6) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 389-num3+num6) and (cont_verti <= 403-num3 +num6) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 134+num4)) or
						((cont_verti >= 389-num3+num6) and (cont_verti <= 403-num3 +num6) and (cont_horiz >= 140+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 404-num3+num6) and (cont_verti <= 408-num3 +num6) and (cont_horiz >= 133 +num4) and (cont_horiz <= 139+num4)) or
						((cont_verti >= 404-num3+num6) and (cont_verti <= 408-num3 +num6) and (cont_horiz >= 155 +num4) and (cont_horiz <= 159+num4)) or
						((cont_verti >= 404-num3+num6) and (cont_verti <= 408-num3 +num6) and (cont_horiz >= 175+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 409-num3+num6) and (cont_verti <= 420-num3 +num6) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 182+num4))))then
						color <= cian_0;
						end if;
						if((unidad_vga_vuelto = "1000") and (((cont_verti >= 371-num3+num6) and (cont_verti <= 383-num3+num6 ) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 384-num3+num6) and (cont_verti <= 388 -num3+num6) and (cont_horiz >= 133 +num4) and (cont_horiz <= 139+num4)) or
						((cont_verti >= 384-num3+num6) and (cont_verti <= 388-num3+num6 ) and (cont_horiz >= 155+num4 ) and (cont_horiz <= 159+num4)) or
						((cont_verti >= 384-num3+num6) and (cont_verti <= 388-num3+num6 ) and (cont_horiz >= 175+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 389-num3+num6) and (cont_verti <= 403 -num3+num6) and (cont_horiz >= 133 +num4) and (cont_horiz <= 134+num4)) or
						((cont_verti >= 389-num3+num6) and (cont_verti <= 403-num3+num6 ) and (cont_horiz >= 140 +num4) and (cont_horiz <= 154+num4)) or
						((cont_verti >= 389-num3+num6) and (cont_verti <= 403-num3+num6 ) and (cont_horiz >= 160+num4 ) and (cont_horiz <= 174+num4)) or
						((cont_verti >= 389-num3+num6) and (cont_verti <= 403-num3 +num6) and (cont_horiz >= 180+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 404-num3+num6) and (cont_verti <= 408-num3 +num6) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 139+num4)) or
						((cont_verti >= 404-num3+num6) and (cont_verti <= 408-num3 +num6) and (cont_horiz >= 155+num4 ) and (cont_horiz <= 159+num4)) or
						((cont_verti >= 404-num3+num6) and (cont_verti <= 408-num3+num6) and (cont_horiz >= 175+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 409-num3+num6) and (cont_verti <= 420-num3 +num6) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 182+num4))))then
						color <= cian_0;
						end if;
						if((unidad_vga_vuelto = "1001") and (((cont_verti >= 371-num3+num6) and (cont_verti <= 383-num3 +num6) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 384-num3+num6) and (cont_verti <= 388 -num3+num6) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 139+num4)) or
						((cont_verti >= 384-num3+num6) and (cont_verti <= 388-num3 +num6) and (cont_horiz >= 155+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 389-num3+num6) and (cont_verti <= 403-num3+num6 ) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 134+num4)) or
						((cont_verti >= 389-num3+num6) and (cont_verti <= 403-num3+num6 ) and (cont_horiz >= 140+num4 ) and (cont_horiz <= 154+num4)) or
						((cont_verti >= 389-num3+num6) and (cont_verti <= 403 -num3+num6) and (cont_horiz >= 160+num4 ) and (cont_horiz <= 174+num4)) or
						((cont_verti >= 389-num3+num6) and (cont_verti <= 403 -num3+num6) and (cont_horiz >= 180+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 404-num3+num6) and (cont_verti <= 408 -num3+num6) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 139+num4)) or
						((cont_verti >= 404-num3+num6) and (cont_verti <= 408 -num3+num6) and (cont_horiz >= 155+num4 ) and (cont_horiz <= 159+num4)) or
						((cont_verti >= 404-num3+num6) and (cont_verti <= 408 -num3+num6) and (cont_horiz >= 175+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 409-num3+num6) and (cont_verti <= 420-num3 +num6) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 182+num4))))then
						color <= cian_0;
						end if;



-----------------NUMERO DE DECIMALES  --------------------------------


if ((decimal_vga_vuelto = "0000") and (((cont_verti >= 371-num3+num5+num6) and (cont_verti <= 383-num3+num5+num6 ) and (cont_horiz >= 133 +num4) and (cont_horiz <= 182+num4)) or 
						((cont_verti >= 384-num3+num5+num6) and (cont_verti <= 388 -num3+num5+num6) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 139+num4)) or
						((cont_verti >= 384-num3+num5+num6) and (cont_verti <= 388 -num3+num5+num6) and (cont_horiz >= 155 +num4) and (cont_horiz <= 159+num4)) or
						((cont_verti >= 384-num3+num5+num6) and (cont_verti <= 388 -num3+num5+num6) and (cont_horiz >= 175 +num4) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 389-num3+num5+num6) and (cont_verti <= 403-num3 +num5+num6) and (cont_horiz >= 133 +num4) and (cont_horiz <= 134+num4)) or
						((cont_verti >= 389-num3+num5+num6) and (cont_verti <= 403-num3+num5+num6 ) and (cont_horiz >= 140 +num4) and (cont_horiz <= 174+num4)) or
						((cont_verti >= 389-num3+num5+num6) and (cont_verti <= 403-num3+num5+num6 ) and (cont_horiz >= 180 +num4) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 404-num3+num5+num6) and (cont_verti <= 408-num3+num5 +num6) and (cont_horiz >= 133 +num4) and (cont_horiz <= 139+num4)) or
						((cont_verti >= 404-num3+num5+num6) and (cont_verti <= 408 -num3+num5+num6) and (cont_horiz >= 155+num4 ) and (cont_horiz <= 159+num4)) or
						((cont_verti >= 404-num3+num5+num6) and (cont_verti <= 408 -num3+num5+num6) and (cont_horiz >= 175 +num4) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 409-num3+num5+num6) and (cont_verti <= 420-num3 +num5+num6) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 182+num4))))then
						color <= cian_0;
						end if;
						if((decimal_vga_vuelto = "0001") and (((cont_verti >= 371-num3+num5+num6) and (cont_verti <= 403-num3+num5+num6 ) and (cont_horiz >= 133 +num4) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 404-num3+num5+num6) and (cont_verti <= 408 -num3+num5+num6) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 139+num4)) or
						((cont_verti >= 404-num3+num5+num6) and (cont_verti <= 408-num3+num5+num6 ) and (cont_horiz >= 155+num4 ) and (cont_horiz <= 159+num4)) or
						((cont_verti >= 404-num3+num5+num6) and (cont_verti <= 408-num3+num5+num6 ) and (cont_horiz >= 175+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 409-num3+num5+num6) and (cont_verti <= 420 -num3+num5+num6) and (cont_horiz >= 133 +num4) and (cont_horiz <= 182+num4))))then
						color <= cian_0;
						end if;
						if((decimal_vga_vuelto = "0010") and (((cont_verti >= 371-num3+num5+num6) and (cont_verti <= 383 -num3+num5+num6) and (cont_horiz >= 133 +num4) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 384-num3+num5+num6) and (cont_verti <= 388 -num3+num5+num6) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 159+num4)) or
						((cont_verti >= 384-num3+num5+num6) and (cont_verti <= 388 -num3+num5+num6) and (cont_horiz >= 175+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 389-num3+num5+num6) and (cont_verti <= 403-num3+num5+num6 ) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 134+num4)) or
						((cont_verti >= 389-num3+num5+num6) and (cont_verti <= 403 -num3+num5+num6) and (cont_horiz >= 140+num4 ) and (cont_horiz <= 154+num4)) or
						((cont_verti >= 389-num3+num5+num6) and (cont_verti <= 403-num3 +num5+num6) and (cont_horiz >= 160+num4 ) and (cont_horiz <= 174+num4)) or
						((cont_verti >= 389-num3+num5+num6) and (cont_verti <= 403-num3+num5+num6 ) and (cont_horiz >= 180+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 404-num3+num5+num6) and (cont_verti <= 408-num3+num5+num6 ) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 139+num4)) or
						((cont_verti >= 404-num3+num5+num6) and (cont_verti <= 408-num3+num5+num6 ) and (cont_horiz >= 155+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 409-num3+num5+num6) and (cont_verti <= 420-num3+num5+num6 ) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 182+num4))))then
						color <= cian_0;
						end if;
						if((decimal_vga_vuelto = "0011") and (((cont_verti >= 371-num3+num5+num6) and (cont_verti <= 388-num3+num5+num6 ) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 389-num3+num5+num6) and (cont_verti <= 403-num3+num5+num6 ) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 134+num4)) or
						((cont_verti >= 389-num3+num5+num6) and (cont_verti <= 403-num3+num5+num6 ) and (cont_horiz >= 140+num4 ) and (cont_horiz <= 154+num4)) or
						((cont_verti >= 389-num3+num5+num6) and (cont_verti <= 403-num3+num5+num6 ) and (cont_horiz >= 160+num4 ) and (cont_horiz <= 174+num4)) or
						((cont_verti >= 389-num3+num5+num6) and (cont_verti <= 403-num3+num5+num6 ) and (cont_horiz >= 180+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 404-num3+num5+num6) and (cont_verti <= 408-num3+num5+num6 ) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 139+num4)) or
						((cont_verti >= 404-num3+num5+num6) and (cont_verti <= 408-num3+num5+num6 ) and (cont_horiz >= 155 +num4) and (cont_horiz <= 159+num4)) or
						((cont_verti >= 404-num3+num5+num6) and (cont_verti <= 408-num3+num5+num6 ) and (cont_horiz >= 175 +num4) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 409-num3+num5+num6) and (cont_verti <= 420-num3+num5+num6 ) and (cont_horiz >= 133 +num4) and (cont_horiz <= 182+num4))))then
						color <= cian_0;
						end if;
						if((decimal_vga_vuelto = "0100") and (((cont_verti >= 371-num3+num5+num6) and (cont_verti <= 383-num3+num5+num6 ) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 384-num3+num5+num6) and (cont_verti <= 388-num3 +num5+num6) and (cont_horiz >= 133 +num4) and (cont_horiz <= 139+num4)) or
						((cont_verti >= 384-num3+num5+num6) and (cont_verti <= 388-num3+num5+num6 ) and (cont_horiz >= 155+num4 ) and (cont_horiz <= 159+num4)) or
						((cont_verti >= 384-num3+num5+num6) and (cont_verti <= 388-num3+num5+num6 ) and (cont_horiz >= 175+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 389-num3+num5+num6) and (cont_verti <= 403-num3 +num5+num6) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 154+num4)) or
						((cont_verti >= 389-num3+num5+num6) and (cont_verti <= 403-num3 +num5+num6) and (cont_horiz >= 160+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 404-num3+num5+num6) and (cont_verti <= 408-num3 +num5+num6) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 139+num4)) or
						((cont_verti >= 404-num3+num5+num6) and (cont_verti <= 408-num3 +num5+num6) and (cont_horiz >= 155+num4 ) and (cont_horiz <= 159+num4)) or
						((cont_verti >= 404-num3+num5+num6) and (cont_verti <= 408-num3 +num5+num6) and (cont_horiz >= 175+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 409-num3+num5+num6) and (cont_verti <= 420-num3+num5+num6 ) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 384-num3+num5+num6) and (cont_verti <= 388-num3+num5+num6 ) and (cont_horiz >= 160+num4 ) and (cont_horiz <= 182+num4))))then
						color <= cian_0;
						end if;
						if((decimal_vga_vuelto = "0101") and (((cont_verti >= 371-num3+num5+num6) and (cont_verti <= 383-num3 +num5+num6) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 384-num3+num5+num6) and (cont_verti <= 388 -num3+num5+num6) and (cont_horiz >= 133 +num4) and (cont_horiz <= 139+num4)) or
						((cont_verti >= 384-num3+num5+num6) and (cont_verti <= 388-num3+num5+num6 ) and (cont_horiz >= 155+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 389-num3+num5+num6) and (cont_verti <= 403-num3+num5+num6 ) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 134+num4)) or
						((cont_verti >= 389-num3+num5+num6) and (cont_verti <= 403-num3+num5+num6 ) and (cont_horiz >= 140+num4 ) and (cont_horiz <= 154+num4)) or
						((cont_verti >= 389-num3+num5+num6) and (cont_verti <= 403-num3+num5+num6 ) and (cont_horiz >= 160+num4 ) and (cont_horiz <= 174+num4)) or
						((cont_verti >= 389-num3+num5+num6) and (cont_verti <= 403-num3+num5+num6 ) and (cont_horiz >= 180+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 404-num3+num5+num6) and (cont_verti <= 408-num3 +num5+num6) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 159+num4)) or
						((cont_verti >= 404-num3+num5+num6) and (cont_verti <= 408-num3+num5+num6 ) and (cont_horiz >= 175+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 409-num3+num5+num6) and (cont_verti <= 420-num3+num5 +num6) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 182+num4)))) then
						color <= cian_0;
						end if;
						if((decimal_vga_vuelto = "0110") and (((cont_verti >= 371-num3+num5+num6) and (cont_verti <= 383-num3+num5+num6) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 384-num3+num5+num6) and (cont_verti <= 388-num3+num5+num6 ) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 139+num4)) or
						((cont_verti >= 384-num3+num5+num6) and (cont_verti <= 388-num3+num5+num6 ) and (cont_horiz >= 155 +num4) and (cont_horiz <= 159+num4)) or
						((cont_verti >= 384-num3+num5+num6) and (cont_verti <= 388-num3+num5+num6 ) and (cont_horiz >= 175+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 389-num3+num5+num6) and (cont_verti <= 403-num3+num5+num6) and (cont_horiz >= 133 +num4) and (cont_horiz <= 134+num4)) or
						((cont_verti >= 389-num3+num5+num6) and (cont_verti <= 403-num3+num5+num6 ) and (cont_horiz >= 140+num4 ) and (cont_horiz <= 154+num4)) or
						((cont_verti >= 389-num3+num5+num6) and (cont_verti <= 403-num3+num5+num6 ) and (cont_horiz >= 160+num4 ) and (cont_horiz <= 174+num4)) or
						((cont_verti >= 389-num3+num5+num6) and (cont_verti <= 403-num3+num5+num6 ) and (cont_horiz >= 180+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 404-num3+num5+num6) and (cont_verti <= 408-num3+num5+num6 ) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 159+num4)) or
						((cont_verti >= 404-num3+num5+num6) and (cont_verti <= 408-num3+num5+num6 ) and (cont_horiz >= 175+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 409-num3+num5+num6) and (cont_verti <= 420-num3+num5+num6 ) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 182+num4))))then
						color <= cian_0;
						end if;
						if((decimal_vga_vuelto = "0111") and (((cont_verti >= 371-num3+num5+num6) and (cont_verti <= 388-num3+num5 +num6) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 389-num3+num5+num6) and (cont_verti <= 403-num3 +num5+num6) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 134+num4)) or
						((cont_verti >= 389-num3+num5+num6) and (cont_verti <= 403-num3+num5+num6 ) and (cont_horiz >= 140+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 404-num3+num5+num6) and (cont_verti <= 408-num3+num5+num6 ) and (cont_horiz >= 133 +num4) and (cont_horiz <= 139+num4)) or
						((cont_verti >= 404-num3+num5+num6) and (cont_verti <= 408-num3+num5+num6 ) and (cont_horiz >= 155 +num4) and (cont_horiz <= 159+num4)) or
						((cont_verti >= 404-num3+num5+num6) and (cont_verti <= 408-num3+num5+num6 ) and (cont_horiz >= 175+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 409-num3+num5+num6) and (cont_verti <= 420-num3 +num5+num6) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 182+num4))))then
						color <= cian_0;
						end if;
						if((decimal_vga_vuelto = "1000") and (((cont_verti >= 371-num3+num5+num6) and (cont_verti <= 383-num3+num5+num6 ) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 384-num3+num5+num6) and (cont_verti <= 388 -num3+num5+num6) and (cont_horiz >= 133 +num4) and (cont_horiz <= 139+num4)) or
						((cont_verti >= 384-num3+num5+num6) and (cont_verti <= 388-num3+num5 +num6) and (cont_horiz >= 155+num4 ) and (cont_horiz <= 159+num4)) or
						((cont_verti >= 384-num3+num5+num6) and (cont_verti <= 388-num3+num5 +num6) and (cont_horiz >= 175+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 389-num3+num5+num6) and (cont_verti <= 403 -num3+num5+num6) and (cont_horiz >= 133 +num4) and (cont_horiz <= 134+num4)) or
						((cont_verti >= 389-num3+num5+num6) and (cont_verti <= 403-num3+num5 +num6) and (cont_horiz >= 140 +num4) and (cont_horiz <= 154+num4)) or
						((cont_verti >= 389-num3+num5+num6) and (cont_verti <= 403-num3+num5 +num6) and (cont_horiz >= 160+num4 ) and (cont_horiz <= 174+num4)) or
						((cont_verti >= 389-num3+num5+num6) and (cont_verti <= 403-num3+num5 +num6) and (cont_horiz >= 180+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 404-num3+num5+num6) and (cont_verti <= 408-num3+num5 +num6) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 139+num4)) or
						((cont_verti >= 404-num3+num5+num6) and (cont_verti <= 408-num3 +num5+num6) and (cont_horiz >= 155+num4 ) and (cont_horiz <= 159+num4)) or
						((cont_verti >= 404-num3+num5+num6) and (cont_verti <= 408-num3 +num5+num6) and (cont_horiz >= 175+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 409-num3+num5+num6) and (cont_verti <= 420-num3 +num5+num6) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 182+num4))))then
						color <= cian_0;
						end if;
						if((decimal_vga_vuelto = "1001") and (((cont_verti >= 371-num3+num5+num6) and (cont_verti <= 383-num3+num5+num6 ) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 384-num3+num5+num6) and (cont_verti <= 388 -num3+num5+num6) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 139+num4)) or
						((cont_verti >= 384-num3+num5+num6) and (cont_verti <= 388-num3 +num5+num6) and (cont_horiz >= 155+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 389-num3+num5+num6) and (cont_verti <= 403-num3 +num5+num6) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 134+num4)) or
						((cont_verti >= 389-num3+num5+num6) and (cont_verti <= 403-num3 +num5+num6) and (cont_horiz >= 140+num4 ) and (cont_horiz <= 154+num4)) or
						((cont_verti >= 389-num3+num5+num6) and (cont_verti <= 403 -num3+num5+num6) and (cont_horiz >= 160+num4 ) and (cont_horiz <= 174+num4)) or
						((cont_verti >= 389-num3+num5+num6) and (cont_verti <= 403 -num3+num5+num6) and (cont_horiz >= 180+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 404-num3+num5+num6) and (cont_verti <= 408 -num3+num5+num6) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 139+num4)) or
						((cont_verti >= 404-num3+num5+num6) and (cont_verti <= 408 -num3+num5+num6) and (cont_horiz >= 155+num4 ) and (cont_horiz <= 159+num4)) or
						((cont_verti >= 404-num3+num5+num6) and (cont_verti <= 408 -num3+num5+num6) and (cont_horiz >= 175+num4 ) and (cont_horiz <= 182+num4)) or
						((cont_verti >= 409-num3+num5+num6) and (cont_verti <= 420-num3 +num5+num6) and (cont_horiz >= 133+num4 ) and (cont_horiz <= 182+num4))))then
						color <= cian_0;
						end if;

------------------------FIN DE CANTIDAD DE VUELTO----------------------------------------		
		
-----------CANTIDAD DE PRODUCTOS-----------------
	
	
------------DE AGUA ---------------------------
if ((qA = "0000") and (((cont_verti >= 371-num2) and (cont_verti <= 383-num2 ) and (cont_horiz >= 133 ) and (cont_horiz <= 182)) or 
						((cont_verti >= 384-num2) and (cont_verti <= 388 -num2) and (cont_horiz >= 133 ) and (cont_horiz <= 139)) or
						((cont_verti >= 384-num2) and (cont_verti <= 388-num2 ) and (cont_horiz >= 155 ) and (cont_horiz <= 159)) or
						((cont_verti >= 384-num2) and (cont_verti <= 388-num2 ) and (cont_horiz >= 175 ) and (cont_horiz <= 182)) or
						((cont_verti >= 389-num2) and (cont_verti <= 403-num2 ) and (cont_horiz >= 133 ) and (cont_horiz <= 134)) or
						((cont_verti >= 389-num2) and (cont_verti <= 403 -num2) and (cont_horiz >= 140 ) and (cont_horiz <= 174)) or
						((cont_verti >= 389-num2) and (cont_verti <= 403 -num2) and (cont_horiz >= 180 ) and (cont_horiz <= 182)) or
						((cont_verti >= 404-num2) and (cont_verti <= 408-num2 ) and (cont_horiz >= 133 ) and (cont_horiz <= 139)) or
						((cont_verti >= 404-num2) and (cont_verti <= 408-num2 ) and (cont_horiz >= 155 ) and (cont_horiz <= 159)) or
						((cont_verti >= 404-num2) and (cont_verti <= 408-num2 ) and (cont_horiz >= 175 ) and (cont_horiz <= 182)) or
						((cont_verti >= 409-num2) and (cont_verti <= 420 -num2) and (cont_horiz >= 133 ) and (cont_horiz <= 182))))then
						color <= verde_0;
						end if;
						if((qA = "0001") and (((cont_verti >= 371-num2) and (cont_verti <= 403-num2 ) and (cont_horiz >= 133 ) and (cont_horiz <= 182)) or
						((cont_verti >= 404-num2) and (cont_verti <= 408-num2 ) and (cont_horiz >= 133 ) and (cont_horiz <= 139)) or
						((cont_verti >= 404-num2) and (cont_verti <= 408 -num2) and (cont_horiz >= 155 ) and (cont_horiz <= 159)) or
						((cont_verti >= 404-num2) and (cont_verti <= 408-num2 ) and (cont_horiz >= 175 ) and (cont_horiz <= 182)) or
						((cont_verti >= 409-num2) and (cont_verti <= 420-num2 ) and (cont_horiz >= 133 ) and (cont_horiz <= 182))))then
						color <= verde_0;
						end if;
						if((qA = "0010") and (((cont_verti >= 371-num2) and (cont_verti <= 383-num2 ) and (cont_horiz >= 133 ) and (cont_horiz <= 182)) or
						((cont_verti >= 384-num2) and (cont_verti <= 388-num2 ) and (cont_horiz >= 133 ) and (cont_horiz <= 159)) or
						((cont_verti >= 384-num2) and (cont_verti <= 388-num2 ) and (cont_horiz >= 175 ) and (cont_horiz <= 182)) or
						((cont_verti >= 389-num2) and (cont_verti <= 403-num2 ) and (cont_horiz >= 133 ) and (cont_horiz <= 134)) or
						((cont_verti >= 389-num2) and (cont_verti <= 403-num2 ) and (cont_horiz >= 140 ) and (cont_horiz <= 154)) or
						((cont_verti >= 389-num2) and (cont_verti <= 403-num2 ) and (cont_horiz >= 160 ) and (cont_horiz <= 174)) or
						((cont_verti >= 389-num2) and (cont_verti <= 403-num2 ) and (cont_horiz >= 180 ) and (cont_horiz <= 182)) or
						((cont_verti >= 404-num2) and (cont_verti <= 408-num2 ) and (cont_horiz >= 133 ) and (cont_horiz <= 139)) or
						((cont_verti >= 404-num2) and (cont_verti <= 408 -num2) and (cont_horiz >= 155 ) and (cont_horiz <= 182)) or
						((cont_verti >= 409-num2) and (cont_verti <= 420-num2 ) and (cont_horiz >= 133 ) and (cont_horiz <= 182))))then
						color <= verde_0;
						end if;
						if((qA = "0011") and (((cont_verti >= 371-num2) and (cont_verti <= 388 -num2) and (cont_horiz >= 133 ) and (cont_horiz <= 182)) or
						((cont_verti >= 389-num2) and (cont_verti <= 403-num2 ) and (cont_horiz >= 133 ) and (cont_horiz <= 134)) or
						((cont_verti >= 389-num2) and (cont_verti <= 403-num2 ) and (cont_horiz >= 140 ) and (cont_horiz <= 154)) or
						((cont_verti >= 389-num2) and (cont_verti <= 403-num2 ) and (cont_horiz >= 160 ) and (cont_horiz <= 174)) or
						((cont_verti >= 389-num2) and (cont_verti <= 403-num2 ) and (cont_horiz >= 180 ) and (cont_horiz <= 182)) or
						((cont_verti >= 404-num2) and (cont_verti <= 408-num2 ) and (cont_horiz >= 133 ) and (cont_horiz <= 139)) or
						((cont_verti >= 404-num2) and (cont_verti <= 408-num2 ) and (cont_horiz >= 155 ) and (cont_horiz <= 159)) or
						((cont_verti >= 404-num2) and (cont_verti <= 408-num2 ) and (cont_horiz >= 175 ) and (cont_horiz <= 182)) or
						((cont_verti >= 409-num2) and (cont_verti <= 420-num2 ) and (cont_horiz >= 133 ) and (cont_horiz <= 182))))then
						color <= verde_0;
						end if;
						if((qA = "0100") and (((cont_verti >= 371-num2) and (cont_verti <= 383-num2 ) and (cont_horiz >= 133 ) and (cont_horiz <= 182)) or
						((cont_verti >= 384-num2) and (cont_verti <= 388-num2 ) and (cont_horiz >= 133 ) and (cont_horiz <= 139)) or
						((cont_verti >= 384-num2) and (cont_verti <= 388-num2 ) and (cont_horiz >= 155 ) and (cont_horiz <= 159)) or
						((cont_verti >= 384-num2) and (cont_verti <= 388-num2 ) and (cont_horiz >= 175 ) and (cont_horiz <= 182)) or
						((cont_verti >= 389-num2) and (cont_verti <= 403-num2 ) and (cont_horiz >= 133 ) and (cont_horiz <= 154)) or
						((cont_verti >= 389-num2) and (cont_verti <= 403-num2 ) and (cont_horiz >= 160 ) and (cont_horiz <= 182)) or
						((cont_verti >= 404-num2) and (cont_verti <= 408-num2 ) and (cont_horiz >= 133 ) and (cont_horiz <= 139)) or
						((cont_verti >= 404-num2) and (cont_verti <= 408-num2 ) and (cont_horiz >= 155 ) and (cont_horiz <= 159)) or
						((cont_verti >= 404-num2) and (cont_verti <= 408-num2 ) and (cont_horiz >= 175 ) and (cont_horiz <= 182)) or
						((cont_verti >= 409-num2) and (cont_verti <= 420 -num2) and (cont_horiz >= 133 ) and (cont_horiz <= 182)) or
						((cont_verti >= 384-num2) and (cont_verti <= 388 -num2) and (cont_horiz >= 160 ) and (cont_horiz <= 182))))then
						color <= verde_0;
						end if;
						if((qA = "0101") and (((cont_verti >= 371-num2) and (cont_verti <= 383-num2 ) and (cont_horiz >= 133 ) and (cont_horiz <= 182)) or
						((cont_verti >= 384-num2) and (cont_verti <= 388-num2 ) and (cont_horiz >= 133 ) and (cont_horiz <= 139)) or
						((cont_verti >= 384-num2) and (cont_verti <= 388-num2 ) and (cont_horiz >= 155 ) and (cont_horiz <= 182)) or
						((cont_verti >= 389-num2) and (cont_verti <= 403-num2 ) and (cont_horiz >= 133 ) and (cont_horiz <= 134)) or
						((cont_verti >= 389-num2) and (cont_verti <= 403-num2 ) and (cont_horiz >= 140 ) and (cont_horiz <= 154)) or
						((cont_verti >= 389-num2) and (cont_verti <= 403-num2 ) and (cont_horiz >= 160 ) and (cont_horiz <= 174)) or
						((cont_verti >= 389-num2) and (cont_verti <= 403-num2) and (cont_horiz >= 180 ) and (cont_horiz <= 182)) or
						((cont_verti >= 404-num2) and (cont_verti <= 408 -num2) and (cont_horiz >= 133 ) and (cont_horiz <= 159)) or
						((cont_verti >= 404-num2) and (cont_verti <= 408 -num2) and (cont_horiz >= 175 ) and (cont_horiz <= 182)) or
						((cont_verti >= 409-num2) and (cont_verti <= 420 -num2) and (cont_horiz >= 133 ) and (cont_horiz <= 182))))then
						color <= verde_0;
						end if;
						if((qA = "0110") and (((cont_verti >= 371-num2) and (cont_verti <= 383 -num2) and (cont_horiz >= 133 ) and (cont_horiz <= 182)) or
						((cont_verti >= 384-num2) and (cont_verti <= 388-num2 ) and (cont_horiz >= 133 ) and (cont_horiz <= 139)) or
						((cont_verti >= 384-num2) and (cont_verti <= 388-num2 ) and (cont_horiz >= 155 ) and (cont_horiz <= 159)) or
						((cont_verti >= 384-num2) and (cont_verti <= 388-num2 ) and (cont_horiz >= 175 ) and (cont_horiz <= 182)) or
						((cont_verti >= 389-num2) and (cont_verti <= 403-num2 ) and (cont_horiz >= 133 ) and (cont_horiz <= 134)) or
						((cont_verti >= 389-num2) and (cont_verti <= 403-num2 ) and (cont_horiz >= 140 ) and (cont_horiz <= 154)) or
						((cont_verti >= 389-num2) and (cont_verti <= 403-num2 ) and (cont_horiz >= 160 ) and (cont_horiz <= 174)) or
						((cont_verti >= 389-num2) and (cont_verti <= 403-num2 ) and (cont_horiz >= 180 ) and (cont_horiz <= 182)) or
						((cont_verti >= 404-num2) and (cont_verti <= 408-num2 ) and (cont_horiz >= 133 ) and (cont_horiz <= 159)) or
						((cont_verti >= 404-num2) and (cont_verti <= 408-num2 ) and (cont_horiz >= 175 ) and (cont_horiz <= 182)) or
						((cont_verti >= 409-num2) and (cont_verti <= 420-num2 ) and (cont_horiz >= 133 ) and (cont_horiz <= 182))))then
						color <= verde_0;
						end if;
						if((qA = "0111") and (((cont_verti >= 371-num2) and (cont_verti <= 388 -num2) and (cont_horiz >= 133 ) and (cont_horiz <= 182)) or
						((cont_verti >= 389-num2) and (cont_verti <= 403 -num2) and (cont_horiz >= 133 ) and (cont_horiz <= 134)) or
						((cont_verti >= 389-num2) and (cont_verti <= 403 -num2) and (cont_horiz >= 140 ) and (cont_horiz <= 182)) or
						((cont_verti >= 404-num2) and (cont_verti <= 408-num2 ) and (cont_horiz >= 133 ) and (cont_horiz <= 139)) or
						((cont_verti >= 404-num2) and (cont_verti <= 408 -num2) and (cont_horiz >= 155 ) and (cont_horiz <= 159)) or
						((cont_verti >= 404-num2) and (cont_verti <= 408-num2 ) and (cont_horiz >= 175 ) and (cont_horiz <= 182)) or
						((cont_verti >= 409-num2) and (cont_verti <= 420-num2 ) and (cont_horiz >= 133 ) and (cont_horiz <= 182))))then
						color <= verde_0;
						end if;
						if((qA = "1000") and (((cont_verti >= 371-num2) and (cont_verti <= 383-num2 ) and (cont_horiz >= 133 ) and (cont_horiz <= 182)) or
						((cont_verti >= 384-num2) and (cont_verti <= 388-num2 ) and (cont_horiz >= 133 ) and (cont_horiz <= 139)) or
						((cont_verti >= 384-num2) and (cont_verti <= 388-num2 ) and (cont_horiz >= 155 ) and (cont_horiz <= 159)) or
						((cont_verti >= 384-num2) and (cont_verti <= 388-num2 ) and (cont_horiz >= 175 ) and (cont_horiz <= 182)) or
						((cont_verti >= 389-num2) and (cont_verti <= 403-num2 ) and (cont_horiz >= 133 ) and (cont_horiz <= 134)) or
						((cont_verti >= 389-num2) and (cont_verti <= 403-num2 ) and (cont_horiz >= 140 ) and (cont_horiz <= 154)) or
						((cont_verti >= 389-num2) and (cont_verti <= 403-num2 ) and (cont_horiz >= 160 ) and (cont_horiz <= 174)) or
						((cont_verti >= 389-num2) and (cont_verti <= 403-num2 ) and (cont_horiz >= 180 ) and (cont_horiz <= 182)) or
						((cont_verti >= 404-num2) and (cont_verti <= 408-num2 ) and (cont_horiz >= 133 ) and (cont_horiz <= 139)) or
						((cont_verti >= 404-num2) and (cont_verti <= 408-num2 ) and (cont_horiz >= 155 ) and (cont_horiz <= 159)) or
						((cont_verti >= 404-num2) and (cont_verti <= 408-num2 ) and (cont_horiz >= 175 ) and (cont_horiz <= 182)) or
						((cont_verti >= 409-num2) and (cont_verti <= 420-num2 ) and (cont_horiz >= 133 ) and (cont_horiz <= 182))))then
						color <= verde_0;
						end if;
						if((qA = "1001") and (((cont_verti >= 371-num2) and (cont_verti <= 383-num2 ) and (cont_horiz >= 133 ) and (cont_horiz <= 182)) or
						((cont_verti >= 384-num2) and (cont_verti <= 388 -num2) and (cont_horiz >= 133 ) and (cont_horiz <= 139)) or
						((cont_verti >= 384-num2) and (cont_verti <= 388 -num2) and (cont_horiz >= 155 ) and (cont_horiz <= 182)) or
						((cont_verti >= 389-num2) and (cont_verti <= 403 -num2) and (cont_horiz >= 133 ) and (cont_horiz <= 134)) or
						((cont_verti >= 389-num2) and (cont_verti <= 403 -num2) and (cont_horiz >= 140 ) and (cont_horiz <= 154)) or
						((cont_verti >= 389-num2) and (cont_verti <= 403 -num2) and (cont_horiz >= 160 ) and (cont_horiz <= 174)) or
						((cont_verti >= 389-num2) and (cont_verti <= 403 -num2 ) and (cont_horiz >= 180 ) and (cont_horiz <= 182)) or
						((cont_verti >= 404-num2) and (cont_verti <= 408 -num2 ) and (cont_horiz >= 133 ) and (cont_horiz <= 139)) or
						((cont_verti >= 404-num2) and (cont_verti <= 408 -num2 ) and (cont_horiz >= 155 ) and (cont_horiz <= 159)) or
						((cont_verti >= 404-num2) and (cont_verti <= 408 -num2) and (cont_horiz >= 175 ) and (cont_horiz <= 182)) or
						((cont_verti >= 409-num2) and (cont_verti <= 420 -num2) and (cont_horiz >= 133 ) and (cont_horiz <= 182))))then
						color <= verde_0;
						end if;
--------------PEPSI--------------------------



if((qP = "0000") and (((cont_verti >= 371-num2) and (cont_verti <= 383-num2 ) and (cont_horiz >= 188 ) and (cont_horiz <= 237)) or
						((cont_verti >= 384-num2) and (cont_verti <= 388 -num2) and (cont_horiz >= 188 ) and (cont_horiz <= 194)) or
						((cont_verti >= 384-num2) and (cont_verti <= 388-num2 ) and (cont_horiz >= 210 ) and (cont_horiz <= 214)) or
						((cont_verti >= 384-num2) and (cont_verti <= 388-num2 ) and (cont_horiz >= 230 ) and (cont_horiz <= 237)) or
						((cont_verti >= 389-num2) and (cont_verti <= 403 -num2) and (cont_horiz >= 188 ) and (cont_horiz <= 189)) or
						((cont_verti >= 389-num2) and (cont_verti <= 403 -num2) and (cont_horiz >= 195 ) and (cont_horiz <= 229)) or
						((cont_verti >= 389-num2) and (cont_verti <= 403-num2 ) and (cont_horiz >= 235 ) and (cont_horiz <= 237)) or
						((cont_verti >= 404-num2) and (cont_verti <= 408-num2 ) and (cont_horiz >= 188 ) and (cont_horiz <= 194)) or
						((cont_verti >= 404-num2) and (cont_verti <= 408-num2 ) and (cont_horiz >= 210 ) and (cont_horiz <= 214)) or
						((cont_verti >= 404-num2) and (cont_verti <= 408-num2 ) and (cont_horiz >= 230 ) and (cont_horiz <= 237)) or
						((cont_verti >= 409-num2) and (cont_verti <= 420-num2 ) and (cont_horiz >= 188 ) and (cont_horiz <= 237))))then
						color <= azul_0;
						end if;
						if((qP = "0001") and (((cont_verti >= 371-num2) and (cont_verti <= 403-num2 ) and (cont_horiz >= 188 ) and (cont_horiz <= 237)) or
						((cont_verti >= 404-num2) and (cont_verti <= 408-num2 ) and (cont_horiz >= 188 ) and (cont_horiz <= 194)) or
						((cont_verti >= 404-num2) and (cont_verti <= 408-num2 ) and (cont_horiz >= 210 ) and (cont_horiz <= 214)) or
						((cont_verti >= 404-num2) and (cont_verti <= 408-num2 ) and (cont_horiz >= 230 ) and (cont_horiz <= 237)) or
						((cont_verti >= 409-num2) and (cont_verti <= 420-num2 ) and (cont_horiz >= 188 ) and (cont_horiz <= 237))))then
						color <= azul_0;
						end if;
						if((qP = "0010") and (((cont_verti >= 371-num2) and (cont_verti <= 383-num2 ) and (cont_horiz >= 188 ) and (cont_horiz <= 237)) or
						((cont_verti >= 384-num2) and (cont_verti <= 388-num2 ) and (cont_horiz >= 188 ) and (cont_horiz <= 214)) or
						((cont_verti >= 384-num2) and (cont_verti <= 388-num2 ) and (cont_horiz >= 230 ) and (cont_horiz <= 237)) or
						((cont_verti >= 389-num2) and (cont_verti <= 403-num2 ) and (cont_horiz >= 188 ) and (cont_horiz <= 189)) or
						((cont_verti >= 389-num2) and (cont_verti <= 403 -num2) and (cont_horiz >= 195 ) and (cont_horiz <= 209)) or
						((cont_verti >= 389-num2) and (cont_verti <= 403 -num2) and (cont_horiz >= 215 ) and (cont_horiz <= 229)) or
						((cont_verti >= 389-num2) and (cont_verti <= 403-num2 ) and (cont_horiz >= 235 ) and (cont_horiz <= 237)) or
						((cont_verti >= 404-num2) and (cont_verti <= 408-num2 ) and (cont_horiz >= 188 ) and (cont_horiz <= 194)) or
						((cont_verti >= 404-num2) and (cont_verti <= 408-num2 ) and (cont_horiz >= 210 ) and (cont_horiz <= 237)) or
						((cont_verti >= 409-num2) and (cont_verti <= 420 -num2) and (cont_horiz >= 188 ) and (cont_horiz <= 237))))then
						color <= azul_0;
						end if;
						if((qP = "0011") and (((cont_verti >= 371-num2) and (cont_verti <= 388-num2 ) and (cont_horiz >= 188 ) and (cont_horiz <= 237)) or
						((cont_verti >= 389-num2) and (cont_verti <= 403-num2 ) and (cont_horiz >= 188 ) and (cont_horiz <= 189)) or
						((cont_verti >= 389-num2) and (cont_verti <= 403-num2 ) and (cont_horiz >= 195 ) and (cont_horiz <= 209)) or
						((cont_verti >= 389-num2) and (cont_verti <= 403-num2 ) and (cont_horiz >= 215 ) and (cont_horiz <= 229)) or
						((cont_verti >= 389-num2) and (cont_verti <= 403 -num2) and (cont_horiz >= 235 ) and (cont_horiz <= 237)) or
						((cont_verti >= 404-num2) and (cont_verti <= 408-num2 ) and (cont_horiz >= 188 ) and (cont_horiz <= 194)) or
						((cont_verti >= 404-num2) and (cont_verti <= 408-num2 ) and (cont_horiz >= 210 ) and (cont_horiz <= 214)) or
						((cont_verti >= 404-num2) and (cont_verti <= 408-num2 ) and (cont_horiz >= 230 ) and (cont_horiz <= 237)) or
						((cont_verti >= 409-num2) and (cont_verti <= 420 -num2) and (cont_horiz >= 188 ) and (cont_horiz <= 237))))then
						color <= azul_0;
						end if;
						if((qP = "0100") and (((cont_verti >= 371-num2) and (cont_verti <= 383-num2 ) and (cont_horiz >= 188 ) and (cont_horiz <= 237)) or
						((cont_verti >= 384-num2) and (cont_verti <= 388-num2 ) and (cont_horiz >= 188 ) and (cont_horiz <= 194)) or
						((cont_verti >= 384-num2) and (cont_verti <= 388-num2 ) and (cont_horiz >= 210 ) and (cont_horiz <= 214)) or
						((cont_verti >= 384-num2) and (cont_verti <= 388-num2 ) and (cont_horiz >= 230 ) and (cont_horiz <= 237)) or
						((cont_verti >= 389-num2) and (cont_verti <= 403-num2 ) and (cont_horiz >= 188 ) and (cont_horiz <= 209)) or
						((cont_verti >= 389-num2) and (cont_verti <= 403-num2 ) and (cont_horiz >= 215 ) and (cont_horiz <= 237)) or
						((cont_verti >= 404-num2) and (cont_verti <= 408-num2 ) and (cont_horiz >= 188 ) and (cont_horiz <= 194)) or
						((cont_verti >= 404-num2) and (cont_verti <= 408-num2 ) and (cont_horiz >= 210 ) and (cont_horiz <= 214)) or
						((cont_verti >= 404-num2) and (cont_verti <= 408-num2 ) and (cont_horiz >= 230 ) and (cont_horiz <= 237)) or
						((cont_verti >= 409-num2) and (cont_verti <= 420-num2 ) and (cont_horiz >= 188 ) and (cont_horiz <= 237)) or
						((cont_verti >= 384-num2) and (cont_verti <= 388-num2 ) and (cont_horiz >= 215 ) and (cont_horiz <= 237))))then
						color <= azul_0;
						end if;
						if((qP = "0101") and (((cont_verti >= 371-num2) and (cont_verti <= 383-num2 ) and (cont_horiz >= 188 ) and (cont_horiz <= 237)) or
						((cont_verti >= 384-num2) and (cont_verti <= 388 -num2) and (cont_horiz >= 188 ) and (cont_horiz <= 194)) or
						((cont_verti >= 384-num2) and (cont_verti <= 388 -num2) and (cont_horiz >= 210 ) and (cont_horiz <= 237)) or
						((cont_verti >= 389-num2) and (cont_verti <= 403 -num2) and (cont_horiz >= 188 ) and (cont_horiz <= 189)) or
						((cont_verti >= 389-num2) and (cont_verti <= 403 -num2) and (cont_horiz >= 195 ) and (cont_horiz <= 209)) or
						((cont_verti >= 389-num2) and (cont_verti <= 403 -num2) and (cont_horiz >= 215 ) and (cont_horiz <= 229)) or
						((cont_verti >= 389-num2) and (cont_verti <= 403 -num2) and (cont_horiz >= 235 ) and (cont_horiz <= 237)) or
						((cont_verti >= 404-num2) and (cont_verti <= 408 -num2) and (cont_horiz >= 188 ) and (cont_horiz <= 214)) or
						((cont_verti >= 404-num2) and (cont_verti <= 408-num2 ) and (cont_horiz >= 230 ) and (cont_horiz <= 237)) or
						((cont_verti >= 409-num2) and (cont_verti <= 420-num2 ) and (cont_horiz >= 188 ) and (cont_horiz <= 237))))then
						color <= azul_0;
						end if;
						if((qP = "0110") and (((cont_verti >= 371-num2) and (cont_verti <= 383-num2 ) and (cont_horiz >= 188 ) and (cont_horiz <= 237)) or
						((cont_verti >= 384-num2) and (cont_verti <= 388-num2 ) and (cont_horiz >= 188 ) and (cont_horiz <= 194)) or
						((cont_verti >= 384-num2) and (cont_verti <= 388-num2 ) and (cont_horiz >= 210 ) and (cont_horiz <= 214)) or
						((cont_verti >= 384-num2) and (cont_verti <= 388-num2) and (cont_horiz >= 230 ) and (cont_horiz <= 237)) or
						((cont_verti >= 389-num2) and (cont_verti <= 403-num2) and (cont_horiz >= 188 ) and (cont_horiz <= 189)) or
						((cont_verti >= 389-num2) and (cont_verti <= 403-num2 ) and (cont_horiz >= 195 ) and (cont_horiz <= 209)) or
						((cont_verti >= 389-num2) and (cont_verti <= 403-num2 ) and (cont_horiz >= 215 ) and (cont_horiz <= 229)) or
						((cont_verti >= 389-num2) and (cont_verti <= 403-num2 ) and (cont_horiz >= 235 ) and (cont_horiz <= 237)) or
						((cont_verti >= 404-num2) and (cont_verti <= 408-num2 ) and (cont_horiz >= 188 ) and (cont_horiz <= 214)) or
						((cont_verti >= 404-num2) and (cont_verti <= 408-num2 ) and (cont_horiz >= 230 ) and (cont_horiz <= 237)) or
						((cont_verti >= 409-num2) and (cont_verti <= 420-num2 ) and (cont_horiz >= 188 ) and (cont_horiz <= 237))))then
						color <= azul_0;
						end if;
						if((qP = "0111") and (((cont_verti >= 371-num2) and (cont_verti <= 388-num2 ) and (cont_horiz >= 188 ) and (cont_horiz <= 237)) or
						((cont_verti >= 389-num2) and (cont_verti <= 403 -num2) and (cont_horiz >= 188 ) and (cont_horiz <= 189)) or
						((cont_verti >= 389-num2) and (cont_verti <= 403 -num2) and (cont_horiz >= 195 ) and (cont_horiz <= 237)) or
						((cont_verti >= 404-num2) and (cont_verti <= 408 -num2) and (cont_horiz >= 188 ) and (cont_horiz <= 194)) or
						((cont_verti >= 404-num2) and (cont_verti <= 408 -num2) and (cont_horiz >= 210 ) and (cont_horiz <= 214)) or
						((cont_verti >= 404-num2) and (cont_verti <= 408 -num2) and (cont_horiz >= 230 ) and (cont_horiz <= 237)) or
						((cont_verti >= 409-num2) and (cont_verti <= 420 -num2) and (cont_horiz >= 188 ) and (cont_horiz <= 237))))then
						color <= azul_0;
						end if;
						if((qP = "1000") and (((cont_verti >= 371-num2) and (cont_verti <= 383 -num2) and (cont_horiz >= 188 ) and (cont_horiz <= 237)) or
						((cont_verti >= 384-num2) and (cont_verti <= 388-num2 ) and (cont_horiz >= 188 ) and (cont_horiz <= 194)) or
						((cont_verti >= 384-num2) and (cont_verti <= 388 -num2) and (cont_horiz >= 210 ) and (cont_horiz <= 214)) or
						((cont_verti >= 384-num2) and (cont_verti <= 388 -num2) and (cont_horiz >= 230 ) and (cont_horiz <= 237)) or
						((cont_verti >= 389-num2) and (cont_verti <= 403-num2) and (cont_horiz >= 188 ) and (cont_horiz <= 189)) or
						((cont_verti >= 389-num2) and (cont_verti <= 403 -num2) and (cont_horiz >= 195 ) and (cont_horiz <= 209)) or
						((cont_verti >= 389-num2) and (cont_verti <= 403-num2 ) and (cont_horiz >= 215 ) and (cont_horiz <= 229)) or
						((cont_verti >= 389-num2) and (cont_verti <= 403-num2 ) and (cont_horiz >= 235 ) and (cont_horiz <= 237)) or
						((cont_verti >= 404-num2) and (cont_verti <= 408-num2 ) and (cont_horiz >= 188 ) and (cont_horiz <= 194)) or
						((cont_verti >= 404-num2) and (cont_verti <= 408-num2 ) and (cont_horiz >= 210 ) and (cont_horiz <= 214)) or
						((cont_verti >= 404-num2) and (cont_verti <= 408 -num2) and (cont_horiz >= 230 ) and (cont_horiz <= 237)) or
						((cont_verti >= 409-num2) and (cont_verti <= 420-num2 ) and (cont_horiz >= 188 ) and (cont_horiz <= 237))))then
						color <= azul_0;
						end if;
						if((qP = "1001") and (((cont_verti >= 371-num2) and (cont_verti <= 383 -num2) and (cont_horiz >= 188 ) and (cont_horiz <= 237)) or
						((cont_verti >= 384-num2) and (cont_verti <= 388-num2 ) and (cont_horiz >= 188 ) and (cont_horiz <= 194)) or
						((cont_verti >= 384-num2) and (cont_verti <= 388-num2 ) and (cont_horiz >= 210 ) and (cont_horiz <= 237)) or
						((cont_verti >= 389-num2) and (cont_verti <= 403-num2 ) and (cont_horiz >= 188 ) and (cont_horiz <= 189)) or
						((cont_verti >= 389-num2) and (cont_verti <= 403 -num2) and (cont_horiz >= 195 ) and (cont_horiz <= 209)) or
						((cont_verti >= 389-num2) and (cont_verti <= 403 -num2) and (cont_horiz >= 215 ) and (cont_horiz <= 229)) or
						((cont_verti >= 389-num2) and (cont_verti <= 403 -num2) and (cont_horiz >= 235 ) and (cont_horiz <= 237)) or
						((cont_verti >= 404-num2) and (cont_verti <= 408 -num2) and (cont_horiz >= 188 ) and (cont_horiz <= 194)) or
						((cont_verti >= 404-num2) and (cont_verti <= 408 -num2) and (cont_horiz >= 210 ) and (cont_horiz <= 214)) or
						((cont_verti >= 404-num2) and (cont_verti <= 408-num2 ) and (cont_horiz >= 230 ) and (cont_horiz <= 237)) or
						((cont_verti >= 409-num2) and (cont_verti <= 420 -num2) and (cont_horiz >= 188 ) and (cont_horiz <= 237))))then
						color <= azul_0;
						end if;

-------------COCACOLA-------------------

if((qc = "0000") and (((cont_verti >= 371-num2) and (cont_verti <= 383-num2) and (cont_horiz >= 243 ) and (cont_horiz <= 292)) or
						((cont_verti >= 384-num2) and (cont_verti <= 388-num2) and (cont_horiz >= 243 ) and (cont_horiz <= 249)) or
						((cont_verti >= 384-num2) and (cont_verti <= 388-num2 ) and (cont_horiz >= 265 ) and (cont_horiz <= 269)) or
						((cont_verti >= 384-num2) and (cont_verti <= 388 -num2) and (cont_horiz >= 285 ) and (cont_horiz <= 292)) or
						((cont_verti >= 389-num2) and (cont_verti <= 403 -num2) and (cont_horiz >= 243 ) and (cont_horiz <= 244)) or
						((cont_verti >= 389-num2) and (cont_verti <= 403 -num2) and (cont_horiz >= 250 ) and (cont_horiz <= 284)) or
						((cont_verti >= 389-num2) and (cont_verti <= 403 -num2) and (cont_horiz >= 290 ) and (cont_horiz <= 292)) or
						((cont_verti >= 404-num2) and (cont_verti <= 408-num2 ) and (cont_horiz >= 243 ) and (cont_horiz <= 249)) or
						((cont_verti >= 404-num2) and (cont_verti <= 408-num2 ) and (cont_horiz >= 265 ) and (cont_horiz <= 269)) or
						((cont_verti >= 404-num2) and (cont_verti <= 408-num2 ) and (cont_horiz >= 285 ) and (cont_horiz <= 292)) or
						((cont_verti >= 409-num2) and (cont_verti <= 420 -num2) and (cont_horiz >= 243 ) and (cont_horiz <= 292))))then
						color <= rojo_0 ;
						end if;
						if((qc = "0001") and (((cont_verti >= 371-num2) and (cont_verti <= 403-num2 ) and (cont_horiz >= 243 ) and (cont_horiz <= 292)) or
						((cont_verti >= 404-num2) and (cont_verti <= 408-num2 ) and (cont_horiz >= 243 ) and (cont_horiz <= 249)) or
						((cont_verti >= 404-num2) and (cont_verti <= 408-num2 ) and (cont_horiz >= 265 ) and (cont_horiz <= 269)) or
						((cont_verti >= 404-num2) and (cont_verti <= 408 -num2) and (cont_horiz >= 285 ) and (cont_horiz <= 292)) or
						((cont_verti >= 409-num2) and (cont_verti <= 420-num2 ) and (cont_horiz >= 243 ) and (cont_horiz <= 292))))then
						color <= rojo_0 ;
						end if;
						if((qc = "0010") and (((cont_verti >= 371-num2) and (cont_verti <= 383 -num2) and (cont_horiz >= 243 ) and (cont_horiz <= 292)) or
						((cont_verti >= 384-num2) and (cont_verti <= 388-num2 ) and (cont_horiz >= 243 ) and (cont_horiz <= 269)) or
						((cont_verti >= 384-num2) and (cont_verti <= 388-num2 ) and (cont_horiz >= 285 ) and (cont_horiz <= 292)) or
						((cont_verti >= 389-num2) and (cont_verti <= 403-num2 ) and (cont_horiz >= 243 ) and (cont_horiz <= 244)) or
						((cont_verti >= 389-num2) and (cont_verti <= 403-num2 ) and (cont_horiz >= 250 ) and (cont_horiz <= 264)) or
						((cont_verti >= 389-num2) and (cont_verti <= 403-num2 ) and (cont_horiz >= 270 ) and (cont_horiz <= 284)) or
						((cont_verti >= 389-num2) and (cont_verti <= 403-num2 ) and (cont_horiz >= 290 ) and (cont_horiz <= 292)) or
						((cont_verti >= 404-num2) and (cont_verti <= 408-num2 ) and (cont_horiz >= 243 ) and (cont_horiz <= 249)) or
						((cont_verti >= 404-num2) and (cont_verti <= 408-num2 ) and (cont_horiz >= 265 ) and (cont_horiz <= 292)) or
						((cont_verti >= 409-num2) and (cont_verti <= 420-num2 ) and (cont_horiz >= 243 ) and (cont_horiz <= 292))))then
						color <= rojo_0 ;
						end if;
						if((qc = "0011") and (((cont_verti >= 371-num2) and (cont_verti <= 388-num2 ) and (cont_horiz >= 243 ) and (cont_horiz <= 292)) or
						((cont_verti >= 389-num2) and (cont_verti <= 403-num2 ) and (cont_horiz >= 243 ) and (cont_horiz <= 244)) or
						((cont_verti >= 389-num2) and (cont_verti <= 403-num2 ) and (cont_horiz >= 250 ) and (cont_horiz <= 264)) or
						((cont_verti >= 389-num2) and (cont_verti <= 403-num2 ) and (cont_horiz >= 270 ) and (cont_horiz <= 284)) or
						((cont_verti >= 389-num2) and (cont_verti <= 403-num2 ) and (cont_horiz >= 290 ) and (cont_horiz <= 292)) or
						((cont_verti >= 404-num2) and (cont_verti <= 408-num2 ) and (cont_horiz >= 243 ) and (cont_horiz <= 249)) or
						((cont_verti >= 404-num2) and (cont_verti <= 408 -num2) and (cont_horiz >= 265 ) and (cont_horiz <= 269)) or
						((cont_verti >= 404-num2) and (cont_verti <= 408 -num2) and (cont_horiz >= 285 ) and (cont_horiz <= 292)) or
						((cont_verti >= 409-num2) and (cont_verti <= 420-num2 ) and (cont_horiz >= 243 ) and (cont_horiz <= 292))))then
						color <= rojo_0 ;
						end if;
						if((qc = "0100") and (((cont_verti >= 371-num2) and (cont_verti <= 383 -num2) and (cont_horiz >= 243 ) and (cont_horiz <= 292)) or
						((cont_verti >= 384-num2) and (cont_verti <= 388-num2 ) and (cont_horiz >= 243 ) and (cont_horiz <= 249)) or
						((cont_verti >= 384-num2) and (cont_verti <= 388-num2 ) and (cont_horiz >= 265 ) and (cont_horiz <= 269)) or
						((cont_verti >= 384-num2) and (cont_verti <= 388-num2 ) and (cont_horiz >= 285 ) and (cont_horiz <= 292)) or
						((cont_verti >= 389-num2) and (cont_verti <= 403-num2 ) and (cont_horiz >= 243 ) and (cont_horiz <= 264)) or
						((cont_verti >= 389-num2) and (cont_verti <= 403-num2 ) and (cont_horiz >= 270 ) and (cont_horiz <= 292)) or
						((cont_verti >= 404-num2) and (cont_verti <= 408-num2 ) and (cont_horiz >= 243 ) and (cont_horiz <= 249)) or
						((cont_verti >= 404-num2) and (cont_verti <= 408-num2 ) and (cont_horiz >= 265 ) and (cont_horiz <= 269)) or
						((cont_verti >= 404-num2) and (cont_verti <= 408-num2 ) and (cont_horiz >= 285 ) and (cont_horiz <= 292)) or
						((cont_verti >= 409-num2) and (cont_verti <= 420-num2 ) and (cont_horiz >= 243 ) and (cont_horiz <= 292)) or
						((cont_verti >= 384-num2) and (cont_verti <= 388-num2 ) and (cont_horiz >= 270 ) and (cont_horiz <= 292))))then
						color <= rojo_0 ;
						end if;
						if((qc = "0101") and (((cont_verti >= 371-num2) and (cont_verti <= 383-num2 ) and (cont_horiz >= 243 ) and (cont_horiz <= 292)) or
						((cont_verti >= 384-num2) and (cont_verti <= 388 -num2) and (cont_horiz >= 243 ) and (cont_horiz <= 249)) or
						((cont_verti >= 384-num2) and (cont_verti <= 388-num2 ) and (cont_horiz >= 265 ) and (cont_horiz <= 292)) or
						((cont_verti >= 389-num2) and (cont_verti <= 403-num2 ) and (cont_horiz >= 243 ) and (cont_horiz <= 244)) or
						((cont_verti >= 389-num2) and (cont_verti <= 403-num2 ) and (cont_horiz >= 250 ) and (cont_horiz <= 264)) or
						((cont_verti >= 389-num2) and (cont_verti <= 403 -num2) and (cont_horiz >= 270 ) and (cont_horiz <= 284)) or
						((cont_verti >= 389-num2) and (cont_verti <= 403 -num2) and (cont_horiz >= 290 ) and (cont_horiz <= 292)) or
						((cont_verti >= 404-num2) and (cont_verti <= 408-num2 ) and (cont_horiz >= 243 ) and (cont_horiz <= 269)) or
						((cont_verti >= 404-num2) and (cont_verti <= 408-num2 ) and (cont_horiz >= 285 ) and (cont_horiz <= 292)) or
						((cont_verti >= 409-num2) and (cont_verti <= 420 -num2) and (cont_horiz >= 243 ) and (cont_horiz <= 292))))then
						color <= rojo_0 ;
						end if;
						if((qc = "0110") and (((cont_verti >= 371-num2) and (cont_verti <= 383-num2 ) and (cont_horiz >= 243 ) and (cont_horiz <= 292)) or
						((cont_verti >= 384-num2) and (cont_verti <= 388-num2 ) and (cont_horiz >= 243 ) and (cont_horiz <= 249)) or
						((cont_verti >= 384-num2) and (cont_verti <= 388-num2 ) and (cont_horiz >= 265 ) and (cont_horiz <= 269)) or
						((cont_verti >= 384-num2) and (cont_verti <= 388-num2) and (cont_horiz >= 285 ) and (cont_horiz <= 292)) or
						((cont_verti >= 389-num2) and (cont_verti <= 403-num2 ) and (cont_horiz >= 243 ) and (cont_horiz <= 244)) or
						((cont_verti >= 389-num2) and (cont_verti <= 403-num2 ) and (cont_horiz >= 250 ) and (cont_horiz <= 264)) or
						((cont_verti >= 389-num2) and (cont_verti <= 403-num2) and (cont_horiz >= 270 ) and (cont_horiz <= 284)) or
						((cont_verti >= 389-num2) and (cont_verti <= 403-num2) and (cont_horiz >= 290 ) and (cont_horiz <= 292)) or
						((cont_verti >= 404-num2) and (cont_verti <= 408-num2 ) and (cont_horiz >= 243 ) and (cont_horiz <= 269)) or
						((cont_verti >= 404-num2) and (cont_verti <= 408-num2 ) and (cont_horiz >= 285 ) and (cont_horiz <= 292)) or
						((cont_verti >= 409-num2) and (cont_verti <= 420-num2 ) and (cont_horiz >= 243 ) and (cont_horiz <= 292))))then
						color <= rojo_0 ;
						end if;
						if((qc = "0111") and (((cont_verti >= 371-num2) and (cont_verti <= 388 -num2) and (cont_horiz >= 243 ) and (cont_horiz <= 292)) or
						((cont_verti >= 389-num2) and (cont_verti <= 403-num2 ) and (cont_horiz >= 243 ) and (cont_horiz <= 244)) or
						((cont_verti >= 389-num2) and (cont_verti <= 403-num2 ) and (cont_horiz >= 250 ) and (cont_horiz <= 292)) or
						((cont_verti >= 404-num2) and (cont_verti <= 408-num2 ) and (cont_horiz >= 243 ) and (cont_horiz <= 249)) or
						((cont_verti >= 404-num2) and (cont_verti <= 408-num2 ) and (cont_horiz >= 265 ) and (cont_horiz <= 269)) or
						((cont_verti >= 404-num2) and (cont_verti <= 408-num2 ) and (cont_horiz >= 285 ) and (cont_horiz <= 292)) or
						((cont_verti >= 409-num2) and (cont_verti <= 420-num2 ) and (cont_horiz >= 243 ) and (cont_horiz <= 292))))then
						color <= rojo_0 ;
						end if;
						if((qc = "1000") and (((cont_verti >= 371-num2) and (cont_verti <= 383-num2 ) and (cont_horiz >= 243 ) and (cont_horiz <= 292)) or
						((cont_verti >= 384-num2) and (cont_verti <= 388-num2 ) and (cont_horiz >= 243 ) and (cont_horiz <= 249)) or
						((cont_verti >= 384-num2) and (cont_verti <= 388-num2 ) and (cont_horiz >= 265 ) and (cont_horiz <= 269)) or
						((cont_verti >= 384-num2) and (cont_verti <= 388-num2 ) and (cont_horiz >= 285 ) and (cont_horiz <= 292)) or
						((cont_verti >= 389-num2) and (cont_verti <= 403-num2 ) and (cont_horiz >= 243 ) and (cont_horiz <= 244)) or
						((cont_verti >= 389-num2) and (cont_verti <= 403-num2 ) and (cont_horiz >= 250 ) and (cont_horiz <= 264)) or
						((cont_verti >= 389-num2) and (cont_verti <= 403-num2 ) and (cont_horiz >= 270 ) and (cont_horiz <= 284)) or
						((cont_verti >= 389-num2) and (cont_verti <= 403-num2 ) and (cont_horiz >= 290 ) and (cont_horiz <= 292)) or
						((cont_verti >= 404-num2) and (cont_verti <= 408-num2 ) and (cont_horiz >= 243 ) and (cont_horiz <= 249)) or
						((cont_verti >= 404-num2) and (cont_verti <= 408-num2 ) and (cont_horiz >= 265 ) and (cont_horiz <= 269)) or
						((cont_verti >= 404-num2) and (cont_verti <= 408-num2 ) and (cont_horiz >= 285 ) and (cont_horiz <= 292)) or
						((cont_verti >= 409-num2) and (cont_verti <= 420-num2 ) and (cont_horiz >= 243 ) and (cont_horiz <= 292))))then
						color <= rojo_0 ;
						end if;
						if((qc = "1001") and (((cont_verti >= 371-num2) and (cont_verti <= 383-num2 ) and (cont_horiz >= 243 ) and (cont_horiz <= 292)) or
						((cont_verti >= 384-num2) and (cont_verti <= 388-num2 ) and (cont_horiz >= 243 ) and (cont_horiz <= 249)) or
						((cont_verti >= 384-num2) and (cont_verti <= 388-num2 ) and (cont_horiz >= 265 ) and (cont_horiz <= 292)) or
						((cont_verti >= 389-num2) and (cont_verti <= 403-num2 ) and (cont_horiz >= 243 ) and (cont_horiz <= 244)) or
						((cont_verti >= 389-num2) and (cont_verti <= 403-num2 ) and (cont_horiz >= 250 ) and (cont_horiz <= 264)) or
						((cont_verti >= 389-num2) and (cont_verti <= 403-num2 ) and (cont_horiz >= 270 ) and (cont_horiz <= 284)) or
						((cont_verti >= 389-num2) and (cont_verti <= 403-num2 ) and (cont_horiz >= 290 ) and (cont_horiz <= 292)) or
						((cont_verti >= 404-num2) and (cont_verti <= 408-num2 ) and (cont_horiz >= 243 ) and (cont_horiz <= 249)) or
						((cont_verti >= 404-num2) and (cont_verti <= 408-num2 ) and (cont_horiz >= 265 ) and (cont_horiz <= 269)) or
						((cont_verti >= 404-num2) and (cont_verti <= 408-num2 ) and (cont_horiz >= 285 ) and (cont_horiz <= 292)) or
						((cont_verti >= 409-num2) and (cont_verti <= 420-num2 ) and (cont_horiz >= 243 ) and (cont_horiz <= 292))))then
						color <= rojo_0 ;
						end if;




----------TERMINO DE CANTIDAD DE PRODUCTOS----------------	
		
		
-------------PRECIO DE CADA PRODUCTO-----------------		

if((producto = x"A") and(((cont_verti >= 371) and (cont_verti <= 403 ) and (cont_horiz >= 133 ) and (cont_horiz <= 182)) or
								((cont_verti >= 404) and (cont_verti <= 408 ) and (cont_horiz >= 133 ) and (cont_horiz <= 139)) or
								((cont_verti >= 404) and (cont_verti <= 408 ) and (cont_horiz >= 155 ) and (cont_horiz <= 159)) or
								((cont_verti >= 404) and (cont_verti <= 408 ) and (cont_horiz >= 175 ) and (cont_horiz <= 182)) or
								((cont_verti >= 409) and (cont_verti <= 420 ) and (cont_horiz >= 133 ) and (cont_horiz <= 182)) or
								((cont_verti >= 371+num) and (cont_verti <= 383 +num) and (cont_horiz >= 133 ) and (cont_horiz <= 182)) or
								((cont_verti >= 384+num) and (cont_verti <= 388 +num) and (cont_horiz >= 133 ) and (cont_horiz <= 139)) or
								((cont_verti >= 384+num) and (cont_verti <= 388 +num) and (cont_horiz >= 155 ) and (cont_horiz <= 182)) or
								((cont_verti >= 389+num) and (cont_verti <= 403 +num) and (cont_horiz >= 133 ) and (cont_horiz <= 134)) or
								((cont_verti >= 389+num) and (cont_verti <= 403 +num) and (cont_horiz >= 140 ) and (cont_horiz <= 154)) or
								((cont_verti >= 389+num) and (cont_verti <= 403 +num) and (cont_horiz >= 160 ) and (cont_horiz <= 174)) or
								((cont_verti >= 389+num) and (cont_verti <= 403 +num) and (cont_horiz >= 180 ) and (cont_horiz <= 182)) or
								((cont_verti >= 404+num) and (cont_verti <= 408 +num) and (cont_horiz >= 133 ) and (cont_horiz <= 159)) or
								((cont_verti >= 404+num) and (cont_verti <= 408 +num) and (cont_horiz >= 175 ) and (cont_horiz <= 182)) or
								((cont_verti >= 409+num) and (cont_verti <= 420 +num) and (cont_horiz >= 133 ) and (cont_horiz <= 182)))) then
								color<= verde_0;
elsif( (not(producto= x"A"))and((cont_verti >= 371) and (cont_verti <= 470 ) and (cont_horiz >= 133 ) and (cont_horiz <= 182))  )then 
color <= verde_0;

end if;

if((producto = x"B")and(((cont_verti >= 371) and (cont_verti <= 383 ) and (cont_horiz >= 188 ) and (cont_horiz <= 237)) or
						((cont_verti >= 384) and (cont_verti <= 388 ) and (cont_horiz >= 188 ) and (cont_horiz <= 214)) or
						((cont_verti >= 384) and (cont_verti <= 388 ) and (cont_horiz >= 230 ) and (cont_horiz <= 237)) or
						((cont_verti >= 389) and (cont_verti <= 403 ) and (cont_horiz >= 188 ) and (cont_horiz <= 189)) or
						((cont_verti >= 389) and (cont_verti <= 403 ) and (cont_horiz >= 195 ) and (cont_horiz <= 209)) or
						((cont_verti >= 389) and (cont_verti <= 403 ) and (cont_horiz >= 215 ) and (cont_horiz <= 229)) or
						((cont_verti >= 389) and (cont_verti <= 403 ) and (cont_horiz >= 235 ) and (cont_horiz <= 237)) or
						((cont_verti >= 404) and (cont_verti <= 408 ) and (cont_horiz >= 188 ) and (cont_horiz <= 194)) or
						((cont_verti >= 404) and (cont_verti <= 408 ) and (cont_horiz >= 210 ) and (cont_horiz <= 237)) or
						((cont_verti >= 409) and (cont_verti <= 420 ) and (cont_horiz >= 188 ) and (cont_horiz <= 237)) or
						((cont_verti >= 371+num) and (cont_verti <= 383+num ) and (cont_horiz >= 188 ) and (cont_horiz <= 237)) or
						((cont_verti >= 384+num) and (cont_verti <= 388+num ) and (cont_horiz >= 188 ) and (cont_horiz <= 194)) or
						((cont_verti >= 384+num) and (cont_verti <= 388+num ) and (cont_horiz >= 210 ) and (cont_horiz <= 214)) or
						((cont_verti >= 384+num) and (cont_verti <= 388+num ) and (cont_horiz >= 230 ) and (cont_horiz <= 237)) or
						((cont_verti >= 389+num) and (cont_verti <= 403+num ) and (cont_horiz >= 188 ) and (cont_horiz <= 189)) or
						((cont_verti >= 389+num) and (cont_verti <= 403+num ) and (cont_horiz >= 195 ) and (cont_horiz <= 229)) or
						((cont_verti >= 389+num) and (cont_verti <= 403+num ) and (cont_horiz >= 235 ) and (cont_horiz <= 237)) or
						((cont_verti >= 404+num) and (cont_verti <= 408+num ) and (cont_horiz >= 188 ) and (cont_horiz <= 194)) or
						((cont_verti >= 404+num) and (cont_verti <= 408+num ) and (cont_horiz >= 210 ) and (cont_horiz <= 214)) or
						((cont_verti >= 404+num) and (cont_verti <= 408+num ) and (cont_horiz >= 230 ) and (cont_horiz <= 237)) or
						((cont_verti >= 409+num) and (cont_verti <= 420+num ) and (cont_horiz >= 188 ) and (cont_horiz <= 237)))) then 
								color <= azul_0;
															
elsif((not(producto= x"B"))and((cont_verti >= 371) and (cont_verti <= 470 ) and (cont_horiz >= 188) and (cont_horiz <= 237)))then 
color <= azul_0;
end if;

if(((producto = x"C")and((cont_verti >= 371) and (cont_verti <= 383 ) and (cont_horiz >= 243 ) and (cont_horiz <= 292))) or
						((cont_verti >= 384) and (cont_verti <= 388 ) and (cont_horiz >= 243 ) and (cont_horiz <= 269)) or
						((cont_verti >= 384) and (cont_verti <= 388 ) and (cont_horiz >= 285 ) and (cont_horiz <= 292)) or
						((cont_verti >= 389) and (cont_verti <= 403 ) and (cont_horiz >= 243 ) and (cont_horiz <= 244)) or
						((cont_verti >= 389) and (cont_verti <= 403 ) and (cont_horiz >= 250 ) and (cont_horiz <= 264)) or
						((cont_verti >= 389) and (cont_verti <= 403 ) and (cont_horiz >= 270 ) and (cont_horiz <= 284)) or
						((cont_verti >= 389) and (cont_verti <= 403 ) and (cont_horiz >= 290 ) and (cont_horiz <= 292)) or
						((cont_verti >= 404) and (cont_verti <= 408 ) and (cont_horiz >= 243 ) and (cont_horiz <= 249)) or
						((cont_verti >= 404) and (cont_verti <= 408 ) and (cont_horiz >= 265 ) and (cont_horiz <= 292)) or
						((cont_verti >= 409) and (cont_verti <= 420 ) and (cont_horiz >= 243 ) and (cont_horiz <= 292)) or
						((cont_verti >= 371+num) and (cont_verti <= 383+num ) and (cont_horiz >= 243 ) and (cont_horiz <= 292)) or
						((cont_verti >= 384+num) and (cont_verti <= 388 +num) and (cont_horiz >= 243 ) and (cont_horiz <= 249)) or
						((cont_verti >= 384+num) and (cont_verti <= 388+num ) and (cont_horiz >= 265 ) and (cont_horiz <= 292)) or
						((cont_verti >= 389+num) and (cont_verti <= 403+num ) and (cont_horiz >= 243 ) and (cont_horiz <= 244)) or
						((cont_verti >= 389+num) and (cont_verti <= 403+num ) and (cont_horiz >= 250 ) and (cont_horiz <= 264)) or
						((cont_verti >= 389+num) and (cont_verti <= 403+num ) and (cont_horiz >= 270 ) and (cont_horiz <= 284)) or
						((cont_verti >= 389+num) and (cont_verti <= 403+num ) and (cont_horiz >= 290 ) and (cont_horiz <= 292)) or
						((cont_verti >= 404+num) and (cont_verti <= 408+num ) and (cont_horiz >= 243 ) and (cont_horiz <= 269)) or
						((cont_verti >= 404+num) and (cont_verti <= 408+num ) and (cont_horiz >= 285 ) and (cont_horiz <= 292)) or
						((cont_verti >= 409+num) and (cont_verti <= 420+num ) and (cont_horiz >= 243 ) and (cont_horiz <= 292))) then
					color<=rojo_0;
elsif((not(producto= x"C"))and((cont_verti >= 371) and (cont_verti <= 470 ) and (cont_horiz >= 243 ) and (cont_horiz <= 292))) then 
color<= rojo_0;
end if;	




--
---------------FIN DE PROECIO DE CADA PRODUCTO-------------

		if ((cont_verti >= 162) and (cont_verti <= 470 ) and (cont_horiz >= 298 ) and (cont_horiz <= 347 )) then
				---gris---
				if (entrega = '1')then
						color <= gris_0;
				--amarillo---		
				else
						color <= amarillo_0;
				end if;
		end if;
	if (((cont_verti >= 176) and (cont_verti <= 180 ) and (cont_horiz >= 460 ) and (cont_horiz <= 464 )) or 
	   ((cont_verti >= 176+num6) and (cont_verti <= 180+num6 ) and (cont_horiz >= 460 ) and (cont_horiz <= 464 ))or 
		((cont_verti >= 421) and (cont_verti <= 425) and (cont_horiz >= 178 ) and (cont_horiz <= 182 ))or 
		((cont_verti >= 421) and (cont_verti <= 425) and (cont_horiz >= 232 ) and (cont_horiz <= 236 ))or 
		((cont_verti >= 421) and (cont_verti <= 425) and (cont_horiz >= 288 ) and (cont_horiz <= 292 )))then
		color <= blanco_0;
		end if;
	
	
	end process A2;
	 
with color select 
	
salida_color_1 <=  verde           	 when verde_0,
					    azul         	    when azul_0,
					    rojo   				 when rojo_0,
					    gris     			 when gris_0,
					    amarillo      	 when amarillo_0,
					    blanco   			 when blanco_0,
					    cian   			    when cian_0,
					    negro     			 when negro_0,
					  "------------"      when others;
---SALIDAS VGA_R,VGA_G,VGA_B 

salida_color_2 <= salida_color_1 when (VGA_blank = '1') else
						negro;

VGA_R <= salida_color_2(11 downto 8);
VGA_G <= salida_color_2(7 downto 4);
VGA_B <= salida_color_2(3 downto 0);

end circuit;