/*
-------------------------------------------------------
l08_t03.s
-------------------------------------------------------
Author: Mohammed Maruf Hossain
ID: 169046996
Email: hoss6996@mylaurier.ca
Date:    2025-03-21
-------------------------------------------------------
Uses a subroutine to read strings from the UART into memory.
-------------------------------------------------------
*/
.org 0x1000   // Start at memory location 1000
.text         // Code section
.global _start
_start:

bl    EchoString

_stop:
b _stop

// Subroutine constants
.equ UART_BASE, 0xff201000  // UART base address
.equ VALID, 0x8000          // Valid data in UART mask
.equ ENTER, 0x0A            // The enter key code

EchoString:
/*
-------------------------------------------------------
Echoes a string from the UART to the UART.
-------------------------------------------------------
Uses:
  r0 - holds character to print
  r1 - address of UART
-------------------------------------------------------
*/

//=======================================================

stmfd sp!, {r0, r1}  // perserve temporary registers
ldr   r1, =UART_BASE // get address of UART

echoLOOP:
ldr  r0, [r1]        // read the UART dataregister
tst  r0, #VALID      // check if there is new data
beq  echoLOOP        // if no data, continue loop
tst  r0, #ENTER      // Check if the character is ENTER
beq  echoEND         // if ENTER, end loop
strb r0, [r1]        // write the character to  the UART
b    echoLOOP 
 
echoEND:
ldmfd sp!, {r0, r1}  // recover temporary registers  
//=======================================================


bx    lr               // return from subroutine

.end