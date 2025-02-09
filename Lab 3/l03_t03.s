/*
-------------------------------------------------------
count3.s
-------------------------------------------------------
Author: Mohammed Maruf Hossain
ID: 169046996
Email: hoss6996@mylaurier.ca
Date: 2/7/2025
-------------------------------------------------------
An infinite loop program with memory-stored LED_BITS and DELAY_TIME
-------------------------------------------------------
*/
// Constants
.equ TIMER, 0xfffec600
.equ LEDS,  0xff200000

.org 0x1000  
.text        
.global _start
_start:

ldr r0, =LEDS      
ldr r1, =TIMER     
ldr r2, =LED_BITS  // Load LED pattern from memory
ldr r3, =DELAY_TIME
ldr r3, [r3]       // Load delay time from memory
str r3, [r1]       
mov r3, #0b011    
str r3, [r1, #0x8] 

LOOP:
    str r2, [r0]       
WAIT:
    ldr r3, [r1, #0xC]  
    cmp r3, #0
    beq WAIT            
    str r3, [r1, #0xC]  
    ror r2, #1          
    b LOOP

.data  
LED_BITS:   .word 0x0F0F0F0F  // Store LED pattern in memory
DELAY_TIME: .word 200000000   // Store delay time in memory
.end