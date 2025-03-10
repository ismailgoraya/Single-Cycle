module DFF32bit (
	input logic clk, rst, 
	input logic [31:0] d,
	output logic [31:0] q
);

	always_ff @ (posedge clk) begin
		if (rst)
			q <= 32'b0;
		else
			q <= d;
	end
	
endmodule