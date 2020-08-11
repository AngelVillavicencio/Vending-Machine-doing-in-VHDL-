Library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counter_mod is
  generic (n     : natural := 201;        
           width : natural :=8);
  port (signal reset_n :  in std_logic;
        signal clk     :  in std_logic;
        signal en      :  in std_logic;
        signal q       : out std_logic_vector(width-1 downto 0));
end counter_mod;

architecture structural of counter_mod is

  signal q_reg   : unsigned(width-1 downto 0);
  signal q_next  : unsigned(width-1 downto 0);
  
begin

  seq: process(reset_n,clk)
  begin
    if (reset_n = '0') then
      q_reg <= (others => '0');
    elsif rising_edge(clk) then
      q_reg <= q_next;  
    end if;
  end process seq;

  comb: process(en, q_reg)
  begin
    if (en = '1') then
	  --if (q_reg = to_unsigned(n-1,q_reg'length)) then
	  if (q_reg = (n-1)) then
	    q_next <= (others => '0');
	  else	
	    q_next <= q_reg + 1;
	  end if; 	
	else
	  q_next <= q_reg;
    end if;
  end process comb;
  
  q <= std_logic_vector(q_reg); 
  
end structural;
