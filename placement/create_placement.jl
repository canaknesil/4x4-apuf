# Copyright (c) 2020 Can Aknesil

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
        
function switch_block_constraint(i, X, Y)
    """
    set_property BEL D6LUT [get_cells {apuf_driver/APUF_TEST_UNIT/SWITCH_BLOCKS[$i].SWITCH_BLOCK/EQUAL_PATHS[0].EQUAL_PATH_MUX/Q_INST_0}]
    set_property LOC SLICE_X$(X)Y$(Y) [get_cells {apuf_driver/APUF_TEST_UNIT/SWITCH_BLOCKS[$i].SWITCH_BLOCK/EQUAL_PATHS[0].EQUAL_PATH_MUX/Q_INST_0}]
    set_property BEL C6LUT [get_cells {apuf_driver/APUF_TEST_UNIT/SWITCH_BLOCKS[$i].SWITCH_BLOCK/EQUAL_PATHS[1].EQUAL_PATH_MUX/Q_INST_0}]
    set_property LOC SLICE_X$(X)Y$(Y) [get_cells {apuf_driver/APUF_TEST_UNIT/SWITCH_BLOCKS[$i].SWITCH_BLOCK/EQUAL_PATHS[1].EQUAL_PATH_MUX/Q_INST_0}]
    set_property BEL B6LUT [get_cells {apuf_driver/APUF_TEST_UNIT/SWITCH_BLOCKS[$i].SWITCH_BLOCK/EQUAL_PATHS[2].EQUAL_PATH_MUX/Q_INST_0}]
    set_property LOC SLICE_X$(X)Y$(Y) [get_cells {apuf_driver/APUF_TEST_UNIT/SWITCH_BLOCKS[$i].SWITCH_BLOCK/EQUAL_PATHS[2].EQUAL_PATH_MUX/Q_INST_0}]
    set_property BEL A6LUT [get_cells {apuf_driver/APUF_TEST_UNIT/SWITCH_BLOCKS[$i].SWITCH_BLOCK/EQUAL_PATHS[3].EQUAL_PATH_MUX/Q_INST_0}]
    set_property LOC SLICE_X$(X)Y$(Y) [get_cells {apuf_driver/APUF_TEST_UNIT/SWITCH_BLOCKS[$i].SWITCH_BLOCK/EQUAL_PATHS[3].EQUAL_PATH_MUX/Q_INST_0}]
    """
end

function first_switch_block_constraint(X, Y)
    """
    set_property BEL D6LUT [get_cells {apuf_driver/APUF_TEST_UNIT/FIRST_SWITCH_BLOCK/EQUAL_PATHS[0].EQUAL_PATH_MUX/Q_INST_0}]
    set_property LOC SLICE_X$(X)Y$(Y) [get_cells {apuf_driver/APUF_TEST_UNIT/FIRST_SWITCH_BLOCK/EQUAL_PATHS[0].EQUAL_PATH_MUX/Q_INST_0}]
    set_property BEL C6LUT [get_cells {apuf_driver/APUF_TEST_UNIT/FIRST_SWITCH_BLOCK/EQUAL_PATHS[1].EQUAL_PATH_MUX/Q_INST_0}]
    set_property LOC SLICE_X$(X)Y$(Y) [get_cells {apuf_driver/APUF_TEST_UNIT/FIRST_SWITCH_BLOCK/EQUAL_PATHS[1].EQUAL_PATH_MUX/Q_INST_0}]
    set_property BEL B6LUT [get_cells {apuf_driver/APUF_TEST_UNIT/FIRST_SWITCH_BLOCK/EQUAL_PATHS[2].EQUAL_PATH_MUX/Q_INST_0}]
    set_property LOC SLICE_X$(X)Y$(Y) [get_cells {apuf_driver/APUF_TEST_UNIT/FIRST_SWITCH_BLOCK/EQUAL_PATHS[2].EQUAL_PATH_MUX/Q_INST_0}]
    set_property BEL A6LUT [get_cells {apuf_driver/APUF_TEST_UNIT/FIRST_SWITCH_BLOCK/EQUAL_PATHS[3].EQUAL_PATH_MUX/Q_INST_0}]
    set_property LOC SLICE_X$(X)Y$(Y) [get_cells {apuf_driver/APUF_TEST_UNIT/FIRST_SWITCH_BLOCK/EQUAL_PATHS[3].EQUAL_PATH_MUX/Q_INST_0}]
    """
end

Y = map(n->string(n), 23:-1:1)
X = "66"
I = map(n->string(n), 1:23)

println(first_switch_block_constraint(X, "24"))

for i in 1:23
    println(switch_block_constraint(I[i], X, Y[i]))
end
