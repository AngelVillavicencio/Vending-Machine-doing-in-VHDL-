library ieee;
use ieee.std_logic_1164.all;

package my_circuitsdelinput_eval is
	component registro4 is
	port(	signal en : in std_logic;
			signal reset: in std_logic;
			signal clk: in std_logic;
			signal d	 : in std_logic_vector(3 downto 0);
			signal q	 : out std_logic_vector(3 downto 0));
	end component;
	
	component  registro8 is
	port(	signal en : in std_logic;
			signal reset: in std_logic;
			signal clk: in std_logic;
			signal d	 : in std_logic_vector(7 downto 0);
			signal q	 : out std_logic_vector(7 downto 0));
	end component;
	
	component mux2a1 is
	port(	signal sel 	: in std_logic;
			signal a	  	: in std_logic_vector(7 downto 0);
			signal b		: in std_logic_vector(7 downto 0);
			signal f		: out std_logic_vector(7 downto 0));
	end component;
	
	component hexa is
   port(signal a  :  in std_logic_vector(3 downto 0);
	    signal f  : out std_logic_vector(6 downto 0)) ;
	end component;
	
	
	
	component ffd is
	port(	signal en : in std_logic;
			signal reset: in std_logic;
			signal clk: in std_logic;
			signal d	 : in std_logic;
			signal q	 : out std_logic);
	end component;
	
	component divisor500mil is
	port(	signal clk	 : in std_logic;
			signal reset : in std_logic;
			signal clk_o: out std_logic);
	end component;
	
	component counter is 
	port(	signal clk	: in std_logic;
			signal enable	: in std_logic;
			signal reset: in std_logic;
			signal reset_sync: in std_logic;
			signal q		: out std_logic_vector(3 downto 0));
	end component;
	
	component comparador is
	port(	signal a	: in std_logic_vector(3 downto 0);
			signal b	: in std_logic_vector(3 downto 0);
			signal f	: out std_logic);
	end component;
	
	component bintobcd is
   port(signal a  :  in std_logic_vector(7 downto 0);
	   signal f  : out std_logic_vector(11 downto 0)) ;
	end component;
	
	component adder_completo is
	port(	signal A		: in std_logic_vector(7 downto 0);
			signal B		: in std_logic_vector(7 downto 0);
			signal C		: in std_logic_vector(7 downto 0);
			signal D		: in std_logic_vector(7 downto 0);
			signal E		: in std_logic_vector(7 downto 0);
			signal F		: out std_logic_vector(7 downto 0));
	end component;
	
	component contador10 is
	port( clk : in std_logic ;
		en : in std_logic;
		rst_n : in std_logic;
		q : out std_logic_vector (3 downto 0));
	end component;
	
	component comparador1 is
	port(	signal a	: in std_logic_vector(7 downto 0);
			signal b	: in std_logic_vector(7 downto 0);
			signal f	: out std_logic);
	end component;
	
	component maquina_de_estado is
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
			signal en_tecla_vga_prod       : out std_logic;
			signal en_money                : out std_logic; 
			signal sel_money               : out std_logic;
		--------	signal reset_saldo             : out std_logic;
			signal reset_money             : out std_logic;
			signal en_vuelto               : out std_logic;
			signal sel_vuelto              : out std_logic_vector(1 downto 0);
			
			
			signal reset_money_cant      : out std_logic;		  

			signal en_a                    : out std_logic;
			signal en_p                    : out std_logic;
			signal en_c                    : out std_logic;
			signal entrega                 : out std_logic);
	end component;
	
	component detec_fs is
	port(signal w,clock,resetn,en: in std_logic;
		  signal z: out std_logic);
	end component;
	
	component enganche is
	port(signal start,stop,clk,reset_n,en: in std_logic;
		  signal f: out std_logic);
	end component;
	
	component counter_mod is
		generic (n     : natural := 201;        
           width : natural :=8  );
	port (signal reset_n :  in std_logic;
        signal clk     :  in std_logic;
        signal en      :  in std_logic;
        signal q       : out std_logic_vector(width-1 downto 0));
	end component;
	
	component registro_tipo_producto is
	port(	signal en : in std_logic;
			signal reset: in std_logic;
			signal clk: in std_logic;
			signal d	 : in std_logic_vector(3 downto 0);
			signal q	 : out std_logic_vector(3 downto 0));
   end component;
	
	component restador is
	port(	signal saldo	:	in std_logic_vector(7 downto 0);
			signal sel	:	in std_logic_vector(1 downto 0);
			signal en_vuelto:	in std_logic;
			signal clock		:	in std_logic;
			signal reset_n	:	in std_logic;
			signal vuelto	: out std_logic_vector(7 downto 0));
	end component;
	
end package;
