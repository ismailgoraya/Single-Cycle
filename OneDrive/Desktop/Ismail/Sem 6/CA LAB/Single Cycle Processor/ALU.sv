module ALU(
	input logic [3:0] alu_op,
	input logic [31:0] operand1, operand2,
	output logic [31:0] Output
);

	always_comb begin
        case (alu_op)
            4'b0000: Output = operand1 + operand2; // Addition
            4'b0001: Output = operand1 - operand2; // Subtraction
            4'b0010: Output = operand1 << operand2[4:0]; // Shift Left Logical
            4'b0011: Output = operand1 >> operand2[4:0]; // Shift Right Logical
            4'b0100: Output = $signed(operand1) >>> operand2[4:0]; // Shift Right Arithmatic
            4'b0101: Output = ($signed(operand1) < $signed(operand2)) ? 1 : 0; // Set Less Then
            4'b0110: Output = (operand1 < operand2) ? 1 : 0; // Set Less Then Unsigned
            4'b0111: Output = operand1 ^ operand2; // XOR
            4'b1000: Output = operand1 | operand2; // OR
            4'b1001: Output = operand1 & operand2; // AND
            4'b1010: Output = operand2; // Just Pass operand2
            default: Output = 32'b0;    // Default Case
        endcase
    end

endmodule