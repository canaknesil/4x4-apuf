-- Copyright (c) 2020 Can Aknesil

-- Permission is hereby granted, free of charge, to any person obtaining a copy
-- of this software and associated documentation files (the "Software"), to deal
-- in the Software without restriction, including without limitation the rights
-- to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
-- copies of the Software, and to permit persons to whom the Software is
-- furnished to do so, subject to the following conditions:

-- The above copyright notice and this permission notice shall be included in all
-- copies or substantial portions of the Software.

-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
-- SOFTWARE.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_MISC.ALL;

entity Decoder_24x5 is port (
  one_hot_input: in std_logic_vector(1 to 24);
  output: out std_logic_vector(5 downto 1)
);
end Decoder_24x5;

architecture Behavioral of Decoder_24x5 is

begin
  -- put not
  output(5) <= not or_reduce(one_hot_input(13 to 24));
  
  output(4) <= not (or_reduce(one_hot_input(5 to 12)) or
                    or_reduce(one_hot_input(21 to 24)));
  
  output(3) <= not (or_reduce(one_hot_input(1 to 4)) or
                    or_reduce(one_hot_input(9 to 12)) or
                    or_reduce(one_hot_input(17 to 20)));
  
  output(2) <= not (one_hot_input(3) or one_hot_input(4) or
                    one_hot_input(7) or one_hot_input(8) or
                    one_hot_input(11) or one_hot_input(12) or
                    one_hot_input(15) or one_hot_input(16) or
                    one_hot_input(19) or one_hot_input(20) or
                    one_hot_input(23) or one_hot_input(24));

  output(1) <= not (one_hot_input(2) or
                    one_hot_input(4) or
                    one_hot_input(6) or
                    one_hot_input(8) or
                    one_hot_input(10) or
                    one_hot_input(12) or
                    one_hot_input(14) or
                    one_hot_input(16) or
                    one_hot_input(18) or
                    one_hot_input(20) or
                    one_hot_input(22) or
                    one_hot_input(24));
               

end Behavioral;
