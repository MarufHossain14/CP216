/*
-------------------------------------------------------
l08_t02.s
-------------------------------------------------------
Author: Mohammed Maruf Hossain
ID: 169046996
Email: hoss6996@mylaurier.ca
Date:    2025-03-21
-------------------------------------------------------
Uses a subroutine to read strings from the UART into memory.
-------------------------------------------------------
*/
// Constants
.equ SIZE, 20 // Size of string buffer storage (bytes)

.org 0x1000   // Start at memory location 1000
.text         // Code section
.global _start
_start:

//=======================================================

ldr r5, =SIZE      // Load size of the buffer

//=======================================================

ldr    r4, =First
bl    ReadString
ldr    r4, =Second
bl    ReadString
ldr    r4, =Third
bl     ReadString
ldr    r4, =Last
bl     ReadString

_stop:
b _stop

// Subroutine constants
.equ UART_BASE, 0xff201000  // UART base address
.equ ENTER, 0x0A            // The enter key code
.equ VALID, 0x8000          // Valid data in UART mask

ReadString:
/*
-------------------------------------------------------
Reads an ENTER terminated string from the UART.
-------------------------------------------------------
Parameters:
  r4 - address of string buffer
  r5 - size of string buffer
Uses:
  r0 - holds character to print
  r1 - address of UART
-------------------------------------------------------
*/

//=======================================================

stmfd sp!, {r0, r1, r4, r5, r6}  // Preserve temporary registers
ldr   r1, =UART_BASE             // get address of UART
mov   r6, #0                     // iInitialize counter

rsLOOP:
ldr  r0, [r1]         // read the UART data register
tst  r0, #VALID       // check if there is new data
beq  rsEND            // if no data, exit subroutine
tst  r0, #ENTER       // check if the character is enter
beq  rsEND            // If enter then stop reading
strb r0, [r4], #1     // store the character in memory
add  r6, r6, #1       // increment counter
cmp  r6, r5           // compare counter with buffer size
beq  rsEND            // if buffer is full then... stop reading
b    rsLOOP

rsEND:
ldmfd sp!, {r0, r1, r4, r5, r6}  // recover temporary registers
//=======================================================

bx    lr                    // return from subroutine

.data
.align
// The list of strings
First:
.space  SIZE
Second:
.space SIZE
Third:
.space SIZE
Last:
.space SIZE
_Last:    // End of list address

.end