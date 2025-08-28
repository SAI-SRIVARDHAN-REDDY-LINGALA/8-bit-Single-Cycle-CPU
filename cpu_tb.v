// ============================================================================
// cpu_tb.v
// Testbench for the 8-bit Single-Cycle CPU with waveform dump (GTKWave)
// ============================================================================
`timescale 1ns/1ps

module cpu_tb;

    reg clk;
    reg rst;

    // Instantiate CPU
    cpu uut (
        .clk(clk),
        .rst(rst)
    );

    // Clock generation (10ns period -> 100MHz)
    always #5 clk = ~clk;

    // Monitor signals inside CPU
    initial begin
        $display("Time\tPC\tInstr\tOpcode\tR0\tR1\tR2\tR3");
        $monitor("%0t\t%h\t%h\t%h\t%h\t%h\t%h\t%h",
                  $time,
                  uut.pc,
                  uut.instr,
                  uut.opcode,
                  uut.RF.registers[0],
                  uut.RF.registers[1],
                  uut.RF.registers[2],
                  uut.RF.registers[3]
        );
    end

    // Dump signals for GTKWave
    initial begin
        $dumpfile("cpu.vcd");   // VCD file name
        $dumpvars(0, cpu_tb);   // Dump everything in testbench + hierarchy
    end

    // Reset sequence
    initial begin
        clk = 0;
        rst = 1;
        #10 rst = 0;
    end

    // Stop simulation on HALT
    always @(posedge clk) begin
        if (uut.halted) begin
            $display("CPU halted at time %0t, PC=%h", $time, uut.pc);
            $finish;
        end
    end

    // Timeout safeguard (if HALT never reached)
    initial begin
        #500;
        $display("Simulation finished (timeout).");
        $finish;
    end

endmodule
