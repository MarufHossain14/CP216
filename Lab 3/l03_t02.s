/*
-------------------------------------------------------
count2.s
-------------------------------------------------------
Author: Mohammed Maruf Hossain
ID: 169046996
Email: hoss6996@mylaurier.ca
Date: 2/7/2025
-------------------------------------------------------
A simple countdown program with memory storage
-------------------------------------------------------
*/
.org 0x1000  // Start at memory location 1000
.text        // Code section
.global _start
_start:

ldr r3, =COUNTER  // Load address of COUNTER
ldr r3, [r3]      // Load value stored in COUNTER

TOP:
sub r3, r3, #1  
cmp r3, #0       
bge TOP   

_stop:
b _stop

.data  
COUNTER: .word 5  // Define COUNTER in memory
.end