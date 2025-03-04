module Branch_Condition (
    input logic [2:0] br_type,
    input logic [31:0] rdata1, rdata2,
    output logic br_taken
);

    always_comb begin
        case (br_type)
            3'b000: br_taken = 0;   // No Operation
            3'b001: br_taken = (rdata1 == rdata2);  // Branch Equal
            3'b010: br_taken = (rdata1 != rdata2);  // Branch Not Equal
            3'b011: br_taken = ($signed(rdata1) < $signed(rdata2));  // Branch Less Then
            3'b100: br_taken = ($signed(rdata1) >= $signed(rdata2)); // Branch Greater or Equal
            3'b101: br_taken = (rdata1 < rdata2);   // Branch Less Then Unsigned
            3'b110: br_taken = (rdata1 >= rdata2);  // Branch Greater or Equal Unsigned
            3'b111: br_taken = 1;         // Unconditional Jump
            default: br_taken = 0;        // Default case
        endcase
    end

endmodule
