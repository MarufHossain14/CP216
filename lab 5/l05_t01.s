/*
-------------------------------------------------------
l05_t01.s
-------------------------------------------------------
Author: Mohammed Maruf Hossain
ID:     169046996
Email:  hoss6996@mylaurier.ca 
Date:    2/28/2025
-------------------------------------------------------
Does a running total of an integer list.
-------------------------------------------------------
*/
.org 0x1000  // Start at memory location 1000
.text        // Code section
.global _start
_start:

ldr    r1, =Data    // Store address of start of list
ldr    r2, =_Data   // Store address of end of list
bl     list_total   // Call subroutine - total returned in r0

_stop:
b      _stop

//-------------------------------------------------------
list_total:
/*
-------------------------------------------------------
Totals values in a list.
Equivalent of: int total(*start, *end)
-------------------------------------------------------
Parameters:
  r1 - start address of list
  r2 - end address of list
Uses:
  r3 - temporary value
Returns:
  r0 - total of values in list
-------------------------------------------------------
*/

// Initialize total to 0
mov     r0, #0          // r0 = 0 (total)

// Loop through the list
loop:
    cmp     r1, r2      // Compare start address to end address
    beq     end_loop    // If they are equal, end the loop

    ldr     r3, [r1], #4 // Load value from address in r1, then increment r1 by 4
    add     r0, r0, r3  // Add the value to the total

    b       loop        // Repeat the loopp

end_loop:
    bx      lr          // return from subroutine
	
.data
.align
Data:
.word   4,5,-9,0,3,0,8,-7,12    // The list of data
_Data: // End of list address

.end