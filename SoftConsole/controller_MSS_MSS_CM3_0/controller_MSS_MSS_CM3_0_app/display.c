/*
 * display.c
 *
 *  Created on: Nov 26, 2013
 *      Author: fstan
 */

#include "display.h"
#include <stdio.h>
#include <math.h>

#define PI 3.14159265

void clear_screen()
{
	uint8_t tx_buff[2] = {0x7C, 0x00};
	MSS_UART_polled_tx( &g_mss_uart1, tx_buff, sizeof(tx_buff) );
}

void set_x(uint8_t x)
{
	uint8_t tx_buff[3] = {0x7C, 0x18, x};
	MSS_UART_polled_tx( &g_mss_uart1, tx_buff, sizeof(tx_buff) );
}

void set_y(uint8_t y){
	uint8_t tx_buff[3] = {0x7C, 0x19, y};
	MSS_UART_polled_tx( &g_mss_uart1, tx_buff, sizeof(tx_buff) );
}

void draw_line(uint8_t x1, uint8_t y1, uint8_t x2, uint8_t y2)
{
	uint8_t tx_buff[7] = {0x7C, 0x0C, x1, y1, x2, y2, 0x01};
	MSS_UART_polled_tx( &g_mss_uart1, tx_buff, sizeof(tx_buff) );
}

void erase_line(uint8_t x1, uint8_t y1, uint8_t x2, uint8_t y2)
{
	uint8_t tx_buff[7] = {0x7C, 0x0C, x1, y1, x2, y2, 0x00};
	MSS_UART_polled_tx( &g_mss_uart1, tx_buff, sizeof(tx_buff) );
}

void draw_circle(uint8_t x, uint8_t y, uint8_t r)
{
	uint8_t tx_buff[6] = {0x7C, 0x03, x, y, r, 0x01};
	MSS_UART_polled_tx( &g_mss_uart1, tx_buff, sizeof(tx_buff) );
}

void erase_circle(uint8_t x, uint8_t y, uint8_t r)
{
	uint8_t tx_buff[6] = {0x7C, 0x03, x, y, r, 0x00};
	MSS_UART_polled_tx( &g_mss_uart1, tx_buff, sizeof(tx_buff) );
}

void print_degrees(float deg)
{
	clear_screen();

	//Convert float to nearest uint32_t
	deg += 90.0;	//Convert to range 0 to 180 degrees
	int deg_int = (deg >= 0) ? (int)(deg + 0.5) : (int)(deg - 0.5);

	//Set location of degree printout
	set_x(10);
	set_y(10);

	//Convert int to char array
	char buffer[4];
	sprintf(buffer, "%d", deg_int);

	//Set first empty location (after the numerals) to be the degree symbol
	int i;
	for (i = 0; i < 4; i++)
	{
		if (buffer[i] == '\0')
		{
			buffer[i] = 248;	//ASCII degree symbol
			break;
		}
	}

	//Print degrees
	MSS_UART_polled_tx( &g_mss_uart1, (uint8_t*)buffer, sizeof(buffer) );

	//Get locations of x and y pixels for head of the pendulum
	double x_pixel = 80.0 - cos(deg * PI / 180.0) * 50.0;
	double y_pixel = 127.0 - sin(deg * PI / 180.0) * 50.0;

	//Draw pendulum
	draw_line(80, 127, (uint8_t)x_pixel, (uint8_t)y_pixel);
	draw_circle((uint8_t)x_pixel, (uint8_t)y_pixel, 5);
}
