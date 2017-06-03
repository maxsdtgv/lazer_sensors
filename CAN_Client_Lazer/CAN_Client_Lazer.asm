
_main:

;CAN_Client_Lazer.c,26 :: 		void main() {
;CAN_Client_Lazer.c,28 :: 		OSCTUNE.PLLEN=1;   //****************************
	BSF         OSCTUNE+0, 6 
;CAN_Client_Lazer.c,29 :: 		OSCCON.IRCF2=1;    //    Internal OSC = 8MHz
	BSF         OSCCON+0, 6 
;CAN_Client_Lazer.c,30 :: 		OSCCON.IRCF1=1;    //
	BSF         OSCCON+0, 5 
;CAN_Client_Lazer.c,31 :: 		OSCCON.IRCF0=1;    //****************************
	BSF         OSCCON+0, 4 
;CAN_Client_Lazer.c,36 :: 		Can_Init_Flags = 0;                                       //
	CLRF        _Can_Init_Flags+0 
;CAN_Client_Lazer.c,37 :: 		Can_Send_Flags = 0;                                       // clear flags
	CLRF        _Can_Send_Flags+0 
;CAN_Client_Lazer.c,38 :: 		Can_Rcv_Flags  = 0;                                       //
	CLRF        _Can_Rcv_Flags+0 
;CAN_Client_Lazer.c,42 :: 		_CAN_TX_NO_RTR_FRAME;
	MOVLW       252
	MOVWF       _Can_Send_Flags+0 
;CAN_Client_Lazer.c,49 :: 		_CAN_CONFIG_LINE_FILTER_OFF;
	MOVLW       4
	MOVWF       _Can_Init_Flags+0 
;CAN_Client_Lazer.c,53 :: 		CANInitialize(0,38,0,0,0,Can_Init_Flags);                  // Initialize CAN module
	CLRF        FARG_CANInitialize_SJW+0 
	MOVLW       38
	MOVWF       FARG_CANInitialize_BRP+0 
	CLRF        FARG_CANInitialize_PHSEG1+0 
	CLRF        FARG_CANInitialize_PHSEG2+0 
	CLRF        FARG_CANInitialize_PROPSEG+0 
	MOVLW       4
	MOVWF       FARG_CANInitialize_CAN_CONFIG_FLAGS+0 
	CALL        _CANInitialize+0, 0
;CAN_Client_Lazer.c,54 :: 		CANSetOperationMode(_CAN_MODE_CONFIG,0xFF);               // set CONFIGURATION mode
	MOVLW       128
	MOVWF       FARG_CANSetOperationMode_mode+0 
	MOVLW       255
	MOVWF       FARG_CANSetOperationMode_WAIT+0 
	CALL        _CANSetOperationMode+0, 0
;CAN_Client_Lazer.c,59 :: 		CANSetOperationMode(_CAN_MODE_NORMAL,0xFF);               // set NORMAL mode
	CLRF        FARG_CANSetOperationMode_mode+0 
	MOVLW       255
	MOVWF       FARG_CANSetOperationMode_WAIT+0 
	CALL        _CANSetOperationMode+0, 0
;CAN_Client_Lazer.c,61 :: 		ADCON1.VCFG0=0;  //  Connect Vref to internal source
	BCF         ADCON1+0, 4 
;CAN_Client_Lazer.c,62 :: 		ADCON1.VCFG1=0;
	BCF         ADCON1+0, 5 
;CAN_Client_Lazer.c,63 :: 		LAZER_input_Direction=1; // Input AN1 as input tris
	BSF         TRISA1_bit+0, BitPos(TRISA1_bit+0) 
;CAN_Client_Lazer.c,66 :: 		LED_Lazerdetect_Direction=0;
	BCF         TRISB0_bit+0, BitPos(TRISB0_bit+0) 
;CAN_Client_Lazer.c,67 :: 		LED_CANactive_Direction=0;
	BCF         TRISB1_bit+0, BitPos(TRISB1_bit+0) 
;CAN_Client_Lazer.c,68 :: 		LAZER_Direction=0;
	BCF         TRISB4_bit+0, BitPos(TRISB4_bit+0) 
;CAN_Client_Lazer.c,71 :: 		LED_Lazerdetect=1;
	BSF         RB0_bit+0, BitPos(RB0_bit+0) 
;CAN_Client_Lazer.c,72 :: 		LED_CANactive=1;
	BSF         RB1_bit+0, BitPos(RB1_bit+0) 
;CAN_Client_Lazer.c,73 :: 		LAZER=0;
	BCF         RB4_bit+0, BitPos(RB4_bit+0) 
;CAN_Client_Lazer.c,74 :: 		Delay_ms(1000);
	MOVLW       11
	MOVWF       R11, 0
	MOVLW       38
	MOVWF       R12, 0
	MOVLW       93
	MOVWF       R13, 0
L_main0:
	DECFSZ      R13, 1, 1
	BRA         L_main0
	DECFSZ      R12, 1, 1
	BRA         L_main0
	DECFSZ      R11, 1, 1
	BRA         L_main0
	NOP
	NOP
;CAN_Client_Lazer.c,75 :: 		LED_Lazerdetect=0;
	BCF         RB0_bit+0, BitPos(RB0_bit+0) 
;CAN_Client_Lazer.c,76 :: 		LED_CANactive=0;
	BCF         RB1_bit+0, BitPos(RB1_bit+0) 
;CAN_Client_Lazer.c,77 :: 		LAZER=1;
	BSF         RB4_bit+0, BitPos(RB4_bit+0) 
;CAN_Client_Lazer.c,79 :: 		Delay_ms(1000);
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
;CAN_Client_Lazer.c,80 :: 		LED_Lazerdetect=1;
	BSF         RB0_bit+0, BitPos(RB0_bit+0) 
;CAN_Client_Lazer.c,81 :: 		LED_CANactive=1;
	BSF         RB1_bit+0, BitPos(RB1_bit+0) 
;CAN_Client_Lazer.c,82 :: 		LAZER=1;
	BSF         RB4_bit+0, BitPos(RB4_bit+0) 
;CAN_Client_Lazer.c,85 :: 		while (1) {                     // Endless loop
L_main2:
;CAN_Client_Lazer.c,90 :: 		ad_res = ADC_Read(1);   // Get 10-bit results of AD conversion
	MOVLW       1
	MOVWF       FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _ad_res+0 
	MOVF        R1, 0 
	MOVWF       _ad_res+1 
;CAN_Client_Lazer.c,91 :: 		if(ad_res < 500) {LED_Lazerdetect=0;} else {LED_Lazerdetect=1;}
	MOVLW       1
	SUBWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main8
	MOVLW       244
	SUBWF       R0, 0 
L__main8:
	BTFSC       STATUS+0, 0 
	GOTO        L_main4
	BCF         RB0_bit+0, BitPos(RB0_bit+0) 
	GOTO        L_main5
L_main4:
	BSF         RB0_bit+0, BitPos(RB0_bit+0) 
L_main5:
;CAN_Client_Lazer.c,92 :: 		RxTx_Data[0] = ad_res;
	MOVF        _ad_res+0, 0 
	MOVWF       _RxTx_Data+0 
;CAN_Client_Lazer.c,93 :: 		RxTx_Data[1] = ad_res >> 8;
	MOVF        _ad_res+1, 0 
	MOVWF       R0 
	CLRF        R1 
	MOVF        R0, 0 
	MOVWF       _RxTx_Data+1 
;CAN_Client_Lazer.c,94 :: 		CANWrite(ID_2nd, RxTx_Data, 8, Can_Send_Flags);           // send initial message
	MOVLW       2
	MOVWF       FARG_CANWrite_id+0 
	MOVLW       0
	MOVWF       FARG_CANWrite_id+1 
	MOVLW       0
	MOVWF       FARG_CANWrite_id+2 
	MOVLW       0
	MOVWF       FARG_CANWrite_id+3 
	MOVLW       _RxTx_Data+0
	MOVWF       FARG_CANWrite_data_+0 
	MOVLW       hi_addr(_RxTx_Data+0)
	MOVWF       FARG_CANWrite_data_+1 
	MOVLW       8
	MOVWF       FARG_CANWrite_DataLen+0 
	MOVF        _Can_Send_Flags+0, 0 
	MOVWF       FARG_CANWrite_CAN_TX_MSG_FLAGS+0 
	CALL        _CANWrite+0, 0
;CAN_Client_Lazer.c,101 :: 		Delay_ms(500);
	MOVLW       6
	MOVWF       R11, 0
	MOVLW       19
	MOVWF       R12, 0
	MOVLW       173
	MOVWF       R13, 0
L_main6:
	DECFSZ      R13, 1, 1
	BRA         L_main6
	DECFSZ      R12, 1, 1
	BRA         L_main6
	DECFSZ      R11, 1, 1
	BRA         L_main6
	NOP
	NOP
;CAN_Client_Lazer.c,103 :: 		}
	GOTO        L_main2
;CAN_Client_Lazer.c,107 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
