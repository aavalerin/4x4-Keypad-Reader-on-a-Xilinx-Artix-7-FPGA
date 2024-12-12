`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.10.2024 18:34:50
// Design Name: 
// Module Name: SlowClock1kHz
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



module Slow_Clock_1kHz(
    input clk_in, // 100MHz de la basys
    output reg clk_out // 1kHz
);


    reg [17:0] count = 0;  // Contador de 18 bits para almacenar los ciclos
    
    always @(posedge clk_in) begin
        count <= count + 1;  // Incrementar el contador en cada flanco de subida del reloj
        
        if (count == 49_999) begin
            count <= 0;         // Reiniciar el contador
            clk_out <= 1; // Invertir la señal de salida para generar el reloj dividido
         end else begin
            clk_out<=0; 
         end 
    end 
endmodule