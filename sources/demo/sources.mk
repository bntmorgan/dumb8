# Copyright (C) 2016  Benoît Morgan
#
# This file is part of dumb8.
#
# dumb8 is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# dumb8 is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with dumb8.  If not, see <http://www.gnu.org/licenses/>.

# sources here
#
# SRC_VERILOG_$(d) += $(d)/rtl/test.v 
# SRC_VERILOG_$(d) += $(CORES_DIR)/core/rtl/test.v 
#
# SRC_VHDL_$(d) += $(d)/rtl/test.vhd
# SRC_VHDL_$(d) += $(CORES_DIR)/cpt8/rtl/cpt8.vhd

SRC_VERILOG_$(d) += $(d)/rtl/system.v
SRC_VERILOG_$(d) += $(wildcard $(CORES_DIR)/d8/rtl/d8*.v)
SRC_VERILOG_$(d) += $(wildcard $(VGA_DIR)/rtl/vga*.v)
