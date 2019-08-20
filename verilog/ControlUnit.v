`include "alu_defines.vh"
`include "mips32_opcodes.vh" 

module ControlUnit(
    input [5:0] opc, //! Opcode
    input [5:0] func, //! Function
    output reg isJmp, //! Jump signal
    output reg isBeq, //! BEQ signal
    output reg isBne, //! BNE signal
    output reg [1:0] rfWriteDataSel, //! Register File Write Data Select
    output reg rfWriteAddrSel, //! Register File Write Address Select
    output reg rfWriteEnable, //! Register Write Enable
    output reg memWrite, //! Memory Write
    output reg memRead, //! Memory Read
    output reg aluSrc, //! ALU source
    output reg [2:0] aluFunc, //! ALU operation
    output reg bitXtend, //! Bit extension, 0 = sign extend, 1 = zero extend
    output reg invOpcode //! Invalid opcode or function
);


always @(*) begin
    
                    isJmp=1'bx; //! Jump signal
                isBeq=1'bx; //! BEQ signal
                isBne=1'bx; //! BNE signal
                rfWriteDataSel=2'bx; //! Register File Write Data Select
                rfWriteAddrSel=1'bx; //! Register File Write Address Select
                rfWriteEnable=1'bx; //! Register Write Enable
                memWrite=1'bx; //! Memory Write
                memRead=1'bx;//! Memory Read
                aluSrc=1'bx; //! ALU source
                aluFunc=3'bx; //! ALU operation
                bitXtend=1'bx; //! Bit extension, 0 = sign extend, 1 = zero extend
                

    case (opc)
        6'b0:   begin // INSTRUCCION R
                    case(func)
                        `MIPS_ADD:
                        begin 
                            rfWriteEnable=1'b1;
                            rfWriteAddrSel=1'b1;
                            aluSrc=1'b0;
                            aluFunc=`ALU_ADD;
                            rfWriteDataSel=2'b0;
                        end
                        `MIPS_SUB:
                        begin
                            rfWriteEnable=1'b1;
                            rfWriteAddrSel=1'b1;
                            aluSrc=1'b0;
                            aluFunc=`ALU_SUB;
                            rfWriteDataSel=2'b0;
                        end
                        `MIPS_AND:
                         begin
                            rfWriteEnable=1'b1;
                            rfWriteAddrSel=1'b1;
                            aluSrc=1'b0;
                            aluFunc=`ALU_AND;
                            rfWriteDataSel=2'b0;
                        end
                        `MIPS_OR:
                         begin
                            rfWriteEnable=1'b1;
                            rfWriteAddrSel=1'b1;
                            aluSrc=1'b0;
                            aluFunc=`ALU_OR;
                            rfWriteDataSel=2'b0;
                        end
                         `MIPS_SLT:
                         begin
                            rfWriteEnable=1'b1;
                            rfWriteAddrSel=1'b1;
                            aluSrc=1'b0;
                            aluFunc=`ALU_SLT;
                            rfWriteDataSel=2'b0;
                        end
                        
                    endcase
                end
        `MIPS_LW: begin 
                            rfWriteEnable=1'b1;
                            rfWriteAddrSel=1'b0;
                            aluSrc=1'b1;
                            aluFunc=`ALU_ADD;
                            rfWriteDataSel=2'b1;
                            memRead=1'b1;
                 end
        `MIPS_SW: begin 
                            
                            rfWriteAddrSel=1'b0;
                            aluSrc=1'b1;
                            aluFunc=`ALU_ADD;
                            rfWriteDataSel=2'b1;
                            memWrite=1'b1;
                 end

        `MIPS_BEQ: begin
                            rfWriteEnable=1'b0;    
                            aluSrc=1'b0;
                            aluFunc=`ALU_SUB;
                            bitXtend=1'b0;
                            isBeq=1'b1;
                   end 
        `MIPS_BNE: begin
                            rfWriteEnable=1'b0;    
                            aluSrc=1'b0;
                            aluFunc=`ALU_SUB;
                            bitXtend=1'b0;
                            isBne=1'b1;
                   end              
        `MIPS_JUMP: begin
                           
                            isJmp=1'b1;
                   end        
        default: begin
                 
                end
    endcase
end

endmodule
