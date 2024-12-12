`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.10.2024 19:02:27
// Design Name: 
// Module Name: Slow_Clock_500Hz
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


module Slow_Clock_500Hz
#( parameter COUNTER_WIDTH = 8,parameter ComparatorNumber = 100) 
(
    input clk,
    input rst,
    output reg Enablesignal // Única salida del módulo
);

    // Señales internas
    reg [COUNTER_WIDTH-1:0] ActualCounterNumber;  // Contador interno
    reg NumberReached;  // Bandera interna para cuando se alcanza el número de comparación
    reg EnableSignalInternal;  // Flip-Flop T integrado

    // Bloque always para la lógica principal
    always @(posedge clk) begin
        if (rst) begin
            // Reseteo de todas las señales cuando rst está activo
            Enablesignal <= 0;
            ActualCounterNumber <= {COUNTER_WIDTH{1'b0}};
            NumberReached <= 1'b0;
            EnableSignalInternal <= 1'b0; // Flip-Flop T reseteado
        end else begin
            // Manejo de EnableSignal
            Enablesignal <= EnableSignalInternal;

            // Actualización de ActualCounterNumber
            if (NumberReached) begin
                ActualCounterNumber <= {COUNTER_WIDTH{1'b0}};
            end else begin
                ActualCounterNumber <= ActualCounterNumber + 1'b1;
            end

            // Comparación de ComparatorNumber con ActualCounterNumber
            if (ActualCounterNumber == ComparatorNumber) begin
                NumberReached <= 1'b1;
            end else begin
                NumberReached <= 1'b0;
            end

            // Lógica del Flip-Flop T integrada
            if (NumberReached)
                EnableSignalInternal <= 1;
            else begin
                EnableSignalInternal <=0;
            end 
                
        end
    end
endmodule 

/*(
    input clk_in,   // 100Mhz de la basys
    output reg clk_out // 16Hz para controlar el tiempo de reloj
    );
    
    reg [18:0] count = 0;  // Contador de 18 bits para almacenar los ciclos
    
    always @(posedge clk_in) begin
        count <= count + 1;  // Incrementar el contador en cada flanco de subida del reloj
        
        if (count == 100_000) begin
            count <= 0;         // Reiniciar el contador
            clk_out <= 1; // Invertir la señal de salida para generar el reloj dividido
        end else begin 
            clk_out <= 0;
        end 
        
    end
        
endmodule */
