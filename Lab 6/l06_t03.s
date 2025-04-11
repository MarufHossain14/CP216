/*
-------------------------------------------------------
l06_t03.s
-------------------------------------------------------
Author: Mohammed Maruf Hossain
ID: 169046996
Email: hoss6996@mylaurier.ca
Date:    2025-03-07
-------------------------------------------------------
Working with stack frames.
Finds the common prefix of two null-terminate strings.
-------------------------------------------------------
*/
// Constants
.equ SIZE, 80

.org 0x1000  // Start at memory location 1000
.text        // Code section
.global _start
_start:

ldr    r0, =First
ldr    r1, =Second
ldr    r2, =Common
mov    r3, #SIZE  // Set the maximum size of common

// Push the parameters onto the stack
stmfd  sp!, {r3}     // Push size
stmfd  sp!, {r2}     // Push address of common buffer
stmfd  sp!, {r1}     // Push address of second string
stmfd  sp!, {r0}     // Push address of first string

// Call the FindCommon subroutine
bl     FindCommon

// Clean up the stack
add    sp, sp, #16

_stop:
b      _stop

//-------------------------------------------------------
FindCommon:
// Prologue
    stmfd   sp!, {fp, lr}   // Save frame pointer and link register
    add     fp, sp, #4      // Set up frame pointer for current frame

    // Get parameters from the stack
    ldr     r0, [fp, #4]    // Address of first string
    ldr     r1, [fp, #8]    // Address of second string
    ldr     r2, [fp, #12]   // Address of common buffer
    ldr     r3, [fp, #16]   // Size

FCLoop:
    cmp    r3, #1           // is there room left in common?
    beq    _FindCommon      // no, leave subroutine
    ldrb   r4, [r0], #1     // get next character in first
    ldrb   r5, [r1], #1     // get next character in second
    cmp    r4, r5
    bne    _FindCommon      // if characters don't match, leave subroutine
    cmp    r5, #0           // reached end of first/second?
    beq    _FindCommon
    strb   r4, [r2], #1     // copy character to common
    sub    r3, r3, #1       // decrement space left in common
    b      FCLoop

_FindCommon:
    mov    r4, #0
    strb   r4, [r2]         // terminate common with null character

// Epilogue
    ldmfd   sp!, {fp, pc}   // Restore frame pointer and return

//-------------------------------------------------------
.data
First:
.asciz "pandemic"
Second:
.asciz "pandemonium"
Common:
.space SIZE

.end
