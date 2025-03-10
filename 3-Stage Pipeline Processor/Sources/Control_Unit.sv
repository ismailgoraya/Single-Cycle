module Control_Unit(
	input logic clk, rst,
	input logic reg_wr_in, wr_en_in, rd_en_in,
	input logic [1:0] wb_sel_in,
	output logic reg_wr_out, wr_en_out, rd_en_out,
	output logic [1:0] wb_sel_out
);

	always_ff @ (posedge clk) begin
		if (rst) begin
			reg_wr_out <= 1'b0;
			wr_en_out <= 1'b0;
			rd_en_out <= 1'b0;
			wb_sel_out <= 2'b0;
		end
		else begin
			reg_wr_out <= reg_wr_in;
			wr_en_out <= wr_en_in;
			rd_en_out <= rd_en_in;
			wb_sel_out <= wb_sel_in;
		end
	end
	
endmodule