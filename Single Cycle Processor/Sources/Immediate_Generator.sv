module Immediate_Generator (
    input logic [31:0] instruction,
    output logic [31:0] sign_extended
);
    logic [6:0] opcode;
    assign opcode = instruction[6:0];

    always_comb begin 
        case (opcode)
            7'b0110011: sign_extended = 32'b0;  // R-Type (No Immediate) 
            7'b0010011: sign_extended = {{20{instruction[31]}}, instruction[31:20]}; // I-Type 
            7'b0000011: sign_extended = {{20{instruction[31]}},instruction[31:20]}; // I-Type (Load)
            7'b0100011: sign_extended = {{20{instruction[31]}}, instruction[31:25], instruction[11:7]};  // S-Type
            7'b1100011: sign_extended = {{19{instruction[31]}}, instruction[31], instruction[7], instruction[30:25], instruction[11:8], 1'b0};  // B-Type
            7'b0110111: sign_extended = {instruction[31:12], 12'b0}; // U-Type (LUI)
            7'b0010111: sign_extended = {instruction[31:12], 12'b0}; // U-Type (AUIPC)
            7'b1101111: sign_extended = {{11{instruction[31]}}, instruction[31], instruction[19:12], instruction[20], instruction[30:21], 1'b0}; // J-Type
            7'b1100111: sign_extended = {{20{instruction[31]}},instruction[31:20]}; // JALR
            default: sign_extended = 32'b0;  // Default Case
        endcase
        
    end
endmodule
 