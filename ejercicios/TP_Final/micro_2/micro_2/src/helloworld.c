/******************************************************************************
*
* Programa para verificar la lectura de los switches y la escritura de los leds.
*
* Autor: Pablo D. Folino 2022
*
******************************************************************************/

#include <stdio.h>
#include "platform.h"
#include "xil_printf.h"
#include "sleep.h"
#include "xparameters.h"
#include "xgpio.h"
#include "xil_types.h"


#define SW_ID XPAR_GPIO_0_DEVICE_ID
#define LED_ID XPAR_GPIO_0_DEVICE_ID
#define LED_RGB XPAR_GPIO_1_DEVICE_ID
#define BTN_ID XPAR_GPIO_1_DEVICE_ID
#define SW_CHANNEL 2
#define LED_CHANNEL 1
#define LED_RGB_CHANNEL 1
#define BTN_CHANNEL 2

#define SW_MASK 0b1111
#define BTN_MASK 0b1111

int main()
{
    init_platform();

    XGpio_Config *cfg_ptr;
	XGpio led_rgb_device,led_device,sw_device,btn_device;
	u32 data,data_btn,data_rgb;

	int c;
	data=0;
	data_rgb=0;

	// Initialize LED Device
	cfg_ptr = XGpio_LookupConfig(LED_ID);
	XGpio_CfgInitialize(&led_device, cfg_ptr, cfg_ptr->BaseAddress);
	// Set Led Tristate
	XGpio_SetDataDirection(&led_device, LED_CHANNEL, 0);

	// Initialize LED RGB Device
	cfg_ptr = XGpio_LookupConfig(LED_RGB);
	XGpio_CfgInitialize(&led_rgb_device, cfg_ptr, cfg_ptr->BaseAddress);
	// Set Led RGB Tristate
	XGpio_SetDataDirection(&led_rgb_device, LED_RGB_CHANNEL, 0x000000000000);

	// Initialize Switches Device
	cfg_ptr = XGpio_LookupConfig(SW_ID);
	XGpio_CfgInitialize(&sw_device, cfg_ptr, cfg_ptr->BaseAddress);
	// Set Button Tristate
	XGpio_SetDataDirection(&sw_device, SW_CHANNEL, SW_MASK);

	// Initialize Buttons Device
	cfg_ptr = XGpio_LookupConfig(BTN_ID);
	XGpio_CfgInitialize(&btn_device, cfg_ptr, cfg_ptr->BaseAddress);
	// Set Button Tristate
	XGpio_SetDataDirection(&btn_device, BTN_CHANNEL, BTN_MASK);



    c=0;
    while(1){
    	sleep(1);
    	xil_printf("%d",c);
    	print("_Programa Running \n\r");
    	c++;

    	xil_printf("Estado de los SW= %d\n\r", data);
    	xil_printf("Estado de los LEDs_RGB= %X\n\r", data_rgb);


    	data = XGpio_DiscreteRead(&sw_device, SW_CHANNEL);
    	data_btn = XGpio_DiscreteRead(&btn_device, BTN_CHANNEL);

    	// Cambia los primeros 2 leds RGB
    	if(data_rgb==64){
    		data_rgb=0;
    		}
    	else{
    		data_rgb++;
    	};
    	// Cambia los 2 últimos leds RGB con los botones
    	data_rgb+=(data_btn*64);

    	XGpio_DiscreteWrite(&led_device, LED_CHANNEL, data);
    	XGpio_DiscreteWrite(&led_rgb_device, LED_RGB_CHANNEL, data_rgb);

    }

    cleanup_platform();
    return 0;
}
