module PC(
	input logic clk, rst, br_taken,
	input logic [31:0] ALU_result_e,
	output logic [31:0] PCplus4, PC_out
);
	
	assign PCplus4 = br_taken ? ALU_result_e : PC_out + 4;

	always_ff @(posedge clk) begin
		if (rst)
			PC_out <= 32'b0;
		else
			PC_out <= PCplus4;
	end
endmodule