import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge
from cocotb.triggers import FallingEdge
from cocotb.triggers import Timer

# period must be in nanoseconds
async def clock_coroutine(clk, period):

    # generate a clock
    cocotb.start_soon(Clock(clk, 10, units="ns").start())

# duration must be in nanoseconds
async def reset_coroutine(rst, duration):
    rst.value = 1
    await Timer(duration, units='ns')
    rst.value = 0
 
@cocotb.test()
async def fifo_test(dut):

    cocotb.start_soon(clock_coroutine(dut.clk, 10))
    
    await reset_coroutine(dut.rst,50)
    
    wr_en = True
    dut.wr_en.value = 0
    dut.rd_en.value = 0
    
    for i in range(64):
        await RisingEdge(dut.clk)
        if(wr_en):
            wr_en = False
            dut.wr_en.value = 1
            dut.din.value = i
            print('Data Count: ' + str(dut.data_count.value) + '\t Written Value: ' + str(dut.din.value))
        else:
            wr_en = True
            dut.wr_en.value = 0
            
    await Timer(200, units='ns')
    
    rd_en = True
    for i in range(64):
        await RisingEdge(dut.clk)
        if(rd_en):
            rd_en = False
            dut.rd_en.value = 1
            print('Data Count: ' + str(dut.data_count.value) + 'Read Value: ' + str(dut.dout.value))
        else:
            rd_en = True
            dut.rd_en.value = 0
