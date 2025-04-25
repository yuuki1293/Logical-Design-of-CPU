# Makefile for compiling Verilog files with iverilog

# Variables
TARGET = $(notdir $(CURDIR))
SRC = $(wildcard *.v)
SIM = $(TARGET)_sim

# Rules
all: $(SIM)

$(SIM): $(SRC)
	iverilog -o $(SIM) $(SRC)

run: $(SIM)
	vvp $(SIM)

open: run
	gtkwave $(TARGET).vcd

clean:
	rm -f $(SIM)