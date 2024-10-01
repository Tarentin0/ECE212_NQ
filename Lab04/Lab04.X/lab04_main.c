/* 
 * File:   lab04_main.c
 * Author: funkq
 *
 * Created on October 1, 2024, 1:31 PM
 */

#include <stdio.h>
#include <stdlib.h>

/*
 * 
 */
#include "ece212.h"
int main() {
// add needed variables here
// set initial speed and direction (straight)
    RFORWARD = 0xFFFF;
    LFORWARD = 0xFFFF;
    RBACK = 0;
    LBACK = 0;
    ece212_lafbot_setup();
    while(1){
        int left = analogRead(LEFT_SENSOR);
        int right = analogRead(RIGHT_SENSOR);
        writeLEDs(0x0);
        if (left > 310) {
            writeLEDs(0x1);
            RFORWARD = 0xafff;
            LFORWARD = 0x1fff;
        }
        if (right > 310) {
            writeLEDs(0x8);
            LFORWARD = 0xafff;
            RFORWARD = 0x1fff;
        } else if (left < 310){
            writeLEDs(0x4);
            RFORWARD = 0xFFFF;
            LFORWARD = 0xFFFF;
        }
        delayms(25);
// sample input sensors and determine if on track
// if not, alter wheel speeds to try to correct
// delay for some amount of time before repeating
}
return (EXIT_SUCCESS);
}

