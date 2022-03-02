/******************************************************************************
*
* PRograma para verificar la lectura de los switches y la escritura de los leds.
*
******************************************************************************/

#include <stdio.h>
#include "platform.h"
#include "xil_printf.h"
#include "sleep.h"
#include "xparameters.h"
#include "xgpio.h"
#include "xil_types.h"


#define BTN_ID XPAR_GPIO_0_DEVICE_ID
#define LED_ID XPAR_GPIO_0_DEVICE_ID
#define BTN_CHANNEL 2
#define LED_CHANNEL 1
#define BTN_MASK 0b1111
#define LED_MASK 0b1111


int main()
{
    init_platform();

    XGpio_Config *cfg_ptr;
	XGpio led_device, btn_device;
	u32 data;

	int c;
	data=0;

	// Initialize LED Device
	cfg_ptr = XGpio_LookupConfig(LED_ID);
	XGpio_CfgInitialize(&led_device, cfg_ptr, cfg_ptr->BaseAddress);

	// Initialize Button Device
	cfg_ptr = XGpio_LookupConfig(BTN_ID);
	XGpio_CfgInitialize(&btn_device, cfg_ptr, cfg_ptr->BaseAddress);

	// Set Button Tristate
	XGpio_SetDataDirection(&btn_device, BTN_CHANNEL, BTN_MASK);

	// Set Led Tristate
	XGpio_SetDataDirection(&led_device, LED_CHANNEL, 0);


    c=0;
    while(1){
    	sleep(2);
    	xil_printf("%d",c);
    	print("_Programa Running \n\r");
    	c++;

    	xil_printf("Estado de los SW= %d\n\r", data);

    	data = XGpio_DiscreteRead(&btn_device, BTN_CHANNEL);

//    	if(data==16){
//    		data=0;
//    		}
//    	else{
//    		data++;
//    	};

    	XGpio_DiscreteWrite(&led_device, LED_CHANNEL, data);

    }

    cleanup_platform();
    return 0;
}
