# 4x4-Keypad-Reader-on-a-Xilinx-Artix-7-FPGA
This implementation allows reading a 4x4 keypad without an external IC encoder (like the 74C922/23). It performs the same function as the IC, but in a simpler form. This module can be used in various projects, such as a calculator. A detailed explanation is provided in the README file.







# How it works


External Connections:

This is a common implementation for keypads, and if you have been researching this topic for some time, you are likely aware that the most common approach involves using either the rows or columns as inputs to the microcontroller, with the remaining lines used as outputs. The lines configured as inputs (in my case, the rows) require pull-down resistors (alternatively, pull-up resistors can be used, but this would reverse the logic of the entire module). The output lines should be connected directly to the microcontroller board, or in our case, to a Field-Programmable Gate Array (FPGA).

NOTE: For this particular implementation, I used the Basys 3 Xilinx Artix-7 FPGA

Module Parts:

Diagrams: There is a PDF with all the diagrams explained, named "KeyReaderDesignDiagrams," if you want to check it out. It's pretty cool! I made it on Proteus because it was part of the full documentation of a larger project I had to complete in a Lab course. However, the explanation there is in Spanish. So, here's a quick explanation of how it works:

There are three main parts: Control of the Output Columns, Debouncing of the Row Input Signals, and the Decoder for the Button Pressed.

Control of the Output Columns: This part is a sequential circuit/design. It basically turns on/off each column one at a time at a specific frequency of 500Hz. This module is always active.

Debouncing of the Row Input Signals: The debouncer is also a sequential circuit and is a very common design found in almost every Digital Electronics textbook or tutorial. What it does is manage the signal from a physical switch at a lower frequency, converting a noisy signal into a clean, stable signal. If you're not familiar with it, you should check it out on YouTube—there are great explanations available. This module detects a clear "1" for each input row at a frequency of 1kHz.

Decoder for the Button Pressed: This is essentially a simple if/else logic system. Given a specific row and column number, it returns which key was pressed ("1,2,3,4,5,6,7,8,9,A,B,C,D,*,#"). This module is combinational and really simple.

The key to everything working together and the timing is that when a key is pressed, human reaction time is obviously slow. So, at some point, the output columns match and generate a row 1 signal. Because the debouncer system operates at a faster speed (1kHz), it gives a clean signal for the row while the column has not yet changed (500Hz). At this specific point, the combinational result from the decoder is captured and saved in a D Flip-Flop, which functions as memory.



# Generate Bitstream
If you have a Basys 3 board and a keypad with pull-down resistors on its rows, you can directly generate a bitstream using the "constraintsKeyReader.xcd" file. Just make sure to use the Pmod B pins on the board (check the FPGA manual for details) and follow this table/schematic:
||col [0] / C16|col [1] / C15|col [2] / A17|col [3] / A15|
|---|---|---|---|---|
|row [0] / A14 | 1 | 2 | 3 | A |
|row [1] / A16| 4 | 5 | 6 | B |
|row [2] / B15| 7 | 8 | 9 | C |
|row [3] / B16| # | 0 | * | D |


Note: This can be confusing, as keypads may have different numbering and labels depending on the model you have, so be cautious. If the rows and columns aren’t connected to the FPGA as specified, the decoder module might output incorrect values, such as showing "D" when you press "1."

When using the Basys3 board, you will notice that this connection is simple, intuitive, and easy to follow.


With that being said, I hope you find it useful. Let me know if there's anything I can improve. Of course, in a larger project, this could be used with memory systems and other components. This is just a way to avoid buying the IC. :)


# Contact

 Feel free to contact me at: 

    06aaronvalerin@gmail.com

