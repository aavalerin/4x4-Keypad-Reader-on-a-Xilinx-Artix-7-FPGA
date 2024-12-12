`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.10.2024 08:25:31
// Design Name: 
// Module Name: KeyLecture
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


module KeyLecture(
    input wire clk,            // Reloj del sistema
    input wire rst,            // Señal de reinicio
    input wire [3:0] keypad_rows,     // Filas del teclado (entrada)
    output reg [3:0] keypad_cols,     // Columnas del teclado (salida)
    output reg flag,           // Indica cuando un nuevo valor está disponible
    output reg [3:0] key_value // Valor de la tecla presionada
    
);

    wire clk_1kHz;  // Reloj a 1 kHz
    wire pulse_500Hz; // Reloj a 100 Hz

    reg [1:0] state; // Contador de estado para las columnas
    
    // Instancia de los relojes lentos
    Slow_Clock_1kHz ClockLento1kHz(clk, clk_1kHz);
    /*Slow_Clock_500Hz ClockLento500Hz(clk, clk_500Hz);*/

    
    Slow_Clock_500Hz Pulse10nsEvery500Hz (
        .clk(clk),
        .rst(rst),
        .Enablesignal(pulse_500Hz)
    );
    defparam Pulse10nsEvery500Hz.COUNTER_WIDTH = 17;
    defparam Pulse10nsEvery500Hz.ComparatorNumber = 100_000;
    
    
    // Instancias de los debouncers
    wire [3:0] row_sinc;
    Debouncing d1(keypad_rows[3], clk,rst, clk_1kHz, row_sinc[3]);
    Debouncing d2(keypad_rows[2], clk, rst,clk_1kHz, row_sinc[2]);
    Debouncing d3(keypad_rows[1], clk, rst, clk_1kHz, row_sinc[1]);
    Debouncing d4(keypad_rows[0], clk, rst, clk_1kHz, row_sinc[0]);

    // Always block para cambiar las columnas (cols) con el reloj de 100Hz
    always @(posedge clk ) begin
        if (rst) begin
            keypad_cols <= 4'b0000;  // Reiniciar columnas
            state <= 2'b00;   // Reiniciar estado
        end else if(pulse_500Hz) begin
            case(state)
                2'b00: keypad_cols <= 4'b0001; // Activar columna 0
                2'b01: keypad_cols <= 4'b0010; // Activar columna 1
                2'b10: keypad_cols <= 4'b0100; // Activar columna 2
                2'b11: keypad_cols <= 4'b1000; // Activar columna 3
            endcase

            // Reiniciar el estado si es 2'b11, de lo contrario incrementar
            if (state == 2'b11) begin
                state <= 2'b00; // Reiniciar a 2'b00
            end else begin
                state <= state + 1'b1; // Incrementar estado
            end
        end
    end

    // Instancia del decodificador
    wire [3:0] decoded_value; // Salida del decodificador
    
    Decoder myDecoder (
        .row_sinc(row_sinc),   // Entrada sincronizada de filas
        .cols(keypad_cols),   // Entrada de las columnas (columna activa)
        .valor(decoded_value)  // Valor decodificado de la tecla presionada
    );

    // Always block para gestionar pressed_key y key_value
    
    reg lastpressed= 1'b0;
    reg pressed_key=1'b0;
    // Continuous assignment implementation of pressed_key
    // assign pressed_key = (row_sinc != 4'b0000);
    always @(posedge clk ) begin
        if (rst) begin
            key_value <= 4'b0000; 
            lastpressed<=1'b0;    // Reiniciar key_value
        end else begin
            
            if(row_sinc != 4'b0000)begin
                pressed_key<=1'b1;
            end else begin
                pressed_key<=1'b0;
            end 
            if (!lastpressed && pressed_key) begin
                key_value <= decoded_value;   // Guardar el valor de la tecla 
                flag<=1'b1;
            end else begin
                flag<=1'b0;
 
            end
            lastpressed<= pressed_key;
            
           // No  se está presionando ninguna tecla
        end
    end


endmodule
