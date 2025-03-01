/*
-------------------------------------------------------
l05_t02.s
-------------------------------------------------------
Author:  Mohammed Maruf Hossain
ID:     169046996
Email:   hoss6996@mylaurier.ca
Date:   2/28/2025 
-------------------------------------------------------
Calculates stats on an integer list.
-------------------------------------------------------
*/
.org 0x1000  // Start at memory location 1000
.text        // Code section
.global _start
_start:

mov    r1, #0       // Initialize counters
mov    r2, #0
mov    r3, #0
ldr    r4, =Data    // Store address of start of list
ldr    r5, =_Data   // Store address of end of list
bl     list_stats   // Call subroutine - total returned in r0

_stop:
b      _stop

//-------------------------------------------------------
list_stats:
/*
-------------------------------------------------------
Counts number of positive, negative, and 0 values in a list.
Equivalent of: void stats(*start, *end, *zero, *positive, *negatives)
-------------------------------------------------------
Parameters:
  r1 - number of zero values
  r2 - number of positive values
  r3 - number of negative values
  r4 - start address of list
  r5 - end address of list
Uses:
  r0 - temporary value
-------------------------------------------------------
*/

// Preserve the values of r4 and r5
stmfd   sp!, {r4, r5}

// Loop through the list
loop:
    cmp     r4, r5      // compare start address to the nd address
    beq     end_loop    // If they are equal then end the loop

    ldr     r0, [r4], #4 // Then load the value from address in r4, then increment r4 by 4

    cmp     r0, #0      // Compare value to 0
    beq     zero_case   // If the value is 0, branch to zero_case
    bgt     positive_case // If value is greater than 0, branch to positive_case

    // Negative case
    add     r3, r3, #1  // This increments negative counter
    b       loop        // Repeat the loop

zero_case:
    add     r1, r1, #1  // Increment zero counter
    b       loop        // Repeat the loop

positive_case:
    add     r2, r2, #1  // Increment positive counter
    b       loop        // Repeat the loop

end_loop:
    // Restore the values of r4 and r5
    ldmfd   sp!, {r4, r5}
    bx      lr          // return from subroutine
	
	
.data
.align
Data:
.word   4,5,-9,0,3,0,8,-7,12    // The list of data
_Data: // End of list address

.end