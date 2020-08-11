library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity contador10 is
port( clk : in std_logic ;
		en : in std_logic;
		rst_n : in std_logic;
		q : out std_logic_vector (3 downto 0));
end contador10;

architecture circuito of contador10 is
signal q_reg, q_next: unsigned (3 downto 0);
begin 
seq:	process (clk, rst_n)
  begin 
    if rst_n = '0' then
       q_reg <= "1001";
    elsif (clk'event and clk='1') then 
       q_reg <= q_next;
   end if;
end process seq;
 
comb: process (q_reg, en)
      begin 
if en = '1' then 
  if q_reg = 0 then
     q_next <= "1001";
  else 
     q_next <= q_reg - 1;
  end if;
else 
     q_next <= q_reg;	
end if;
end process comb;

q <= std_logic_vector(q_reg);
end circuito;