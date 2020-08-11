library ieee;
use ieee.std_logic_1164.all;

entity fsm_money is
	port(	signal reset_n		: in std_logic;
			signal clock_50	: in std_logic;
			signal req			: in std_logic;
			signal en			: in std_logic;
			signal eq_dev		: in std_logic;
			signal eq_prod		: in std_logic;
			signal eq_money	: in std_logic;
			signal fs_valido	: in std_logic;
			signal valu			: in std_logic_vector(2 downto 0);
			signal ack			: out std_logic;
			signal rstn_sync	: out std_logic;
			signal enable		: out std_logic);
end fsm_money;
architecture structural of fsm_money is
	type state is (ST_IDLE, ST_M0, ST_M1, ST_EOP);
	signal state_next, state_reg : state;
	attribute syn_encoding : string;
	attribute syn_encoding of state : type is "safe";
	
begin
	----------LOGICA SECUENCIAL-----------------------------------------------
	seq :process(reset_n,clock_50)
	begin
		if (reset_n ='0') then 
			state_reg <= ST_IDLE;
		elsif rising_edge(clock_50)  then
			if (en ='1') then 
			state_reg <= state_next;
			end if;
		end if;
	end process seq;
	---------LOGICA COMBINACIONAL ESTADO SIGUIENTE Y SALIDAS------------------

	comb : process(state_reg, eq_dev, eq_prod, eq_money, fs_valido, valu, req)
	begin
			rstn_sync<= '0';
			enable 	<= '0';
			ack 		<= '0';
			
		case state_reg is
			when ST_IDLE =>
					rstn_sync<= '0';
					enable 	<= '0';
					ack 		<= '0';
						if(req = '0')then
						state_next <= ST_IDLE;
						else
						state_next <= ST_M0;
						end if;
			when ST_M0 =>
					rstn_sync<= '1';
					enable 	<= '0';
					ack 		<= '0';
						if(fs_valido = '0')then
						state_next <= ST_M0;
						elsif((eq_dev = '0')and(eq_prod = '0')and(valu< x"5")and(fs_valido = '1')and(eq_money = '1'))then
						state_next <= ST_M1;
						else
						state_next <= ST_EOP;
						end if;
			when ST_M1 =>
					rstn_sync<= '1';
					enable 	<= '1';
					ack 		<= '0';
					state_next <= ST_M0;
			when ST_EOP =>
					rstn_sync<= '1';
					enable 	<= '0';
					ack 		<= '1';
						if(req = '1')then
						state_next <= ST_EOP;
						else
						state_next <= ST_IDLE;
						end if;
			when others =>
					state_next <= ST_IDLE;
					
		end case;
	end process comb;
end structural;