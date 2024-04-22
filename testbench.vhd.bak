library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity testbench is
end entity testbench;

architecture sim of testbench is
  signal clk, reset : std_logic := '0';
  signal a, b, result : std_logic_vector(31 downto 0);
  signal input_count : integer := 0;

  component fp_adder
    port (
      clk : in std_logic;
      reset : in std_logic;
      a, b : in std_logic_vector(31 downto 0);
      result : out std_logic_vector(31 downto 0)
    );
  end component;

begin
  -- Instantiate DUT (Design Under Test)
  dut : fp_adder
    port map (
      clk => clk,
      reset => reset,
      a => a,
      b => b,
      result => result
    );

  -- Clock process
  clk_process : process
  begin
    while not (input_count >= 100) loop
      clk <= '0';
      wait for 10 ns;
      clk <= '1';
      wait for 10 ns;
    end loop;
    wait;
  end process clk_process;

  -- Test process
  test_process : process
  begin
    reset <= '1'; -- Assert reset
    wait for 20 ns;
    reset <= '0'; -- De-assert reset after 20 ns

    -- Test cases
    a <= x"3F800000"; -- 1.0
    b <= x"40000000"; -- 2.0
    wait for 20 ns;

    a <= x"40400000"; -- 3.0
    b <= x"C0400000"; -- -6.0
    wait for 20 ns;

    a <= x"40C00000"; -- 6.0
    b <= x"C0A00000"; -- -10.0
    wait for 20 ns;

    a <= x"40400000"; -- 3.0
    b <= x"40400000"; -- 3.0
    wait for 20 ns;

    -- Add more test cases here...

    input_count <= input_count + 4; -- Increment input count for each set of inputs
    if input_count >= 100 then
      wait; -- Finish simulation
    end if;
  end process test_process;

end architecture sim;

