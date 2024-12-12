`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Aaron Valerin
// 
// Create Date: 14.10.2024 18:34:50
// Design Name: 
// Module Name: Decoder
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module Decoder (
    input [3:0] row_sinc, // Entrada del sincronizador de filas
    input [3:0] cols,     // Entrada de las columnas
    output reg [3:0] valor // Salida de 4 bits con el valor correspondiente
    );

always @(*) begin
    if(row_sinc!=4'b0000)begin
        if(row_sinc == 4'b0001)begin
            case (cols)
                4'b0001: valor[3:0] <= 4'b0001;  // 1
                4'b0010: valor[3:0] <= 4'b0010;  // 2
                4'b0100: valor[3:0] <= 4'b0011;  // 3
                default: valor[3:0] <= 4'b1010;  // A
            endcase
        end else if(row_sinc == 4'b0010)begin
            case (cols)
                4'b0001: valor[3:0] <= 4'b0100;  // 4
                4'b0010: valor[3:0] <= 4'b0101;  // 5
                4'b0100: valor[3:0] <= 4'b0110;  // 6
                default: valor[3:0] <= 4'b1011;  // B
            endcase
        end else if(row_sinc == 4'b0100)begin
            case (cols)
                4'b0001: valor[3:0] <= 4'b0111;  // 7
                4'b0010: valor[3:0] <= 4'b1000;  // 8
                4'b0100: valor[3:0] <= 4'b1001;  // 9
                default: valor[3:0] <= 4'b1100;  // C
            endcase
        end else begin
            case (cols)
                4'b0001: valor[3:0] <= 4'b1111;  // * (CLR)
                4'b0010: valor[3:0] <= 4'b0000;  // 0
                4'b0100: valor[3:0] <= 4'b1110;  // # (=)
                default: valor[3:0] <= 4'b1101;  // D
            endcase
        end
    
    end 
   else begin
       valor[3:0] <= 4'b0000;  // 0. TODO: select a proper output when no row is seleted
   end
end


endmodule
