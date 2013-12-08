#include "controller.h"
#include "display.h"

#include "drivers/CoreUARTapb/core_uart_apb.h"
#include "drivers/mss_uart/mss_uart.h"

#include <inttypes.h>
#include <stdio.h>

#define BAUD_VALUE_9600 650
#define BAUD_VALUE_115200 53
#define CONTROLLER_ADDR 0x40050000
#define CORE_UART_APB_ADDR 0x40050100
#define RX_BUFF_SIZE 4

uint8_t g_rx_buff[RX_BUFF_SIZE];

// Union allows us to receive 4 bytes of a float and reconstruct it
union
{
	float f;
	uint8_t c[4];
} g_kp, g_ki, g_kd, g_angle;

// Interrupt driven rx handler, will read data only when it get a receive data available (RDA) interrupt
void uart1_rx_handler( mss_uart_instance_t * this_uart )
{
	uint32_t rx_size = MSS_UART_get_rx( this_uart, g_rx_buff, sizeof(g_rx_buff) );
	if ( rx_size > 0 )
	{
		g_angle.c[3] = g_rx_buff[3];
		g_angle.c[2] = g_rx_buff[2];
		g_angle.c[1] = g_rx_buff[1];
		g_angle.c[0] = g_rx_buff[0];

//		g_kp.c[3] = g_rx_buff[7];
//		g_kp.c[2] = g_rx_buff[6];
//		g_kp.c[1] = g_rx_buff[5];
//		g_kp.c[0] = g_rx_buff[4];
//
//		g_ki.c[3] = g_rx_buff[11];
//		g_ki.c[2] = g_rx_buff[10];
//		g_ki.c[1] = g_rx_buff[9];
//		g_ki.c[0] = g_rx_buff[8];
//
//		g_kd.c[3] = g_rx_buff[15];
//		g_kd.c[2] = g_rx_buff[14];
//		g_kd.c[1] = g_rx_buff[13];
//		g_kd.c[0] = g_rx_buff[12];

//		angle = g_rx_buff[3];
//		angle = ((angle << 8) | g_rx_buff[2]);
//		angle = ((angle << 8) | g_rx_buff[1]);
//		angle = ((angle << 8) | g_rx_buff[0]);
		//printf("STUFF: %f\r\n", g_angle.f);
		//printf("KP: %f\tKI: %f\tKD: %f\r\n", g_kp.f, g_ki.f, g_kd.f);
	}
}



int main() {
	// For lcd screen
	UART_instance_t core_uart_apb;

	UART_init
	(
		&core_uart_apb,
		CORE_UART_APB_ADDR,
		BAUD_VALUE_115200,
		DATA_8_BITS | NO_PARITY
	);
	clear_screen(&core_uart_apb);

	// For XBee
	MSS_UART_init
	(
		&g_mss_uart1,
		MSS_UART_9600_BAUD,
		MSS_UART_DATA_8_BITS | MSS_UART_NO_PARITY | MSS_UART_ONE_STOP_BIT
	);

	// Sets up interrupt-driven receiving of data
	MSS_UART_set_rx_handler
	(
		&g_mss_uart1,
	    uart1_rx_handler,
	    MSS_UART_FIFO_FOUR_BYTES
	);

	//volatile int i = 0;
	//float x = -90; // For lcd display test code, can get rid of this later

	int i = 1;

	while( 1 ) {
		if (!(i%50)) {
			print_degrees(&core_uart_apb, g_angle.f);
			i = 1;
		}
			volatile uint32_t * controller = (uint32_t *) CONTROLLER_ADDR;
			uint32_t buttons = *controller;
			//printButtons(buttons);

			uint8_t buttonMsg[4];
			buttonMsg[0] = buttons;			// Break up buttons into 4x 8 bit chunks
			buttonMsg[1] = (buttons >> 8);
			buttonMsg[2] = (buttons >> 16);
			buttonMsg[3] = (buttons >> 24);
			MSS_UART_irq_tx(&g_mss_uart1, buttonMsg, sizeof(buttonMsg));
			while ( 0 == MSS_UART_tx_complete( &g_mss_uart1 ) )
			 {
				 ;
			 }
		i++;
	}

	return 0;
}
