/*
-------------------------------------------------------
l04_t01.s
-------------------------------------------------------
Author:  Mohamemd Maruf Hossain
ID:      169046996
Email:   hoss6996@mylaurier.ca
Date:    2/14/2025
-------------------------------------------------------
Finds the minimum and maximum values in the list and 
stores them in r6 (min) and r7 (max).
r0: temp storage of value in list
r2: address of start of list
r3: address of end of list
r6: minimum value
r7: maximum value
-------------------------------------------------------
*/
.org 0x1000  // Start at memory location 1000
.text        // Code section
.global _start
_start:

ldr    r2, =Data    // Load address of start of list
ldr    r3, =_Data   // Load address of end of list
ldr    r6, [r2], #4 // Initialize min with first value
mov    r7, r6       // Initialize max with first value

Loop:
cmp    r2, r3       // Compare current address with end of list
beq    _stop        // If at end, stop

ldr    r0, [r2], #4 // Load value from list and increment address

cmp    r0, r6       // Compare value with min
movlt  r6, r0       // If less than current min, update min

cmp    r0, r7       // Compare value with max
movgt  r7, r0       // If greater than current max, update max

b      Loop         // Repeat loop

_stop:
b _stop

.data
.align
Data:
.word   4,5,-9,0,3,0,8,-7,12   // The list of data
_Data: // End of list address

.end


