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

entity APUF is
  generic (stage_n: integer := 2);
  port (
    paths: in std_logic_vector(1 to 4);
    -- [4, 0] for switch block 0.
    challenge: in std_logic_vector(5 * stage_n - 1 downto 0);
    response: out std_logic_vector(4 downto 0));
end APUF;

architecture Behavioral of APUF is

  component Switch_Block_4x4 is port (
    input: in std_logic_vector(0 to 3);
    challenge: in std_logic_vector(4 downto 0);
    output: out std_logic_vector(0 to 3));
  end component;

  component Arbiter is port (
     permutation: in std_logic_vector(1 to 4); -- a1 to a4 in the paper
     order: out std_logic_vector(4 downto 0));
  end component;

  type switch_block_io_array is array (0 to stage_n - 1) of std_logic_vector(1 to 4);
  signal switch_block_out: switch_block_io_array;

begin

  assert (stage_n > 0)
    report "Number of stages must be positive in APUF must be positive."
    severity failure;
  
  FIRST_SWITCH_BLOCK: Switch_Block_4x4 port map (
    input => paths,
    challenge => challenge(4 downto 0),
    output => switch_block_out(0));

  SWITCH_BLOCKS: for i in 1 to stage_n - 1 generate
      SWITCH_BLOCK: Switch_Block_4x4 port map (
        input => switch_block_out(i-1),
        challenge => challenge((i+1)*5 - 1 downto (i*5)),
        output => switch_block_out(i)); 
  end generate SWITCH_BLOCKS;
  
  APUF_ARBITER: Arbiter port map (
    permutation => switch_block_out(stage_n - 1), order => response);

end Behavioral;
