`timescale 1ns/1ps

module tb_mult;

    reg clk;
    reg rst_n;
    reg [3:0] a;
    reg [3:0] b;
    wire [7:0] p;

    integer i;
    integer j;
    integer errors;
    integer vectors;

    reg [3:0] expected_a;
    reg [3:0] expected_b;
    reg [7:0] expected_p;

    // Instantiate the multiplier
    mult_array dut (
        .clk(clk),
        .rst_n(rst_n),
        .a(a),
        .b(b),
        .p(p)
    );

    // ============================================
    // 10 ns clock
    // ============================================

    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end

    // ============================================
    // Waveform generation
    // ============================================

    initial begin
        $dumpfile("mult.vcd");
        $dumpvars(0, tb_mult);
    end

    // ============================================
    // Test
    // ============================================

    initial begin

        errors = 0;
        vectors = 0;

        a = 4'b0000;
        b = 4'b0000;

        // ----------------------------------------
        // Reset for first 2 clock cycles
        // ----------------------------------------

        rst_n = 1'b0;

        repeat (2)
            @(posedge clk);

        rst_n = 1'b1;

        // ----------------------------------------
        // Test all 256 combinations
        // ----------------------------------------

        for (i = 0; i < 16; i = i + 1) begin

            for (j = 0; j < 16; j = j + 1) begin

                // Apply input
                a = i;
                b = j;

                expected_a = i;
                expected_b = j;
                expected_p = expected_a * expected_b;

                // Wait for 2-cycle latency
                @(posedge clk);
                @(posedge clk);

                #1;

                vectors = vectors + 1;

                if (p !== expected_p) begin
                    $display(
                        "MISMATCH: a=%0d b=%0d expected=%0d got=%0d",
                        expected_a,
                        expected_b,
                        expected_p,
                        p
                    );

                    errors = errors + 1;
                end

            end

        end

        // ----------------------------------------
        // Final result
        // ----------------------------------------

        if (errors == 0) begin
            $display("PASS: 256 vectors checked, 0 errors");
        end
        else begin
            $display(
                "FAIL: 256 vectors checked, %0d errors",
                errors
            );
        end

        $finish;

    end

endmodule
