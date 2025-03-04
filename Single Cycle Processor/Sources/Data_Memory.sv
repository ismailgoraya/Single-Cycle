module Data_Memory(
	input logic clk, wr_en, rd_en,
	input logic [31:0] address, wdata,
	output logic [31:0] rdata
);
	
	logic [31:0] memory [0:1023];
	
	always_ff @(negedge clk) begin
		if (wr_en)
			memory[address] <= wdata;
	end

	assign rdata = (rd_en) ? memory[address] : 32'b0;

endmodule