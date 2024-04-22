library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity fp_addition is
  port (
    a, b : in std_logic_vector(31 downto 0);
    sum : out std_logic_vector(31 downto 0)
  );
end entity fp_addition;

architecture rtl of fp_addition is
begin
  -- Structural addition using numeric_std library
  process (a, b)
    variable va, vb : unsigned(31 downto 0);
    variable vsum : unsigned(31 downto 0);
  begin
    -- Convert input vectors to unsigned
    va := unsigned(a);
    vb := unsigned(b);
    
    -- Perform addition on unsigned values
    vsum := va + vb;
    
    -- Convert unsigned sum back to std_logic_vector
    sum <= std_logic_vector(vsum);
  end process;
end architecture rtl;

