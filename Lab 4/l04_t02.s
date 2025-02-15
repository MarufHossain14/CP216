/*
-------------------------------------------------------
l04_t01.s
-------------------------------------------------------
Author:  Mohamemd Maruf Hossain
ID:      169046996
Email:   hoss6996@mylaurier.ca
Date:    2/14/2025
-------------------------------------------------------
Counts the number of values in the list and the total 
number of bytes. Stores the count in r4 and byte size in r5.
r0: temp storage of value in list
r2: address of start of list
r3: address of end of list
r4: count of values
r5: total number of bytes
-------------------------------------------------------
*/
.org 0x1000  // Start at memory location 1000
.text        // Code section
.global _start
_start:

ldr    r2, =Data    // Load address of start of list
ldr    r3, =_Data   // Load address of end of list
mov    r4, #0       // Initialize count (r4 = 0)

Loop:
cmp    r2, r3       // Compare current address with end of list
beq    CalcBytes    // If at end, calculate bytes and stop

ldr    r0, [r2], #4 // Load value from list and increment address
add    r4, r4, #1   // Increment count
b      Loop         // Repeat loop

CalcBytes:
sub    r5, r3, r2   // Calculate number of bytes in list (r5 = end - start)
add    r5, r5, #4   // Adjust for last read offset

_stop:
b _stop

.data
.align
Data:
.word   4,5,-9,0,3,0,8,-7,12   // The list of data
_Data: // End of list address

.end

