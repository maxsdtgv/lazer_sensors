#line 1 "Z:/Project_2014/26.01.14/CAN_Client_Lazer/CAN_Client_Lazer.c"
sbit LED_Lazerdetect at RB0_bit;
sbit LED_CANactive at RB1_bit;
sbit LAZER at RB4_bit;

sbit LED_Lazerdetect_Direction at TRISB0_bit;
sbit LED_CANactive_Direction at TRISB1_bit;
sbit LAZER_Direction at TRISB4_bit;
sbit LAZER_input_Direction at TRISA1_bit;

char uart_rd;
char uart_rd_text[10];

unsigned char Can_Init_Flags, Can_Send_Flags, Can_Rcv_Flags;
unsigned char Rx_Data_Len;
char RxTx_Data[8];
char Msg_Rcvd;
const long ID_1st = 1, ID_2nd = 2;
long Rx_ID;

unsigned int ad_res;





void main() {

 OSCTUNE.PLLEN=1;
 OSCCON.IRCF2=1;
 OSCCON.IRCF1=1;
 OSCCON.IRCF0=1;




 Can_Init_Flags = 0;
 Can_Send_Flags = 0;
 Can_Rcv_Flags = 0;

 Can_Send_Flags = _CAN_TX_PRIORITY_0 &
 _CAN_TX_STD_FRAME &
 _CAN_TX_NO_RTR_FRAME;

 Can_Init_Flags = _CAN_CONFIG_SAMPLE_BIT &
 _CAN_CONFIG_PHSEG2_PRG_ON &
 _CAN_CONFIG_STD_MSG &
 _CAN_CONFIG_DBL_BUFFER_OFF &
 _CAN_CONFIG_VALID_STD_MSG &
 _CAN_CONFIG_LINE_FILTER_OFF;



 CANInitialize(0,38,0,0,0,Can_Init_Flags);
 CANSetOperationMode(_CAN_MODE_CONFIG,0xFF);




 CANSetOperationMode(_CAN_MODE_NORMAL,0xFF);

 ADCON1.VCFG0=0;
 ADCON1.VCFG1=0;
 LAZER_input_Direction=1;


 LED_Lazerdetect_Direction=0;
 LED_CANactive_Direction=0;
 LAZER_Direction=0;


 LED_Lazerdetect=1;
 LED_CANactive=1;
 LAZER=0;
 Delay_ms(1000);
 LED_Lazerdetect=0;
 LED_CANactive=0;
 LAZER=1;

 Delay_ms(1000);
 LED_Lazerdetect=1;
 LED_CANactive=1;
 LAZER=1;


 while (1) {




 ad_res = ADC_Read(1);
 if(ad_res < 500) {LED_Lazerdetect=0;} else {LED_Lazerdetect=1;}
 RxTx_Data[0] = ad_res;
 RxTx_Data[1] = ad_res >> 8;
 CANWrite(ID_2nd, RxTx_Data, 8, Can_Send_Flags);






 Delay_ms(500);

 }



}
