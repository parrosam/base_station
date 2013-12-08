#include "controller.h"
#include "display.h"

#include "drivers/CoreUARTapb/core_uart_apb.h"
#include "drivers/mss_uart/mss_uart.h"

#include <inttypes.h>
#include <stdio.h>

#define BAUD_VALUE_9600 650
#define CONTROLLER_ADDR 0x40050000
#define CORE_UART_APB_ADDR 0x40050100
#define RX_BUFF_SIZE 4

uint8_t g_rx_buff[RX_BUFF_SIZE];

// Interrupt driven rx handler, will read data only when it get a receive data available (RDA) interrupt
void uart1_rx_handler( mss_uart_instance_t * this_uart )
{
	uint32_t rx_size = MSS_UART_get_rx( this_uart, g_rx_buff, sizeof(g_rx_buff) );
	if ( rx_size > 0 )
	{
		int angle = 0;
		angle = g_rx_buff[3];
		angle = ((angle << 8) | g_rx_buff[2]);
		angle = ((angle << 8) | g_rx_buff[1]);
		angle = ((angle << 8) | g_rx_buff[0]);
		printf("STUFF: %d\r\n", angle);
	}
}

// Union allows us to receive 4 bytes of a float and reconstruct it
union
{
	float f;
	uint8_t c[4];
} kp, ki, kd;

int main() {
	// For the lcd display ... THIS SHOULD BE COREUARTAPB, PLEASE REMEMBER TO CHANGE THIS
//	MSS_UART_init
//	(
//		&g_mss_uart1,
//	    MSS_UART_115200_BAUD,
//	    MSS_UART_DATA_8_BITS | MSS_UART_NO_PARITY | MSS_UART_ONE_STOP_BIT
//	);
	//clear_screen();


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
		// lcd display test code
//		if((i%10000) == 0){
//			print_degrees(x);
//			x += 10;
//
//			if (x > 90)
//				x = -90;
//			i = 0;
//		}
//		i++;
		/* TRANSMIT SIDE */

//		if (!(i%100)) {
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

//			i = 1;
//		}

//		i++;
	}

	return 0;
}
