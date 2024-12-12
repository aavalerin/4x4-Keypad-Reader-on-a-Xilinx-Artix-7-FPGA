`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.10.2024 18:31:51
// Design Name: 
// Module Name: D_FF
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

module D_FF(
    input clk,     // Clock que en nuestro caso le vamos a meter el lento
    input rst,     // Señal de reset
    input enable,  // Señal de habilitación
    input D,       // Botonazo o row en 0
    output reg Q,  
    output reg Qbar
);

    always @(posedge clk) begin
        if (rst) begin
            Q <= 0;        // Reiniciar a 0 cuando rst está activo
            Qbar <= 1;     // Qbar es el complemento de Q
        end else if(enable) begin
            Q <= D;        // Solo actualiza si enable está activo
            Qbar <= ~D;    // Qbar es el complemento de D
        end
    end

endmodule