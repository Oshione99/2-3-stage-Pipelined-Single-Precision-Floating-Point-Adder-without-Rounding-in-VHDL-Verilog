library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity normalize is
  port (
    in_val : in std_logic_vector(31 downto 0);
    out_val : out std_logic_vector(31 downto 0)
  );
end entity normalize;

architecture rtl of normalize is
begin
  -- Normalize the floating-point result
  process (in_val)
    variable exponent : integer range 0 to 255;
    variable mantissa : std_logic_vector(22 downto 0);
    variable normalized_val : std_logic_vector(31 downto 0);
    variable shift_count : integer := 0;
  begin
    -- Extract exponent and mantissa
    exponent := to_integer(unsigned(in_val(30 downto 23)));
    mantissa := in_val(22 downto 0);

    -- Check sign bit
    if (in_val(31) = '1') then -- Negative number
      -- Two's complement normalization
      normalized_val := std_logic_vector(unsigned(not(in_val)) + 1);
    else -- Positive number
      -- Check for denormalized number (exponent = 0)
      if (exponent = 0) then
        -- Shift mantissa left until leading '1' bit is in correct position
        while (mantissa(22) = '0' and shift_count < 23) loop
          mantissa := '0' & mantissa(21 downto 0); -- Shift left by one position
          shift_count := shift_count + 1;
        end loop;
        -- Increment exponent accordingly
        exponent := exponent + shift_count;
      end if;

      -- Construct normalized value
      normalized_val := in_val(31) & std_logic_vector(to_unsigned(exponent, 8)) & mantissa;
    end if;

    -- Output the normalized value
    out_val <= normalized_val;
  end process;
end architecture rtl;

