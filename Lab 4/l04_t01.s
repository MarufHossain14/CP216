/*
-------------------------------------------------------
l04_t01.s
-------------------------------------------------------
Author:  Mohamemd Maruf Hossain
ID:      169046996
Email:   hoss6996@mylaurier.ca
Date:    2/14/2025
-------------------------------------------------------
Calculates the sum of all values in the list and 
stores the result in r1.
r0: temp storage of value in list
r1: sum of all values
r2: address of start of list
r3: address of end of list
-------------------------------------------------------
*/
.org 0x1000  // Start at memory location 1000
.text        // Code section
.global _start
_start:

ldr    r2, =Data    // Load address of start of list
ldr    r3, =_Data   // Load address of end of list
mov    r1, #0       // Initialize sum (r1 = 0)

Loop:
cmp    r2, r3       // Compare current address with end of list
beq    _stop        // If at end, stop

ldr    r0, [r2], #4 // Load value from list and increment address
add    r1, r1, r0   // Add value to sum
b      Loop         // Repeat loop

_stop:
b _stop

.data
.align
Data:
.word   4,5,-9,0,3,0,8,-7,12   // The list of data
_Data: // End of list address

.end
