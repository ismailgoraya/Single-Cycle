module Forwarding_Unit (
	input logic reg_wr_w,
	input logic [31:0] instruction_e, instruction_w,
	output logic For_A, For_B
);
	logic [4:0] raddr1_e, raddr2_e, waddr_w;
	logic [6:0] opcode_e, opcode_w;
	
	assign raddr1_e = instruction_e[19:15];
    assign raddr2_e = instruction_e[24:20];
	assign waddr_w = instruction_w[11:7];
	assign opcode_e = instruction_e[6:0];
	assign opcode_w = instruction_w[6:0];

	always_comb begin
    	For_A = 1'b0;
    	For_B = 1'b0;
    
   		if ((reg_wr_w) && (opcode_w != 7'b0100011) && (opcode_w != 7'b1100011)) begin
        	if ((raddr1_e == waddr_w) && (opcode_e != 7'b0110111) && (opcode_e != 7'b1101111)) begin
                For_A = 1'b1;

            if ((raddr2_e == waddr_w) && (opcode_e != 7'b0010011) && (opcode_e != 7'b0000011))
                For_B = 1'b1;
        	end
    	end
	end

endmodule