library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity complemento_dos is
  port(signal a :  in std_logic_vector(7 downto 0);
       signal f : out std_logic_vector(7 downto 0));
end complemento_dos;

architecture structural of complemento_dos is

begin

  f <= std_logic_vector(unsigned(not(a)) + 1);

end structural;