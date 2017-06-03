sbit LED_Lazerdetect at RB0_bit;
sbit LED_CANactive at RB1_bit;
sbit LAZER at RB4_bit;

sbit LED_Lazerdetect_Direction at TRISB0_bit;
sbit LED_CANactive_Direction at TRISB1_bit;
sbit LAZER_Direction at TRISB4_bit;
sbit LAZER_input_Direction at TRISA1_bit;

char uart_rd;
char uart_rd_text[10];

unsigned char Can_Init_Flags, Can_Send_Flags, Can_Rcv_Flags; // can flags
unsigned char Rx_Data_Len;                                   // received data length in bytes
char RxTx_Data[8];                                           // can rx/tx data buffer
char Msg_Rcvd;                                               // reception flag
const long ID_1st = 1, ID_2nd = 2;                       // node IDs
long Rx_ID;

unsigned int ad_res;





void main() {
     //=========================================================================
     OSCTUNE.PLLEN=1;   //****************************
     OSCCON.IRCF2=1;    //    Internal OSC = 8MHz
     OSCCON.IRCF1=1;    //
     OSCCON.IRCF0=1;    //****************************
     //=========================================================================
     //UART1_Init(9600);  // Initialize UART module at 9600 bps
     //Delay_ms(100);     // Wait for UART module to stabilize
     //=========================================================================
     Can_Init_Flags = 0;                                       //
     Can_Send_Flags = 0;                                       // clear flags
     Can_Rcv_Flags  = 0;                                       //

  Can_Send_Flags = _CAN_TX_PRIORITY_0 &                     // form value to be used
                   _CAN_TX_STD_FRAME &                      //     with CANWrite
                   _CAN_TX_NO_RTR_FRAME;

  Can_Init_Flags = _CAN_CONFIG_SAMPLE_BIT &              // form value to be used
                   _CAN_CONFIG_PHSEG2_PRG_ON &              // with CANInit
                   _CAN_CONFIG_STD_MSG &
                   _CAN_CONFIG_DBL_BUFFER_OFF &
                   _CAN_CONFIG_VALID_STD_MSG &
                   _CAN_CONFIG_LINE_FILTER_OFF;



     CANInitialize(0,38,0,0,0,Can_Init_Flags);                  // Initialize CAN module
     CANSetOperationMode(_CAN_MODE_CONFIG,0xFF);               // set CONFIGURATION mode
     //CANSetMask(_CAN_MASK_B1,-1,_CAN_CONFIG_XTD_MSG);          // set all mask1 bits to ones
     //CANSetMask(_CAN_MASK_B2,-1,_CAN_CONFIG_XTD_MSG);          // set all mask2 bits to ones

     //CANSetFilter(_CAN_FILTER_B2_F4,ID_2nd,_CAN_CONFIG_XTD_MSG);// set id of filter B2_F4 to 2nd node ID
     CANSetOperationMode(_CAN_MODE_NORMAL,0xFF);               // set NORMAL mode
     //=========================================================================
     ADCON1.VCFG0=0;  //  Connect Vref to internal source
     ADCON1.VCFG1=0;
     LAZER_input_Direction=1; // Input AN1 as input tris

     //=========================================================================
     LED_Lazerdetect_Direction=0;
     LED_CANactive_Direction=0;
     LAZER_Direction=0;
     //=========================================================================
     
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


 while (1) {                     // Endless loop
    //if (UART1_Data_Ready()) {     // If data is received,
    //  uart_rd = UART1_Read();     // read the received data,
    //  UART1_Write(uart_rd);       // and send data via UART
    //}
        ad_res = ADC_Read(1);   // Get 10-bit results of AD conversion
        if(ad_res < 500) {LED_Lazerdetect=0;} else {LED_Lazerdetect=1;}
        RxTx_Data[0] = ad_res;
        RxTx_Data[1] = ad_res >> 8;
        CANWrite(ID_2nd, RxTx_Data, 8, Can_Send_Flags);           // send initial message


        //wordToStr(ad_res, uart_rd_text);
        //UART1_Write_Text(uart_rd_text);
        //UART1_Write(0x0D);
        //UART1_Write(0x0A);
     Delay_ms(500);
  
  }



}