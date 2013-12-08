/*
 * display.h
 *
 *  Created on: Nov 26, 2013
 *      Author: fstan
 */

#ifndef DISPLAY_H_
#define DISPLAY_H_

#include <inttypes.h>
#include "drivers/CoreUARTapb/core_uart_apb.h"
/*
 * Clear the screen
 */
void clear_screen(UART_instance_t * this_uart);

/*
 * Sets the reference x coordinate, used to place text at specific locations on screen
 */
void set_x(UART_instance_t * this_uart, uint8_t x);

/*
 * Sets the reference y coordinate, used to place text at specific locations on screen
 */
void set_y(UART_instance_t * this_uart, uint8_t y);

/*
 * Draw a line from coordinates (x1, y1) to (x2, y2)
 */
void draw_line(UART_instance_t * this_uart, uint8_t x1, uint8_t y1, uint8_t x2, uint8_t y2);

/*
 * Erase the line from coordinates (x1, y1) to (x2, y2)
 */
void erase_line(UART_instance_t * this_uart, uint8_t x1, uint8_t y1, uint8_t x2, uint8_t y2);

/*
 * Draw a circle centered at coordinate (x, y) with radius r
 */
void draw_circle(UART_instance_t * this_uart, uint8_t x, uint8_t y, uint8_t r);

/*
 * Erase the circle centered at coordinate (x, y) with radius r
 */
void erase_circle(UART_instance_t * this_uart, uint8_t x, uint8_t y, uint8_t r);

/*
 * Displays a pendulum tilted at deg degrees, and displays deg as an integer
 * Assumes input goes from -90 to 90 degrees, with 0 as balance
 */
void print_degrees(UART_instance_t * this_uart, float deg);

#endif /* DISPLAY_H_ */
