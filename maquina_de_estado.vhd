library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity maquina_de_estado is
	port(	signal reset_n		: in std_logic;
			signal clock_50	: in std_logic;
			signal en         : in std_logic;
			signal eq_A			: in std_logic;
			signal eq_B			: in std_logic;
			signal eq_C			: in std_logic;
			signal eq_return	: in std_logic;
			signal eq_prod		: in std_logic;
			signal eq_1			: in std_logic;
			signal eq_2			: in std_logic;
			signal eq_3			: in std_logic;
			signal eq_4			: in std_logic;
			signal eq_money	: in std_logic;
			signal valu			: in std_logic_vector(3 downto 0);
			signal SgeVA		: in std_logic;
			signal SgeVB		: in std_logic;
			signal SgeVC		: in std_logic; 
			signal fs_valido	: in std_logic;
			signal reset_money_cant      : out std_logic;		  
			signal en_tecla_vga_prod       : out std_logic;
			signal en_money                : out std_logic; 
			signal sel_money               : out std_logic;
			signal reset_money             : out std_logic;
			signal en_vuelto               : out std_logic;
			signal sel_vuelto              : out std_logic_vector(1 downto 0);
		
				
		
		
			signal en_a                    : out std_logic;
			signal en_p                    : out std_logic;
			signal en_c                    : out std_logic;
			signal entrega                 : out std_logic);
end maquina_de_estado;
architecture structura of maquina_de_estado is
	type state is (st_1, st_2, st_3,st_3_0,st_4);
	signal state_next, state_reg : state;
	attribute syn_encoding : string;
	attribute syn_encoding of state : type is "safe";
begin
	
	
	----------LOGICA SECUENCIAL-----------------------------------------------
	seq :process(reset_n,clock_50)
	begin
		if (reset_n ='0') then 
			state_reg <= st_1;
		elsif rising_edge(clock_50)  then
			if (en ='1') then 
			state_reg <= state_next;
			end if;
		end if;
	end process seq;
	
	---------LOGICA COMBINACIONAL ESTADO SIGUIENTE Y SALIDAS------------------

	comb : process(state_reg,eq_A,eq_B,eq_C, eq_prod,eq_1,eq_2,eq_3,eq_4,eq_money,eq_return,valu,SgeVA,SgeVB,SgeVC)	
	begin
			en_tecla_vga_prod    <= '0';
			en_money             <= '0';
			sel_money            <= '0';
			reset_money			   <= '0';
			en_vuelto            <= '0';          
			sel_vuelto           <= "00";
			en_a                 <= '0';
			en_p                 <= '0';
			en_c                 <= '0';
			entrega          		<= '0';
			reset_money_cant     <= '0';
		
		case state_reg is
		
			when st_1 =>

			if((eq_A='1') or (eq_B='1') or (eq_C='1'))then
				
				en_tecla_vga_prod    <= '1';
				state_next <= st_2;
			else
				state_next <= st_1;
			end if;
			
			when st_2 =>
			
			state_next <= st_3;
		
			
			
			
			
			
			when st_3 =>
			
			if((eq_A='1') or (eq_B='1') or (eq_C='1'))then
				
				en_tecla_vga_prod    <= '1';
				state_next <= st_2;
				
			elsif((((eq_1='1') or (eq_2='1') or (eq_3='1') or (eq_4='1'))and (eq_money='1')))then 
			
			----aqui arriba quite valu---
				reset_money_cant     <= '0';
				en_money             <= '1';
				sel_money            <= '1';
				reset_money			   <= '1';
				
				state_next <= st_3_0;
			else 
			state_next <= st_3;
			end if;
			
		
			
			
			
			when st_3_0 => 


			
			if((((eq_1='1') or (eq_2='1') or (eq_3='1') or (eq_4='1'))and (eq_money='1')))then 
			en_money             <= '1';
		   sel_money            <= '1';
			reset_money			   <= '1';
			reset_money_cant     <= '0';
			state_next <= st_3_0;
			
			elsif((eq_A='1') and (SgeVA='1')and(eq_money='0')and (eq_prod='1'))then 
				
				
			en_tecla_vga_prod    <= '1';
			reset_money			   <= '1';
			en_vuelto            <= '1';
			sel_vuelto           <= "00";
			en_a                 <= '1';
			entrega              <= '1';
		   sel_money            <= '1';
		   reset_money_cant     <= '1';
			
			state_next <= st_4;
			elsif((eq_B='1') and (SgeVB='1') and(eq_money='0')and (eq_prod='1'))then 
	
			en_tecla_vga_prod    <= '1';
			reset_money			   <= '1';
			en_vuelto            <= '1';
			sel_vuelto           <= "01";
			en_p                 <= '1';
			entrega              <= '1';
		   sel_money            <= '1';
		   reset_money_cant     <= '1';	

			
			state_next <= st_4;
			elsif((eq_C='1') and (SgeVC='1') and(eq_money='0')and (eq_prod='1'))then 
			
			en_tecla_vga_prod    <= '1';
			reset_money			   <= '1';
			en_vuelto            <= '1';         
			sel_vuelto           <= "10";
			en_c                 <= '1';
			entrega              <= '1';	
		   sel_money            <= '1';
		   reset_money_cant     <= '1';
			state_next <= st_4;
			
--			elsif((eq_return='1')and (eq_money='0') and (eq_prod='0') )then 
--			state_next <= st_5;
--			en_tecla_vga_prod    <= '1';
--			reset_money			   <= '0';
--			en_vuelto            <= '1';         
--			sel_vuelto           <= "11";
--			sel_money            <= '1';
--		   reset_money_cant     <= '1';
			else 
			state_next <= st_3_0;
			end if;
			
		
			
--			when st_3_1 =>
--			en_tecla_vga_prod    <= '0';
--			en_money             <= '0';
--			sel_money            <= '0';
--			reset_money			   <= '0';
--			en_vuelto            <= '0';          
--			sel_vuelto           <= "00";
--			en_a                 <= '0';
--			en_p                 <= '0';
--			en_c                 <= '0';
--			entrega          		<= '0';
--			reset_money_cant     <= '0';
--			state_next <= st_3_0;
			
			
			
			
			
--			
--			when st_5 => 
--			state_next <=st_1;
--			
			
			
			
			when st_4 => 
			en_money             <= '1';
		   
			reset_money			   <= '0';
			
			
			state_next <=st_1;

		
			
			when others =>
					state_next <= st_1;


		end case;
	end process comb;
end structura;					
					
					
					
					
					
----------copia de seguridad---------

--
--
--case state_reg is
--		
--			when st_1 =>
--
--			if((eq_A='1') or (eq_B='1') or (eq_C='1'))then
--				
--				en_tecla_vga_prod    <= '1';
--				state_next <= st_2;
--			else
--				state_next <= st_1;
--			end if;
--			
--			when st_2 =>
--			
--			state_next <= st_3;
--		
--			
--			
--			
--			
--			
--			when st_3 =>
--			
--			if((eq_A='1') or (eq_B='1') or (eq_C='1'))then
--				
--				en_tecla_vga_prod    <= '1';
--				state_next <= st_2;
--				
--			elsif((((eq_1='1') or (eq_2='1') or (eq_3='1') or (eq_4='1'))and (eq_money='1')and (valu <x"5")))then 
--				reset_money_cant     <= '0';
--				en_money             <= '1';
--				sel_money            <= '1';
--				reset_money			   <= '1';
--				
--				state_next <= st_3_0;
--			else 
--			state_next <= st_3;
--			end if;
--			
--		
--			
--			
--			
--			when st_3_0 => 
--			if((((eq_1='1') or (eq_2='1') or (eq_3='1') or (eq_4='1'))and (eq_money='1')and (valu <x"5")))then 
--			en_money             <= '1';
--			sel_money            <= '1';
--			reset_money			   <= '1';
--			reset_money_cant     <= '0';
--			state_next <= st_3_1;
--			elsif((eq_A='1') and (SgeVA='1')and(eq_money='0')and (eq_prod='1'))then 
--				
--				
--			en_tecla_vga_prod    <= '1';
--			reset_money			   <= '1';
--			en_vuelto            <= '1';
--			sel_vuelto           <= "00";
--			en_a                 <= '1';
--			entrega              <= '1';
--		   sel_money            <= '1';
--		   reset_money_cant     <= '1';
--			
--			state_next <= st_4;
--			elsif((eq_B='1') and (SgeVB='1') and(eq_money='0')and (eq_prod='1'))then 
--	
--			en_tecla_vga_prod    <= '1';
--			reset_money			   <= '1';
--			en_vuelto            <= '1';
--			sel_vuelto           <= "01";
--			en_p                 <= '1';
--			entrega              <= '1';
--		   sel_money            <= '1';
--		   reset_money_cant     <= '1';	
--
--			
--			state_next <= st_4;
--			elsif((eq_C='1') and (SgeVC='1') and(eq_money='0')and (eq_prod='1'))then 
--			
--			en_tecla_vga_prod    <= '1';
--			reset_money			   <= '1';
--			en_vuelto            <= '1';         
--			sel_vuelto           <= "10";
--			en_c                 <= '1';
--			entrega              <= '1';	
--		   sel_money            <= '1';
--		   reset_money_cant     <= '1';
--			state_next <= st_4;
--			
--			elsif((eq_return='1')and (eq_prod='0')and (eq_money='0'))then 
--			state_next <= st_5;
--			en_tecla_vga_prod    <= '1';
--			reset_money			   <= '0';
--			en_vuelto            <= '1';         
--			sel_vuelto           <= "11";
--			sel_money            <= '1';
--		   reset_money_cant     <= '1';
--			else 
--			state_next <= st_3_0;
--			end if;
--			
--			
--			
--			
--			
--			
--			
--			when st_3_1 =>
--			state_next <= st_3_2;
--			
--			
--			
--			
--			
--			
--			when st_3_2 => 
--			if((((eq_1='1') or (eq_2='1') or (eq_3='1') or (eq_4='1'))and (eq_money='1')and (valu <x"5")))then 
--			en_money             <= '1';
--			sel_money            <= '1';
--			reset_money			   <= '1';
--			
--			state_next <= st_3_1;
--			elsif((valu >= x"5"))then 
--			state_next <= st_3_0;
--			else 
--			state_next <=st_3_2;
--			end if;
--			
--			
--			
--			when st_5 => 
--			state_next <=st_1;
--			
--			
--			
--			
--			when st_4 => 
--			state_next <=st_1;
--
--		
--			
--			when others =>
--					state_next <= st_1;

-----------copia de seguridad---------

					
