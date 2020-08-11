library ieee;
use ieee.std_logic_1164.all;

package my_componentsdelteclado is

	component divisor5millones is 
	port(	signal reset : in std_logic;
			signal clk : in std_logic;
			signal d : out std_logic);
	end component;
	
	component synchronizer is 
	port(	signal reset : in std_logic;
			signal clk	 : in std_logic;
			signal en	 : in std_logic;
			signal d		 : in std_logic_vector(3 downto 0);
			signal q		 : out std_logic_vector(3 downto 0));
	end component;
	
	component codificador is 
	port(	signal w	: in std_logic_vector(3 downto 0);
			signal z	: out std_logic;
			signal y	: out std_logic_vector(1 downto 0));
	end component;
	
	component contador4 is 
	port(	signal reset : in std_logic;
			signal en	 : in std_logic;
			signal clk	 : in std_logic;
			signal q		 : out std_logic_vector(1 downto 0));
	end component;
	
	component decodificador is 
	port(	signal w	: in std_logic_vector(1 downto 0);
			signal en: in std_logic;
			signal y	: out std_logic_vector(3 downto 0));
	end component;
	
	component mux4a1 is 
	port(	signal sel: in std_logic_vector(1 downto 0);
			signal a	: in std_logic_vector(3 downto 0);
			signal b	: in std_logic_vector(3 downto 0);
			signal c	: in std_logic_vector(3 downto 0);
			signal d	: in std_logic_vector(3 downto 0);
			signal f	: out std_logic_vector(3 downto 0));
	end component;
	
	component mux2_1 is 
	port(	signal sel: in std_logic;
			signal a	: in std_logic_vector(6 downto 0);
			signal b	: in std_logic_vector(6 downto 0);
			signal f	: out std_logic_vector(6 downto 0));
	end component;
	
	component hexa_0 is
  port(signal a  :  in std_logic_vector(3 downto 0);
	    signal f  : out std_logic_vector(6 downto 0)) ;
	end component;

end package; 