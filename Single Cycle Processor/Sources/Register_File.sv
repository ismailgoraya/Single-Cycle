module Register_File(
	input logic clk, reg_wr,
	input logic [4:0] raddr1, raddr2, waddr, 
	input logic [31:0] wdata,
	output logic [31:0] rdata1, rdata2
);

	logic [31:0] registers [0:31];  // 32 registers each of 32 bit

    assign rdata1 = registers[raddr1];
	assign rdata2 = registers[raddr2];

	always_ff @(negedge clk) begin
		registers[0] <= 32'b0;
		if (reg_wr)
			registers[waddr] <= wdata;
	end
    
endmodule