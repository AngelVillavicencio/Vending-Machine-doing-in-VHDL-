library ieee;
use ieee.std_logic_1164.all;
use work.my_circuitsdelinput_eval.all;
use ieee.numeric_std.all;

entity input_eval is
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
end input_eval;
architecture behav of input_eval is
		signal en			:	std_logic;
		signal fs_valido	:	std_logic;
		signal q_0			:	std_logic;
		signal valor_reg	:	std_logic_vector(3 downto 0);
		signal eq_A			:	std_logic;
		signal eq_B			:	std_logic;
		signal eq_C			:	std_logic;
		signal eq_return	:	std_logic;
		signal eq_prod		:	std_logic;
		
	   signal eq_money	:	std_logic;
		
		signal enable_eq_1:  std_logic;
		signal enable_eq_2:  std_logic;
		signal enable_eq_3:  std_logic;
		signal enable_eq_4:  std_logic;

		signal eq_1			:	std_logic;
		signal eq_2			:	std_logic;
		signal eq_3			:	std_logic;
		signal eq_4			:	std_logic;
		
		
		signal mux1			:	std_logic_vector(7 downto 0);
		signal mux2			:	std_logic_vector(7 downto 0);
		signal mux3			:	std_logic_vector(7 downto 0);
		signal mux4			:	std_logic_vector(7 downto 0);
		
		
		signal reset_money_cant : std_logic;
		
		
		
		
		signal Y				:	std_logic_vector(7 downto 0);
		signal mux5			:	std_logic_vector(7 downto 0);
		signal q_1			:	std_logic_vector(7 downto 0);
		signal k				:	std_logic_vector(11 downto 0);
		signal vga_vuelto :  std_logic_vector(11 downto 0);
		signal valu			:  std_logic_vector(3 downto 0);
		signal enable		:	std_logic;
		
		
		signal num_dis_valu : std_logic_vector( 6 downto 0);
		
		
		
		signal enable_reset_cantidad : std_logic;
		
		
		signal en_a			:	std_logic;
		signal en_p			:	std_logic;
		signal en_c			:	std_logic;
		
		signal SgeVA		:	std_logic;
		signal SgeVB		:	std_logic;
		signal SgeVC		:	std_logic;
		signal return_money: std_logic;
		signal rstn_en		:  std_logic;

		
		signal enable_decount_a : std_logic;
	   signal enable_decount_p : std_logic;
		signal enable_decount_c : std_logic;
		
		
		signal fsubida		:  std_logic;
		signal cuenta		:  std_logic_vector(7 downto 0);
		signal stop			:  std_logic;
		signal entreg_int :  std_logic;
		signal entreg_temp:  std_logic;
		signal reset_sum  : std_logic;
		------------señales nuevas para la maquina de estados	
	   signal en_tecla_vga_prod : std_logic;
	   signal sel_money, en_money , reset_money ,en_vuelto:std_logic;
		signal vuelto         :  std_logic_vector(7 downto 0);
		signal sel_vuelto     :  std_logic_vector(1 downto 0);
--		signal req			:  std_logic;
--		signal ack			:  std_logic;
--		signal rstn_sync	:	std_logic;			
	signal enable_vuelto : std_logic;				
	signal enable_registro_saldo : std_logic;
	signal enable_contador_monedas : std_logic;
	----signal enable_tipo_producto :std_logic;
		signal en_reg     : std_logic;
begin
	
	
	D_uni_p <= '0';
	D_uni_cent <= "1000000";
	fs_valido <= not(q_0) and valido;
	
	I0  : divisor500mil port map (clk => clock_50, reset => reset_n, clk_o => en);
	
	I1  : ffd		  port map (en => en, reset => reset_n, clk => clock_50, d => valido, q => q_0);
	
	I2  : registro4  port map (en => en, reset => reset_n, clk => clock_50, d => valor, q => valor_reg);
	
	I3  : comparador port map (a => valor_reg, b => x"A", f => eq_A);
	I4  : comparador port map (a => valor_reg, b => x"B", f => eq_B);
	I5  : comparador port map (a => valor_reg, b => x"C", f => eq_C);
	I6  : comparador port map (a => valor_reg, b => x"D", f => eq_return);
	eq_prod  <= eq_A or eq_B or eq_C;
	
	I7  : comparador port map (a => valor_reg, b => x"1", f => eq_1);
	I8  : comparador port map (a => valor_reg, b => x"2", f => eq_2);
	I9  : comparador port map (a => valor_reg, b => x"3", f => eq_3);
	I10 : comparador port map (a => valor_reg, b => x"4", f => eq_4);
	eq_money <= eq_1 or eq_2 or eq_3 or eq_4;
	
	
	
	
	
	
	IMAQ : maquina_de_estado port map( reset_n=>reset_n, clock_50=>clock_50,en=>en, eq_A=>eq_A,
	eq_B=>eq_B,eq_C=>eq_C, eq_return=> eq_return ,eq_prod=>eq_prod,eq_1=> eq_1 
	,eq_2=>eq_2,eq_3=>eq_3, eq_4=>eq_4,eq_money=>eq_money,
	valu=>valu,
	SgeVA=>SgeVA,SgeVB=>SgeVB,			 reset_money_cant  => reset_money_cant,	  

	SgeVC=>SgeVC, en_tecla_vga_prod=>en_tecla_vga_prod,  fs_valido => fs_valido,
	en_money=>en_money, sel_money=>sel_money, 
	reset_money=>reset_money,en_vuelto=> en_vuelto, sel_vuelto=>sel_vuelto,	
	en_a=>en_a,  en_p=>en_p, en_c=>en_c, entrega=>entreg_int );
	
	
	
		
	----en_reg <= en and enable;
	
		enable_eq_1 <=   eq_1 and fs_valido;
		enable_eq_2 <=   eq_2 and fs_valido;
		enable_eq_3 <=  eq_3 and fs_valido;
		enable_eq_4 <=   eq_4 and fs_valido;
	
	I11 : mux2a1	  port map (sel => enable_eq_1, a => "00000101", b => "00000000", f => mux1);
	I12 : mux2a1	  port map (sel => enable_eq_2, a => "00001010", b => "00000000", f => mux2);
	I13 : mux2a1 	  port map (sel => enable_eq_3, a => "00010100", b => "00000000", f => mux3);
	I14 : mux2a1     port map (sel => enable_eq_4, a => "00110010", b => "00000000", f => mux4);
	I17 : adder_completo  port map (A => mux1, B => mux2, C => mux3, D => mux4, E => q_1, F => Y);
		
	I15 : mux2a1     port map (sel =>reset_money , a =>Y, b =>"00000000", f => mux5);
	
	enable_registro_saldo<=en_money and en;
	enable_contador_monedas <= sel_money and en;
	
	enable_reset_cantidad <= reset_money_cant and en;
	
	I16 : registro8  		 port map (en => enable_registro_saldo, reset => reset_n, clk => clock_50, d => mux5, q => q_1);
	
	
	I18 : bintobcd		    port map (a => q_1 , f => k);
	I19 : hexa			    port map (a => k(11 downto 8) , f => D_dec);
	I20 : hexa			    port map (a => k(7 downto 4) , f => D_uni);
	I21 : hexa			    port map (a => k(3 downto 0) , f => D_dec_cent);
	
	----contador de monedas----
	I22 : counter  		 port map (enable =>enable_contador_monedas , reset => reset_n, clk =>clock_50 , reset_sync => enable_reset_cantidad, q => valu);
	
	
	-----contador de monedas----
	------para ver el valor de valu---------
	
	Ivalu_display :   hexa port map(a=> valu,f=> num_dis_valu);
																							 
	display_valu <=num_dis_valu;
	
	
	---------------para ver el valor de valu-------------
	enable_decount_a <= en and en_a;
	enable_decount_p <= en and en_p;
	enable_decount_c <= en and en_c;
	I24 :	contador10		 port map (clk => clock_50, en => enable_decount_a, rst_n => reset_n, q=> qA);
	I25 :	contador10		 port map (clk => clock_50, en => enable_decount_p, rst_n => reset_n, q=> qP);
	I26 :	contador10		 port map (clk => clock_50, en => enable_decount_c, rst_n => reset_n, q=> qC);
	
	
	
	I27 :	comparador1		 port map (a => q_1, b => "00001111", f => SgeVA);
	I28 :	comparador1		 port map (a => q_1, b => "00010100", f => SgeVB);
	I29 :	comparador1		 port map (a => q_1, b => "00011001", f => SgeVC);
	
	--------------entrega del producto-------------------
	
	I31 : detec_fs			 port map (w => entreg_int, clock => clock_50, resetn => reset_n, en => en, z => fsubida);
	
	I33 : enganche port map(start => fsubida,stop => stop, clk =>clock_50, reset_n => reset_n, en => en, f=> entreg_temp);
	
	entreg<=entreg_temp;
	
	I32 : counter_mod  	 port map (reset_n => reset_n, clk =>clock_50, en => entreg_temp, q => cuenta);

----	generic map (n=>200,width=>8)
	
	stop<='1' when (cuenta=std_logic_vector(to_unsigned(200,8))) else
			'0';
	
	
	
	-------------entrega del producto--------------
	
	-------registro para que guarde el producto seleccionado--------------

	I34 : registro_tipo_producto port map(en=> en_tecla_vga_prod , reset=>reset_n,clk=>clock_50,d=>valor_reg,q=>producto);
	-----enable_tipo_producto <= en_tecla_vga_prod and en;
	
	 
	---cambiar eq_prod por en_tecla_vga_prod ---
	
	
	
	
	decena_vga_saldo  <= k(11 downto 8) ;
	unidad_vga_saldo  <= k(7 downto 4) ;	
	decimal_vga_saldo <= k(3 downto 0);
	
	
	----parte del vuelto---------
	
	enable_vuelto <= en and en_vuelto;
	
	
	resta : restador port map ( saldo=>q_1,sel=>sel_vuelto,en_vuelto=>enable_vuelto, clock=>clock_50,reset_n =>reset_n, vuelto=> vuelto);
	
	conversion_vga : bintobcd port map(a=>vuelto,f=>vga_vuelto);
	
	
	decena_vga_vuelto  <= vga_vuelto(11 downto 8) ;
	unidad_vga_vuelto  <= vga_vuelto(7 downto 4) ;	
	decimal_vga_vuelto <= vga_vuelto(3 downto 0);
	
	
	
	
end behav;




