library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity fp_adder is
  port (
    clk : in std_logic;
    reset : in std_logic;
    a, b : in std_logic_vector(31 downto 0);
    result : out std_logic_vector(31 downto 0)
  );
end entity fp_adder;

architecture rtl of fp_adder is
  -- Signals for intermediate stages
  signal stage1_out, stage2_out : std_logic_vector(31 downto 0);
  signal stage3_out : std_logic_vector(31 downto 0);

  -- Components instantiation
  component exponent_align
    port (
      a, b : in std_logic_vector(31 downto 0);
      out1, out2 : out std_logic_vector(31 downto 0)
    );
  end component;

  component fp_addition
    port (
      a, b : in std_logic_vector(31 downto 0);
      sum : out std_logic_vector(31 downto 0)
    );
  end component;

  component normalize
    port (
      in_val : in std_logic_vector(31 downto 0);
      out_val : out std_logic_vector(31 downto 0)
    );
  end component;

begin
  -- Stage 1: Exponent Alignment
  stage1 : exponent_align
    port map (
      a => a,
      b => b,
      out1 => stage1_out,
      out2 => stage2_out
    );

  -- Stage 2: Floating-point Addition
  stage2 : fp_addition
    port map (
      a => stage1_out,
      b => stage2_out,
      sum => stage3_out
    );

  -- Stage 3: Normalization
  stage3 : normalize
    port map (
      in_val => stage3_out,
      out_val => result
    );

end architecture rtl;

