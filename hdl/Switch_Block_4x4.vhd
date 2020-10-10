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

entity Switch_Block_4x4 is
  port (
    input: in std_logic_vector(0 to 3);
    challenge: in std_logic_vector(4 downto 0);
    output: out std_logic_vector(0 to 3));
  
  attribute DONT_TOUCH: string;
  attribute DONT_TOUCH of Switch_Block_4x4: entity is "true|yes";
  
end Switch_Block_4x4;

architecture Structural of Switch_Block_4x4 is

  component Mux_4x1 is port (
    A: in std_logic;
    B: in std_logic;
    C: in std_logic;
    D: in std_logic;
    Sel: in std_logic_vector(1 downto 0);
    Q: out std_logic);
  end component;
  attribute DONT_TOUCH of Mux_4x1: component is "yes";
  
  component Permutation is port (
    Index: in std_logic_vector(4 downto 0);
    Permutation: out std_logic_vector(0 to 7));
  end component;
  attribute DONT_TOUCH of Permutation: component is "yes";
  
  signal mux_select: std_logic_vector(0 to 7); -- First two bits for mux 0, ...

begin

  PERMUTATION_COMPONENT: Permutation port map (
    Index => challenge,
    Permutation => mux_select);
  

  EQUAL_PATHS: for i in 0 to 3 generate
    EQUAL_PATH_MUX: Mux_4x1 port map (
      A => input(0),
      B => input(1),
      C => input(2),
      D => input(3),
      Sel => mux_select(2*i to 2*i+1),
      Q => output(i));
  end generate EQUAL_PATHS;
  
end Structural;
