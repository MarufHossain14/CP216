/*
-------------------------------------------------------
l06_t01.s
-------------------------------------------------------
Author: Mohammed Maruf Hossain
ID: 169046996
Email: hoss6996@mylaurier.ca
Date: 2025-03-07
-------------------------------------------------------
Working with stack frames.
Compare two strings up to length of n characters.
-------------------------------------------------------
*/
// Constants
.equ SIZE, 80

.org 0x1000  // Start at memory location 1000
.text        // Code section
.global _start
_start:

mov    r3, #SIZE     
stmfd  sp!, {r3}     
ldr    r3, =Second
stmfd  sp!, {r3}    
ldr    r3, =First
stmfd  sp!, {r3}     
bl     strncmp
add    sp, sp, #12  

// Result in r0
_stop:
b    _stop

//-------------------------------------------------------
strncmp:
/*
-------------------------------------------------------
Determines if two strings are equal up to a max length (iterative)
Equivalent of: strncmp(*str1, *str2, max_buffer_size)
-------------------------------------------------------
Parameters:
  str1 - address of first string
  str2 - address of second string
  max_buffer_size - maximum size of str1 and str2
Returns:
  r0 - less than 0 if first string comes first,
       greater than 0 if first string comes second,
       0 if two strings are equal up to maximum length
Uses:
  r1 - address of first string
  r2 - address of second string
  r3 - current maximum length
  r4 - character from first string
  r5 - character from second string
-------------------------------------------------------
*/
    // Prologue:
    stmfd   sp!, {fp, lr}     // Save fp and lr
    add     fp, sp, #4        // Set up frame pointer for current frame
    
    // Get parameters
    ldr     r3, [fp, #4]      
    ldr     r2, [fp, #8]      
    ldr     r1, [fp, #12]     
    mov     r0, #0           

strncmpLoop:
    cmp     r3, #0
    beq     _strncmp
    ldrb    r4, [r1], #1      
    ldrb    r5, [r2], #1      
    cmp     r4, r5
    subne   r0, r4, r5       
    bne     _strncmp
    cmp     r4, #0            
    beq     _strncmp
    cmp     r5, #0           
    beq     _strncmp
    sub     r3, r3, #1       
    b       strncmpLoop

_strncmp:
    // Epilogue
    ldmfd   sp!, {fp, pc}     // Restore frame pointer and return

//-------------------------------------------------------
.data
First:
.asciz "aaaa"
Second:
.asciz "aaab"

.end
