# Simple tests for an counter module
import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge
from cocotb.triggers import FallingEdge
from cocotb.triggers import Timer

# period must be in nanoseconds
async def clock_coroutine(clk, period):
    # clk.value = 0
    # await Timer(period, units='ns')
    
    # generate a clock
    cocotb.start_soon(Clock(clk, 10, units="ns").start())
    
# duration must be in nanoseconds
async def reset_coroutine(rst, duration):
    rst.value = 1
    await Timer(duration, units='ns')
    rst.value = 0
 
# changing direction to up, down and the idle  
async def updown_direction_coroutine(dut):
    dut.direction.value = 0
    direction_counter = 0
    # await FallingEdge(dut.reset)
    while(True):
        if(direction_counter < 16):
            dut.direction.value = 1
        elif(direction_counter < 32):
            dut.direction.value = -1
        else:
            dut.direction.value = 0
            direction_counter = 0
        await RisingEdge(dut.clk)
        direction_counter += 1

@cocotb.test()
async def up_count_test(dut):
    
    dut.direction.value = 1
    
    cocotb.start_soon(clock_coroutine(dut.clk, 10))
    
    await reset_coroutine(dut.reset, 50)

    # run for 50 clock cycle
    for cnt in range(50): 
        await RisingEdge(dut.clk)
        v_count = dut.count.value
        mod_cnt = cnt % 16
        assert v_count.integer == mod_cnt, "counter result is incorrect: %s != %s" % (str(dut.count.value), mod_cnt)

@cocotb.test()       
async def down_count_test(dut):
    
    dut.direction.value = -1
    
    cocotb.start_soon(clock_coroutine(dut.clk, 10))
    
    # reset the module
    await reset_coroutine(dut.reset, 50)

    # run for 50 clock cycle
    for cnt in range(50):
        await RisingEdge(dut.clk)
        v_count = dut.count.value
        mod_cnt = (16 - (cnt % 16)) % 16
        assert v_count.integer == mod_cnt, "counter result is incorrect: %s != %s" % (str(dut.count.value), mod_cnt)

@cocotb.test()
async def updown_count_test(dut):
    # generate a clock
    cocotb.start_soon(clock_coroutine(dut.clk, 10))
    dut.direction.value = 0
    
    # reset the module
    await reset_coroutine(dut.reset, 50)
    
    # set direction signal for counting all directions
    cocotb.start_soon(updown_direction_coroutine(dut))

    # run for 50 clock cycle
    compareVal = 0
    for cnt in range(50):
        await RisingEdge(dut.clk)
        mod_cnt = compareVal % 16
        v_count = dut.count.value
        # print("mod_c" + str(mod_cnt))
        # print("v_count" + str(v_count.integer))
        assert v_count.integer == mod_cnt, "counter result is incorrect: %s != %s" % (str(dut.count.value), mod_cnt)
        
        if(dut.direction == 1):
            compareVal += 1 
        elif(dut.direction == 3):
            compareVal -= 1
        else:
            compareVal = compareVal
