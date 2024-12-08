# Memory-Bus Project
### VHDL Project - Development of a communication bus to a simplified 16x16bit memory RAM block

<br />

This project consists of an entity development centered on a bus communication to a RAM block, where the address is specified through a 4bit logic vector (values range from 0000 to 1111, or 0x0 to 0xF - 16 values), and two ports dedictated to the interaction with the RAM:
- Port A ('addra' address, 'dina' data and 'clka' clock): Meant for writing to the memory block when 'wea' or WRITE-ENABLE A is activated.
- Port B ('addrb' address, 'doutb' data and 'clkb' clock): Meant for reading from the memory block when WRITE-ENABLE A is deactivated.

<br />

The bus is in charge of communicating with the memory given the restrictions above specified, and through another CLK local signal or 'bus_clk'. For the bus entity specification, we have the following signals:
- 'wrfb' or WRITE-FILE BIT : When set to 0, the 'data_in' string (ranging from 0x0000 to 0xFFFF) is written to the memory direction in 'addrv'; when set to 1 the data is read into 'data_out' from port B and with address specified from 'addrv'.
- 'csfb' or CHIP-SELECT BIT : When set to 0, means the current chip is selected (must be always 0 for operating with the given SoC). When set to 1, the chip is not selected.
- 'ackb' or ACKNOWLEDGE BIT : Set to 1 when operations are still being performed. 0 when current operations have been finished.

<br />

Also important to note the commands specified for the autonomous bus transactions come from a pseudo code VHDL file (.txt file) with the instructions detailed. One description that would be valid for this project would be the following:

<br />

"
     
WRITE 08 EF54 <br />
READ  08 EF54 <br />
WRITE 12 AAA5 <br />
READ  12 AAA5 <br />
END   
"


Where the instructions are composed always of 5 CHARACTERS (included the "END  "), the memory addresses (specified as integers ranging from 00 to 15) are also consisted of 2 CHARACTERS, and finally the data to be written to the location is further composed of 4 CHARACTERS (ranging from 0000 to FFFF).

<br />

The final result of the process developed is shown below:

<br />

![Captura de pantalla 2024-12-05 125347](https://github.com/user-attachments/assets/4cd4a7ef-a4cb-4d0a-808e-959a22e26b84)


