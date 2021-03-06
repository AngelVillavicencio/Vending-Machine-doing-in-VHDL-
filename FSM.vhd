library ieee;
use ieee.std_logic_1164.all;

entity FSM is
	port(	signal reset_n		: in std_logic;
			signal en			: in std_logic;
			signal eq_return	: in std_logic;
			signal eq_prod		: in std_logic;
			signal fs_valido	: in std_logic;
			signal ack			: in std_logic;
			signal eq_A			: in std_logic;
			signal eq_B			: in std_logic;
			signal eq_C			: in std_logic;
			signal clock_50	: in std_logic;
			signal SgeVA		: in std_logic;
			signal SgeVB		: in std_logic;
			signal SgeVC		: in std_logic;
			signal entreg		: out std_logic;
			signal rstn_en		: out std_logic;
			signal req			: out std_logic;
			signal return_money: out std_logic;
			signal en_a,en_p,en_c: out std_logic);
end FSM; 
architecture struc_2 of FSM is
	type state is (ST_0, ST_1, ST_2, ST_3, ST_4, ST_5, ST_6, ST_7, ST_8, ST_9);
	signal state_next, state_reg : state;
	attribute syn_encoding : string;
	attribute syn_encoding of state : type is "safe";
begin
		----------LOGICA SECUENCIAL-----------------------------------------------
	seq :process(reset_n,clock_50)
	begin
		if (reset_n ='0') then 
			state_reg <= ST_0;
		elsif rising_edge(clock_50) then
			if(en = '1')then 
			state_reg <= state_next;
			end if;
		end if;
	end process seq;
		---------LOGICA COMBINACIONAL-------------------------------------------
	comb: process(eq_return, eq_prod, fs_valido, ack, eq_A, eq_B, eq_C, state_reg, SgeVB, SgeVA, SgeVC)
	begin
			req	 		<= '0';
			entreg		<= '0';
			rstn_en 		<= '0';
			return_money<= '0';
			case state_reg is
			when ST_0 =>
					req	 		<= '0';
					entreg		<= '0';
					rstn_en 		<= '0';
					return_money<= '0';
					en_a<='0';
					en_p<='0';
					en_c<='0';
						if(ack = '1')then
						state_next <= ST_1;
						else
						state_next <= ST_0;
						end if;
			when ST_1 =>
					req	 		<= '0';
					entreg		<= '0';
					rstn_en 		<= '1';
					return_money<= '0';
					en_a<='0';
					en_p<='0';
					en_c<='0';
						if((fs_valido = '1') and (eq_prod = '1') and (eq_A = '1'))then
						state_next <= ST_2;
						elsif((fs_valido = '1') and (eq_prod = '1') and (eq_B = '1'))then
						state_next <= ST_4;
						elsif((fs_valido = '1') and (eq_prod = '1') and (eq_C = '1'))then
						state_next <= ST_6;
						elsif((fs_valido = '1') and (eq_return = '0'))then
						state_next <= ST_8;
						else
						state_next <= ST_1;
						end if;
			when ST_2 =>
					req	 		<= '0';
					entreg		<= '0';
					rstn_en 		<= '1';
					return_money<= '0';
					en_a<='0';
					en_p<='0';
					en_c<='0';
						if(SgeVA = '1')then
						state_next <= ST_3;
						else
						state_next <= ST_2;
						end if;
			when ST_3 =>
					req	 		<= '0';
					entreg		<= '1';
					rstn_en 		<= '1';
					return_money<= '1';
					en_a<='1';
					en_p<='0';
					en_c<='0';
						state_next <= ST_9;
			when ST_4 =>
					req	 		<= '0';
					entreg		<= '0';
					rstn_en 		<= '1';
					return_money<= '0';
					en_a<='0';
					en_p<='0';
					en_c<='0';
						if(SgeVB = '1')then
						state_next <= ST_5;
						else
						state_next <= ST_4;
						end if;
			when ST_5 =>
					req	 		<= '0';
					entreg		<= '1';
					rstn_en 		<= '1';
					return_money<= '1';
					en_a<='0';
					en_p<='1';
					en_c<='0';
						state_next <= ST_9;
			when ST_6 =>
					req	 		<= '0';
					entreg		<= '0';
					rstn_en 		<= '1';
					return_money<= '0';
					en_a<='0';
					en_p<='0';
					en_c<='0';
						if(SgeVC = '1')then
						state_next <= ST_7;
						else
						state_next <= ST_6;
						end if;
			when ST_7 =>
					req	 		<= '0';
					entreg		<= '1';
					rstn_en 		<= '1';
					return_money<= '1';
					en_a<='0';
					en_p<='0';
					en_c<='1';
						state_next <= ST_9;
			when ST_8 =>
					req	 		<= '0';
					entreg		<= '0';
					rstn_en 		<= '1';
					return_money<= '1';
					en_a<='0';
					en_p<='0';
					en_c<='0';
						state_next <= ST_9;
			when ST_9 =>
					req	 		<= '1';
					entreg		<= '0';
					rstn_en 		<= '1';
					return_money<= '0';
					en_a<='0';
					en_p<='0';
					en_c<='0';
						if(ack = '0')then
						state_next <= ST_0;
						else
						state_next <= ST_9;
						end if;
			when others =>
					state_next <= ST_0;
					
		end case;
	end process comb;
		
		
end struc_2;