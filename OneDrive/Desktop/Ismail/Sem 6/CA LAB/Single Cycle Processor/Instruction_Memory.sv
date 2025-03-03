module Instruction_Memory(
	input logic [31:0] Address,
	output logic [31:0] instruction
);
	
	logic [31:0] memory [0:1023]; // 4kb of Instruction Memory

	assign instruction = memory[Address[11:2]];

endmodule