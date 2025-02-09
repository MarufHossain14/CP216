/*
-------------------------------------------------------
intro.s
-------------------------------------------------------
Author:  Mohammed Maruf Hossain
ID:      169046996
Email:   hoss6996@mylaurier.ca
Date:    1/24/2025
-------------------------------------------------------
Assign to and add contents of registers.
-------------------------------------------------------
*/
.org 0x1000  // Start at memory location 1000
.text        // Code section
.global _start
_start:

// Task 1: Replace 0xE with 14 (decimal)
mov r0, #9       // Store decimal 9 in register r0
mov r1, #14      // Store decimal 14 in register r1
add r2, r1, r0  // Add the contents of r0 and r1 and put result in r2

// Task 2: Add r3 = r3 + r3
mov r3, #8       // Put the value 8 into register r3
add r3, r3, r3  // Add the value of r3 to itself and store in r3

// Task 3: Add immediate values 4 and 5
// This is not legal in ARM assembly because the "add" instruction
// does not allow two immediate values. Modify to use a register.
mov r4, #4       // Put the value 4 into register r4
add r4, r4, #5  // Add the immediate value 5 to r4

// End program
_stop:
b _stop
