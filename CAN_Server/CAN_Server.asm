
_main:

;CAN_Server.c,13 :: 		void main() {
;CAN_Server.c,15 :: 		OSCTUNE.PLLEN=1;   //****************************
	BSF         OSCTUNE+0, 6 
;CAN_Server.c,16 :: 		OSCCON.IRCF2=1;    //    Internal OSC = 8MHz
	BSF         OSCCON+0, 6 
;CAN_Server.c,17 :: 		OSCCON.IRCF1=1;    //
	BSF         OSCCON+0, 5 
;CAN_Server.c,18 :: 		OSCCON.IRCF0=1;    //****************************
	BSF         OSCCON+0, 4 
;CAN_Server.c,20 :: 		UART1_Init(9600);  // Initialize UART module at 9600 bps
	BSF         BAUDCON+0, 3, 0
	CLRF        SPBRGH+0 
	MOVLW       207
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
;CAN_Server.c,21 :: 		Delay_ms(100);     // Wait for UART module to stabilize
	MOVLW       2
	MOVWF       R11, 0
	MOVLW       4
	MOVWF       R12, 0
	MOVLW       186
	MOVWF       R13, 0
L_main0:
	DECFSZ      R13, 1, 1
	BRA         L_main0
	DECFSZ      R12, 1, 1
	BRA         L_main0
	DECFSZ      R11, 1, 1
	BRA         L_main0
	NOP
;CAN_Server.c,23 :: 		Can_Init_Flags = 0;                                       //
	CLRF        _Can_Init_Flags+0 
;CAN_Server.c,24 :: 		Can_Send_Flags = 0;                                       // clear flags
	CLRF        _Can_Send_Flags+0 
;CAN_Server.c,25 :: 		Can_Rcv_Flags  = 0;
	CLRF        _Can_Rcv_Flags+0 
;CAN_Server.c,29 :: 		_CAN_TX_NO_RTR_FRAME;
	MOVLW       252
	MOVWF       _Can_Send_Flags+0 
;CAN_Server.c,36 :: 		_CAN_CONFIG_LINE_FILTER_OFF;
	MOVLW       4
	MOVWF       _Can_Init_Flags+0 
;CAN_Server.c,40 :: 		CANInitialize(0,38,0,0,0,Can_Init_Flags);                  // Initialize CAN module
	CLRF        FARG_CANInitialize_SJW+0 
	MOVLW       38
	MOVWF       FARG_CANInitialize_BRP+0 
	CLRF        FARG_CANInitialize_PHSEG1+0 
	CLRF        FARG_CANInitialize_PHSEG2+0 
	CLRF        FARG_CANInitialize_PROPSEG+0 
	MOVLW       4
	MOVWF       FARG_CANInitialize_CAN_CONFIG_FLAGS+0 
	CALL        _CANInitialize+0, 0
;CAN_Server.c,41 :: 		CANSetOperationMode(_CAN_MODE_CONFIG,0xFF);               // set CONFIGURATION mode
	MOVLW       128
	MOVWF       FARG_CANSetOperationMode_mode+0 
	MOVLW       255
	MOVWF       FARG_CANSetOperationMode_WAIT+0 
	CALL        _CANSetOperationMode+0, 0
;CAN_Server.c,46 :: 		CANSetOperationMode(_CAN_MODE_NORMAL,0xFF);               // set NORMAL mode
	CLRF        FARG_CANSetOperationMode_mode+0 
	MOVLW       255
	MOVWF       FARG_CANSetOperationMode_WAIT+0 
	CALL        _CANSetOperationMode+0, 0
;CAN_Server.c,48 :: 		UART1_Write_Text("Start6");
	MOVLW       ?lstr1_CAN_Server+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr1_CAN_Server+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;CAN_Server.c,49 :: 		UART1_Write(0x0D);
	MOVLW       13
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;CAN_Server.c,50 :: 		UART1_Write(0x0A);
	MOVLW       10
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;CAN_Server.c,51 :: 		TRISB.b1=0;
	BCF         TRISB+0, 1 
;CAN_Server.c,52 :: 		PORTB.b1=0;
	BCF         PORTB+0, 1 
;CAN_Server.c,53 :: 		Delay_ms(1000);
	MOVLW       11
	MOVWF       R11, 0
	MOVLW       38
	MOVWF       R12, 0
	MOVLW       93
	MOVWF       R13, 0
L_main1:
	DECFSZ      R13, 1, 1
	BRA         L_main1
	DECFSZ      R12, 1, 1
	BRA         L_main1
	DECFSZ      R11, 1, 1
	BRA         L_main1
	NOP
	NOP
;CAN_Server.c,54 :: 		PORTB.b1=1;
	BSF         PORTB+0, 1 
;CAN_Server.c,55 :: 		Delay_ms(1000);
	MOVLW       11
	MOVWF       R11, 0
	MOVLW       38
	MOVWF       R12, 0
	MOVLW       93
	MOVWF       R13, 0
L_main2:
	DECFSZ      R13, 1, 1
	BRA         L_main2
	DECFSZ      R12, 1, 1
	BRA         L_main2
	DECFSZ      R11, 1, 1
	BRA         L_main2
	NOP
	NOP
;CAN_Server.c,56 :: 		PORTB.b1=0x00;
	BCF         PORTB+0, 1 
;CAN_Server.c,58 :: 		while (1) {                     // Endless loop
L_main3:
;CAN_Server.c,63 :: 		Msg_Rcvd = CANRead(&Rx_ID , RxTx_Data , &Rx_Data_Len, &Can_Rcv_Flags); // receive message
	MOVLW       _Rx_ID+0
	MOVWF       FARG_CANRead_id+0 
	MOVLW       hi_addr(_Rx_ID+0)
	MOVWF       FARG_CANRead_id+1 
	MOVLW       _RxTx_Data+0
	MOVWF       FARG_CANRead_data_+0 
	MOVLW       hi_addr(_RxTx_Data+0)
	MOVWF       FARG_CANRead_data_+1 
	MOVLW       _Rx_Data_Len+0
	MOVWF       FARG_CANRead_dataLen+0 
	MOVLW       hi_addr(_Rx_Data_Len+0)
	MOVWF       FARG_CANRead_dataLen+1 
	MOVLW       _Can_Rcv_Flags+0
	MOVWF       FARG_CANRead_CAN_RX_MSG_FLAGS+0 
	MOVLW       hi_addr(_Can_Rcv_Flags+0)
	MOVWF       FARG_CANRead_CAN_RX_MSG_FLAGS+1 
	CALL        _CANRead+0, 0
	MOVF        R0, 0 
	MOVWF       _Msg_Rcvd+0 
;CAN_Server.c,65 :: 		if (Msg_Rcvd) {
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main5
;CAN_Server.c,67 :: 		wordToStr(RxTx_Data[0], uart_rd_text);
	MOVF        _RxTx_Data+0, 0 
	MOVWF       FARG_WordToStr_input+0 
	MOVLW       0
	MOVWF       FARG_WordToStr_input+1 
	MOVLW       _uart_rd_text+0
	MOVWF       FARG_WordToStr_output+0 
	MOVLW       hi_addr(_uart_rd_text+0)
	MOVWF       FARG_WordToStr_output+1 
	CALL        _WordToStr+0, 0
;CAN_Server.c,68 :: 		UART1_Write_Text(uart_rd_text);
	MOVLW       _uart_rd_text+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(_uart_rd_text+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;CAN_Server.c,69 :: 		UART1_Write(0x0D);
	MOVLW       13
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;CAN_Server.c,70 :: 		UART1_Write(0x0A);
	MOVLW       10
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;CAN_Server.c,72 :: 		}
L_main5:
;CAN_Server.c,75 :: 		}
	GOTO        L_main3
;CAN_Server.c,79 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
