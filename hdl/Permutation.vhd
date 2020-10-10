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

entity Permutation is port (
  Index: in std_logic_vector(4 downto 0); -- A number from [0, 23]
  Permutation: out std_logic_vector(0 to 7) -- (2 bits, 2 bits, 2 bits, 2 bits)
);      
end permutation;

architecture Lexicographical of Permutation is
begin

  with Index select
    Permutation <= B"00_01_10_11" when "00000",
                   B"00_01_11_10" when "00001",
                   B"00_10_01_11" when "00010",
                   B"00_10_11_01" when "00011",
                   B"00_11_01_10" when "00100",
                   B"00_11_10_01" when "00101",
                   B"01_00_10_11" when "00110",
                   B"01_00_11_10" when "00111",
                   B"01_10_00_11" when "01000",
                   B"01_10_11_00" when "01001",
                   B"01_11_00_10" when "01010",
                   B"01_11_10_00" when "01011",
                   B"10_00_01_11" when "01100",
                   B"10_00_11_01" when "01101",
                   B"10_01_00_11" when "01110",
                   B"10_01_11_00" when "01111",
                   B"10_11_00_01" when "10000",
                   B"10_11_01_00" when "10001",
                   B"11_00_01_10" when "10010",
                   B"11_00_10_01" when "10011",
                   B"11_01_00_10" when "10100",
                   B"11_01_10_00" when "10101",
                   B"11_10_00_01" when "10110",
                   B"11_10_01_00" when "10111",
                   B"00_00_00_00" when others;
  
end Lexicographical;
