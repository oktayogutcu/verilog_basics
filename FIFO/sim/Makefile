# This file is public domain, it can be freely copied without restrictions.
# SPDX-License-Identifier: CC0-1.0

# Makefile

# defaults
SIM ?= icarus
TOPLEVEL_LANG ?= verilog

VERILOG_SOURCES += $(PWD)/../src/fifo.v
# use VHDL_SOURCES for VHDL files

# export PARAM_FIFO_WIDTH := 8
# export PARAM_FIFO_DEPTH := 64


# TOPLEVEL is the name of the toplevel module in your Verilog or VHDL file
TOPLEVEL = fifo

# MODULE is the basename of the Python test file
MODULE = fifo_test

# COMPILE_ARGS= -P fifo.FIFO_WIDTH=8
# COMPILE_ARGS= -P fifo.FIFO_DEPTH=64
PARAMETERS += FIFO_WIDTH=8
PARAMETERS += FIFO_DEPTH=64

# include cocotb's make rules to take care of the simulator setup
include $(shell cocotb-config --makefiles)/Makefile.sim