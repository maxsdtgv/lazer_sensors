char uart_rd;
char uart_rd_text[10];
unsigned char Can_Init_Flags, Can_Send_Flags, Can_Rcv_Flags; // can flags
unsigned char Rx_Data_Len;                                   // received data length in bytes
char RxTx_Data[8];                                           // can rx/tx data buffer
char Msg_Rcvd;                                               // reception flag
const long ID_1st = 1, ID_2nd = 2;                       // node IDs
long Rx_ID;




void main() {
     //=========================================================================
     OSCTUNE.PLLEN=1;   //****************************
     OSCCON.IRCF2=1;    //    Internal OSC = 8MHz
     OSCCON.IRCF1=1;    //
     OSCCON.IRCF0=1;    //****************************
     //=========================================================================
     UART1_Init(9600);  // Initialize UART module at 9600 bps
     Delay_ms(100);     // Wait for UART module to stabilize
     //=========================================================================
     Can_Init_Flags = 0;                                       //
     Can_Send_Flags = 0;                                       // clear flags
     Can_Rcv_Flags  = 0;  
                                          //
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
     
     //CANSetFilter(_CAN_FILTER_B2_F4,-1,_CAN_CONFIG_XTD_MSG);// set id of filter B2_F4 to 2nd node ID
     CANSetOperationMode(_CAN_MODE_NORMAL,0xFF);               // set NORMAL mode
     //=========================================================================
         UART1_Write_Text("Start6");
        UART1_Write(0x0D);
        UART1_Write(0x0A);
        TRISB.b1=0;
     PORTB.b1=0;
     Delay_ms(1000);
     PORTB.b1=1;
     Delay_ms(1000);
     PORTB.b1=0x00;

 while (1) {                     // Endless loop
    //if (UART1_Data_Ready()) {     // If data is received,
    //  uart_rd = UART1_Read();     // read the received data,
    // UART1_Write(uart_rd);       // and send data via UART
    //}
    Msg_Rcvd = CANRead(&Rx_ID , RxTx_Data , &Rx_Data_Len, &Can_Rcv_Flags); // receive message

    if (Msg_Rcvd) {
                                // if message received check id
        wordToStr(RxTx_Data[0], uart_rd_text);
        UART1_Write_Text(uart_rd_text);
        UART1_Write(0x0D);
        UART1_Write(0x0A);

    }

  
  }



}