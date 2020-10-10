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

entity Arbiter is
  port (
    permutation: in std_logic_vector(1 to 4); -- a1 to a4 in the paper
    order: out std_logic_vector(4 downto 0));

  attribute DONT_TOUCH: string;
                  
end Arbiter;

architecture Behavioral of Arbiter is

  component Decoder_24x5 is port (
    one_hot_input: in std_logic_vector(1 to 24);
    output: out std_logic_vector(1 to 5));
  end component;
  attribute DONT_TOUCH of Decoder_24x5: component is "yes";

  component Flip_Flop_Symmetrical is port (
    A: in std_logic;
    B: in std_logic;
    Q: out std_logic);
  end component;
  attribute DONT_TOUCH of Flip_Flop_Symmetrical: component is "yes";

  signal one_hot: std_logic_vector(23 downto 0);
  attribute DONT_TOUCH of one_hot: signal is "yes";
  
  signal mutual_order: std_logic_vector(1 to 6);
  
begin

  FF_2_1: Flip_Flop_Symmetrical port map (
    A => permutation(2), B => permutation(1), Q => mutual_order(1));
  -- Output is 1 if B comes first.
  FF_3_2: Flip_Flop_Symmetrical port map (
    A => permutation(3), B => permutation(2), Q => mutual_order(2));
  FF_4_3: Flip_Flop_Symmetrical port map (
    A => permutation(4), B => permutation(3), Q => mutual_order(3));
  FF_3_1: Flip_Flop_Symmetrical port map (
    A => permutation(3), B => permutation(1), Q => mutual_order(4));
  FF_4_2: Flip_Flop_Symmetrical port map (
    A => permutation(4), B => permutation(2), Q => mutual_order(5));
  FF_4_1: Flip_Flop_Symmetrical port map (
    A => permutation(4), B => permutation(1), Q => mutual_order(6));

  one_hot(0) <=  mutual_order(1)       and mutual_order(2)       and mutual_order(3);
  one_hot(1) <=  mutual_order(1)       and mutual_order(5)       and (not mutual_order(3));
  one_hot(2) <=  mutual_order(4)       and (not mutual_order(2)) and mutual_order(5);
  one_hot(3) <=  mutual_order(4)       and mutual_order(3)       and (not mutual_order(5));
  one_hot(4) <=  mutual_order(6)       and (not mutual_order(5)) and mutual_order(2);
  one_hot(5) <=  mutual_order(6)       and (not mutual_order(3)) and (not mutual_order(2));
  one_hot(6) <=  (not mutual_order(1)) and mutual_order(4)       and mutual_order(3);
  one_hot(7) <=  (not mutual_order(1)) and mutual_order(6)       and (not mutual_order(3));
  one_hot(8) <=  mutual_order(2)       and (not mutual_order(4)) and mutual_order(6);
  one_hot(9) <=  mutual_order(2)       and mutual_order(3)       and (not mutual_order(6));
  one_hot(10) <= mutual_order(5)       and (not mutual_order(6)) and mutual_order(4);
  one_hot(11) <= mutual_order(5)       and (not mutual_order(3)) and (not mutual_order(4));
  one_hot(12) <= (not mutual_order(4)) and mutual_order(1)       and mutual_order(5);
  one_hot(13) <= (not mutual_order(4)) and mutual_order(6)       and (not mutual_order(5));
  one_hot(14) <= (not mutual_order(2)) and (not mutual_order(1)) and mutual_order(6);
  one_hot(15) <= (not mutual_order(2)) and mutual_order(5)       and (not mutual_order(6));
  one_hot(16) <= mutual_order(3)       and (not mutual_order(6)) and mutual_order(1);
  one_hot(17) <= mutual_order(3)       and (not mutual_order(5)) and (not mutual_order(1));
  one_hot(18) <= (not mutual_order(6)) and mutual_order(1)       and mutual_order(2);
  one_hot(19) <= (not mutual_order(6)) and mutual_order(4)       and (not mutual_order(2));
  one_hot(20) <= (not mutual_order(5)) and (not mutual_order(1)) and mutual_order(4);
  one_hot(21) <= (not mutual_order(5)) and mutual_order(2)       and (not mutual_order(4));
  one_hot(22) <= (not mutual_order(3)) and (not mutual_order(4)) and mutual_order(1);
  one_hot(23) <= (not mutual_order(3)) and (not mutual_order(2)) and (not mutual_order(1));

  ONE_HOT_DECODER: Decoder_24x5 port map (
    one_hot_input => one_hot, output => order);
  
end Behavioral;
