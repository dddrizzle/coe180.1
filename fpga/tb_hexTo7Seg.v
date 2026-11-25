`timescale 1ns / 1ps

module tb_hexTo7Seg;
    reg [3:0] in; //inputs
    reg E;

    wire [7:0] Y; //outputs

    hexTo7Seg uut ( // instantiate
        .in(in),
        .E(E),
        .Y(Y)
    );

    initial begin
        // Initialize inputs
        in = 4'b0000;
        E = 1'b0;

        // Wait for global reset
        #20;

        // check if switch is off
        E = 1'b0;
        in = 4'b0101; // Random input while disabled
        #20;

        // test all
        E = 1'b1;
        in = 4'b0000;
        
        repeat (16) begin
            #10;
            in = in + 1;
        end

        $finish;
    end
	 
    initial begin
        $monitor("Time=%0t | E=%b | in=%h | Y=%b", $time, E, in, Y);
    end

endmodule