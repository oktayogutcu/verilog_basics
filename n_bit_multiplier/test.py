import sys
import subprocess
import atexit
from random import randint
from random import seed
import matplotlib as plt
from vcd import tokenize

subprocess.call("iverilog -o test_bench_tb.vvp ./sim/n_bit_mul_tb.v ./src/n_bit_mul.v ./src/ha.v", shell=True)

subprocess.call("vvp test_bench_tb.vvp", shell=True)

subprocess.call("open -a gtkwave waveform.vcd", shell=True)

