/******************************************************************************
*
* Programa para verificar la lectura de los switchesy la escritura de los leds.
*
* Autor: Pablo D. Folino 2022
*
* Versión : 8
*
* Ejemplo de tramas a transmitir;  Start-Pre-Bytes-Sigma-SVT-Stop
* 									55 01 02 04 00 07 00 10 03
* 									55 01 02 00 01 03 01 10 03
* 									55 02 07 00 01 09 01 10 03
* 									55 02 02 01 00 05 00 10 03
*
******************************************************************************/

#include <stdio.h>
#include "platform.h"
#include "xil_printf.h"
#include "sleep.h"
#include "xparameters.h"
#include "xgpio.h"
#include "xil_types.h"
#include "xuartlite_l.h"

#define SW_ID 		XPAR_GPIO_0_DEVICE_ID	// Switches de la Arty A7
#define SW_CHANNEL 		2
#define LED_ID 		XPAR_GPIO_0_DEVICE_ID	// Leds  de la Arty A7
#define LED_CHANNEL 	1
#define LED_RGB 	XPAR_GPIO_1_DEVICE_ID	// Leds RGB  de la Arty A7
#define LED_RGB_CHANNEL 1
#define BTN_ID 		XPAR_GPIO_1_DEVICE_ID	// Pulsadores  de la Arty A7
#define BTN_CHANNEL 	2
#define SELECTOR_ID XPAR_GPIO_2_DEVICE_ID	// Señal para selecionar el Canal o el Softcore
#define SELECTOR_CHANEL 1
#define ARST_ID XPAR_GPIO_2_DEVICE_ID		// Reset Asincrónico del canal se activa con el btn[0]
#define	ARST_CHANEL 	2
#define MN1_PRE_ID XPAR_GPIO_3_DEVICE_ID	//  Señal mn1_pre
#define	MN1_PRE_CHANEL	1
#define MN1_BYTES_ID XPAR_GPIO_3_DEVICE_ID	// Señal mn1_bytes
#define	MN1_BYTES_CHANEL 2
#define SIGMA_ID XPAR_GPIO_4_DEVICE_ID		// Señal sigma
#define SIGMA_CHANEL 	1

#define SW_MASK 0b1111
#define BTN_MASK 0b1111

#define Z_BUFFER 50

#define LED_1_CLEAR 0b111111111000
#define LED_VERDE_1 0b000000000010
#define LED_ROJO_1  0b000000000100
#define LED_4_CLEAR 0b000111111111
#define LED_VERDE_4 0b010000000000
#define LED_ROJO_4  0b100000000000
#define SW_CANAL 	0
#define SW_SOFTCORE 1

#define ESPERA_RX 50
//---------------------------------------------------------------------------------------------------------------
// Funciones locales
//---------------------------------------------------------------------------------------------------------------
// Limpia el Buffer de entrada
void clear_buffer(uint8_t *buffer){
	for(int i=0;i<Z_BUFFER;i++){
		*(buffer+i)=' ';
	}
}
// Lectura de la UART
uint8_t read_uart(uint8_t *buffer){
	uint8_t	index;
	uint8_t	 entrada;							// antes era char

	index=0;
	while(!XUartLite_IsReceiveEmpty(XPAR_UARTLITE_0_BASEADDR)){
    	entrada= XUartLite_RecvByte(XPAR_UARTLITE_0_BASEADDR );
    	*(buffer+index)=entrada;
    	index++;
	    }
	return index;
}
//// Convierte de char a uint8_t
//char int_to_chat(uint8_t data){
//	char temp;
//	if ((data>=0)&&(data<15)) {
//		if((data>=0) && (data<=9)){
//			temp=data+48;
//			}
//		else{
//			temp=data+55;
//		}
//	return temp;
//	}
//	return -1;
//}

int main()
{
    init_platform();
	//---------------------------------------------------------------------------------------------------------------
    // Declaración de datos
	//---------------------------------------------------------------------------------------------------------------
    XGpio_Config *cfg_ptr;							// punteros a estructuras
	XGpio led_rgb_device,led_device,sw_device;
	XGpio btn_device,selector_device;
	XGpio arst_device,mn1_pre_device,mn1_bytes_device;
	XGpio sigma_device;
	u32 data,data_btn,data_rgb,arst;
	uint8_t c;
	uint8_t buffer_in[Z_BUFFER];
	uint8_t selector_sw,cantidad;					//  Si es 0-se conecta el canal; si es 1-se conecta el softcore
	uint8_t	start_frame,mn1_pre, mn1_bytes;			//  trama de recepción
	uint8_t	stop1_frame, stop2_frame;
	uint16_t sigma,svt,contador_svt;

	uint16_t count_espera;
	uint8_t estado_rx;
	uint16_t led_rgb;
	//---------------------------------------------------------------------------------------------------------------


	// Valores iniciales
	data=0;
	c=0;
	data_rgb=0;
	arst=0;
	led_rgb=0;
	clear_buffer(&(buffer_in[0]));


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

	// Initialize Selector Device
	cfg_ptr = XGpio_LookupConfig(SELECTOR_ID);
	XGpio_CfgInitialize(&selector_device, cfg_ptr, cfg_ptr->BaseAddress);
	// Set Button Tristate
	//XGpio_SetDataDirection(&selector_device, SELECTOR_CHANEL, 0x0000);

	// Initialize Asincronic  Device
	cfg_ptr = XGpio_LookupConfig(ARST_ID);
	XGpio_CfgInitialize(&arst_device, cfg_ptr, cfg_ptr->BaseAddress);

	// Initialize MN1_PRE  Device
	cfg_ptr = XGpio_LookupConfig(MN1_PRE_ID);
	XGpio_CfgInitialize(&mn1_pre_device, cfg_ptr, cfg_ptr->BaseAddress);

	// Initialize MN1_BYTES  Device
	cfg_ptr = XGpio_LookupConfig(MN1_BYTES_ID);
	XGpio_CfgInitialize(&mn1_bytes_device, cfg_ptr, cfg_ptr->BaseAddress);

	// Initialize SIGMA Device
	cfg_ptr = XGpio_LookupConfig(SIGMA_ID);
	XGpio_CfgInitialize(&sigma_device, cfg_ptr, cfg_ptr->BaseAddress);

    while(1){
    	usleep(250000);

    	// Incrementa los LEDs para saber que el sistema esta corriendo
    	c++;
    	if(c>=256) c=0;
    	XGpio_DiscreteWrite(&led_device, LED_CHANNEL, c);

    	// Reset asincrónico del canal-------------------------------------------------------------------------
    	arst = XGpio_DiscreteRead(&btn_device, BTN_CHANNEL);			// Leo el btn[0]
    	XGpio_DiscreteWrite(&arst_device, ARST_CHANEL, arst);			// Escribo el arst
        if(arst==1){
    		led_rgb=(LED_4_CLEAR & led_rgb)|LED_ROJO_4;
    		XGpio_DiscreteWrite(&led_rgb_device, LED_RGB_CHANNEL, led_rgb);
        	}
        else{
    		led_rgb=(LED_4_CLEAR & led_rgb)|LED_VERDE_4;
    		XGpio_DiscreteWrite(&led_rgb_device, LED_RGB_CHANNEL, led_rgb);
        }

    	// Leo el sw[0], si está en 0 se selecciona el canal, si no el softcore -------------------------------
    	data = XGpio_DiscreteRead(&sw_device, SW_CHANNEL);
    	if ((data&0x01)==0){
    		led_rgb=(LED_1_CLEAR & led_rgb)|LED_VERDE_1;
    		XGpio_DiscreteWrite(&led_rgb_device, LED_RGB_CHANNEL, led_rgb); // enciendo los leds en verde
    		selector_sw=SW_CANAL;
    	}
    	if ((data&0x01)==1){
    		led_rgb=(LED_1_CLEAR & led_rgb)|LED_ROJO_1;
    		XGpio_DiscreteWrite(&led_rgb_device, LED_RGB_CHANNEL, led_rgb); 	// enciendo los leds en rojo
    		selector_sw=SW_SOFTCORE;
    		if(estado_rx==0){
        		read_uart(&(buffer_in[0]));					   					// limpio buffer de entrada
        		clear_buffer(&(buffer_in[0]));
        		count_espera=0;
    			}
    		estado_rx=1;
    	}
		XGpio_DiscreteWrite(&selector_device, SELECTOR_CHANEL, selector_sw);
		//----------------------------------------------------------------------------------------------------


		// Se lee la UART ------------------------------------------------------------------------------------
		if(selector_sw==1){
			count_espera++;
			if(count_espera>=ESPERA_RX){
				xil_printf("ERROR---> Esperando trama\n\r");
				estado_rx=0;
				}
			else{
				cantidad=read_uart(&(buffer_in[0]));
	 			if(cantidad!=0){
					if(cantidad==9){
						count_espera=0;
						// leo la trama 0x55,nm1_pre,nm1_bytes, sigma(2bytes),svt(2bytes),0x10,0x033
						start_frame=*buffer_in;
						mn1_pre=*(buffer_in+1);
						mn1_bytes=*(buffer_in+2);
						sigma=(*(buffer_in+4)*256)+(*(buffer_in+3));
						svt=(*(buffer_in+6)*256)+(*(buffer_in+5));
						stop1_frame=*(buffer_in+7);
						stop2_frame=*(buffer_in+8);
						contador_svt=mn1_pre+mn1_bytes+sigma;
						if(start_frame==0x55 && stop1_frame==0x10 && stop2_frame==0x03&& contador_svt==svt){
							// Imprimo los valores recibidos
							xil_printf("--Trama válida--\n\r");
							xil_printf("mn1_pre= 0x%x\n\r", mn1_pre);
							xil_printf("mn1_bytes= 0x%x\n\r", mn1_bytes);
							xil_printf("sigma= 0x%x\n\r", sigma);
							XGpio_DiscreteWrite(&mn1_pre_device, MN1_PRE_CHANEL, mn1_pre);
							XGpio_DiscreteWrite(&mn1_bytes_device, MN1_BYTES_CHANEL, mn1_bytes);
							XGpio_DiscreteWrite(&sigma_device, SIGMA_CHANEL, sigma);
							}
							else{
							xil_printf("ERROR de Trama--> Con error de SVT, START o STOP \n\r");
			        		read_uart(&(buffer_in[0]));					   					// limpio buffer de entrada
			        		clear_buffer(&(buffer_in[0]));
							}
						}
						else{
							xil_printf("ERROR de Trama----> Cantidad de campos incorrectos \n\r");
			        		read_uart(&(buffer_in[0]));					   					// limpio buffer de entrada
			        		clear_buffer(&(buffer_in[0]));
						}
					}
				}
		}
		//----------------------------------------------------------------------------------------------------

    }
    cleanup_platform();
    return 0;
}
