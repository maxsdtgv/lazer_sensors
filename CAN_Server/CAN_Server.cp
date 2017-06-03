#line 1 "Z:/Project_2014/26.01.14/CAN_Server/CAN_Server.c"
char uart_rd;
char uart_rd_text[10];
unsigned char Can_Init_Flags, Can_Send_Flags, Can_Rcv_Flags;
unsigned char Rx_Data_Len;
char RxTx_Data[8];
char Msg_Rcvd;
const long ID_1st = 1, ID_2nd = 2;
long Rx_ID;




void main() {

 OSCTUNE.PLLEN=1;
 OSCCON.IRCF2=1;
 OSCCON.IRCF1=1;
 OSCCON.IRCF0=1;

 UART1_Init(9600);
 Delay_ms(100);

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

 UART1_Write_Text("Start6");
 UART1_Write(0x0D);
 UART1_Write(0x0A);
 TRISB.b1=0;
 PORTB.b1=0;
 Delay_ms(1000);
 PORTB.b1=1;
 Delay_ms(1000);
 PORTB.b1=0x00;

 while (1) {




 Msg_Rcvd = CANRead(&Rx_ID , RxTx_Data , &Rx_Data_Len, &Can_Rcv_Flags);

 if (Msg_Rcvd) {

 wordToStr(RxTx_Data[0], uart_rd_text);
 UART1_Write_Text(uart_rd_text);
 UART1_Write(0x0D);
 UART1_Write(0x0A);

 }


 }



}
