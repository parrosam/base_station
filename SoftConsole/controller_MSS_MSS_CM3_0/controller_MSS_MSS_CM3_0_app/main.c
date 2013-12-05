#include "controller.h"
#include "display.h"

#include "drivers/CoreUARTapb/core_uart_apb.h"
#include "drivers/mss_uart/mss_uart.h"

#include <inttypes.h>
#include <stdio.h>

#define BAUD_VALUE_9600 650
#define CONTROLLER_ADDR 0x40050000
#define CORE_UART_APB_ADDR 0x40050100

int main() {
	// For the lcd display
	MSS_UART_init
	(
		&g_mss_uart1,
	    MSS_UART_115200_BAUD,
	    MSS_UART_DATA_8_BITS | MSS_UART_NO_PARITY | MSS_UART_ONE_STOP_BIT
	);
	clear_screen();

	/* Receive Side */
//	MSS_UART_init
//	(
//		&g_mss_uart1,
//		MSS_UART_9600_BAUD,
//		(MSS_UART_DATA_8_BITS | MSS_UART_NO_PARITY | MSS_UART_ONE_STOP_BIT)
//	);


	/* Transmit Side */
	UART_instance_t xbee;
	UART_init(
		&xbee,
		CORE_UART_APB_ADDR,
		BAUD_VALUE_9600,
		(DATA_8_BITS | NO_PARITY)
	);

	volatile int i = 0;
	float x = -90; // For lcd display test code, can get rid of this later

	while( 1 ) {
		// lcd display test code


		if((i%10000) == 0){
			print_degrees(x);
			x += 10;

			if (x > 90)
				x = -90;
			i = 0;
		}
		i++;
		/* TRANSMIT SIDE */

		volatile uint32_t * controller = (uint32_t *) CONTROLLER_ADDR;
		uint32_t buttons = *controller;
		printButtons(buttons);

		uint8_t buttonMsg[4];
		buttonMsg[0] = buttons;			// Break up buttons into 4x 8 bit chunks
		buttonMsg[1] = (buttons >> 8);
		buttonMsg[2] = (buttons >> 16);
		buttonMsg[3] = (buttons >> 24);
		UART_send(&xbee, (uint8_t *)&buttonMsg, sizeof(buttonMsg));

		/* RECEIVE SIDE */
//		uint8_t rx_buttons[4];
//		uint32_t rx_size = MSS_UART_get_rx( &g_mss_uart1, rx_buttons, sizeof(rx_buttons));
//		uint32_t buttons;
//		if (rx_size > 0){
//			//process_rx_data(rx_buttons, rx_size);
//			printf("%x%x%x%x\r\n", rx_buttons[0], rx_buttons[1], rx_buttons[2], rx_buttons[3]);
//			buttons = rx_buttons[3];
//			buttons = ((buttons << 8) | rx_buttons[2]);
//			buttons = ((buttons << 8) | rx_buttons[1]);
//			buttons = ((buttons << 8) | rx_buttons[0]);
//			printButtons(buttons);
//		}
	}

	return 0;
}