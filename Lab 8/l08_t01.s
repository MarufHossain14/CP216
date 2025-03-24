/*
-------------------------------------------------------
l08_t01.s
-------------------------------------------------------
Author: Mohammed Maruf Hossain
ID: 169046996
Email: hoss6996@mylaurier.ca
Date:    2025-03-21
-------------------------------------------------------
Uses a subroutine to write strings to the UART.
-------------------------------------------------------
*/
.org 0x1000  // Start at memory location 1000
.text        // Code section
.global _start
_start:

ldr r4, =First
bl  WriteString
ldr r4, =Second
bl  WriteString
ldr r4, =Third
bl  WriteString
ldr r4, =Last
bl  WriteString

_stop:
b    _stop

// Subroutine constants
.equ UART_BASE, 0xff201000  // UART base address

//=======================================================

.equ ENTER, 0x0A            // Define the ENTER character

//=======================================================

WriteString:
/*
-------------------------------------------------------
Writes a null-terminated string to the UART, adds ENTER.
-------------------------------------------------------
Parameters:
  r4 - address of string to print
Uses:
  r0 - holds character to print
  r1 - address of UART
-------------------------------------------------------
*/

//=======================================================

stmfd sp!, {r0, r1, r4}  // preserve temporary registers
ldr   r1, =UART_BASE     // Get address of UART

wsLOOP:
ldrb  r0, [r4], #1       // loadd a single byte from the string
cmp   r0, #0
beq   wsEND              // stop when the null character is found
str   r0, [r1]           // copy thet character to theUART DATA field
b     wsLOOP
wsEND:
mov   r0, #ENTER         // load ENTER character
str   r0, [r1]           // send ENTER character to UART
ldmfd sp!, {r0, r1, r4}  // Recover temporary registers 

//=======================================================

bx    lr                

.data
.align
// The list of strings
First:
.asciz  "First string"
Second:
.asciz  "Second string"
Third:
.asciz  "Third string"
Last:
.asciz  "Last string"
_Last:    // End of list address

.end