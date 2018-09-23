----------------------------------------------------------------------------------
-- COMPANY      : FPGATECHSOLUTION
-- MODULE NAME  : ADC_CONTROL
-- URL     		: WWW.FPGATECHSOLUTION.COM
----------------------------------------------------------------------------------
--


 LIBRARY IEEE;
 USE IEEE.STD_LOGIC_1164.ALL;
 USE IEEE.STD_LOGIC_ARITH.ALL;
 USE IEEE.STD_LOGIC_UNSIGNED.ALL;
 USE IEEE.NUMERIC_STD.ALL;

  ENTITY ADC_CONTROL IS
  GENERIC (ADC_NO_BIT: INTEGER RANGE 0 TO 15:=9   -- 9 FOR MCP3004 OR 11 FOR MCP3204OR 
 ); 
	PORT (  CLK     : IN  STD_LOGIC;
        RESET       : IN  STD_LOGIC;
        ADC_CLOCK   : OUT STD_LOGIC;-- ADC CLOCK 
        ADC_CS      : OUT STD_LOGIC; -- ADC CHIP SELECT 
        SPI_MISO    : IN  STD_LOGIC;-- ADC DATA IN ON SPI 
        SPI_MOSI    : OUT STD_LOGIC;-- ADC DATA OUT ON SPI
		  DATA_OUT_CH0    : OUT STD_LOGIC_VECTOR(ADC_NO_BIT DOWNTO 0); -- 10 DATA OUT FROM ADC
		  DATA_OUT_CH1    : OUT STD_LOGIC_VECTOR(ADC_NO_BIT DOWNTO 0); -- 10 DATA OUT FROM ADC
		  DATA_OUT_CH2    : OUT STD_LOGIC_VECTOR(ADC_NO_BIT DOWNTO 0); -- 10 DATA OUT FROM ADC
		  DATA_OUT_CH3    : OUT STD_LOGIC_VECTOR(ADC_NO_BIT DOWNTO 0)  -- 10 DATA OUT FROM ADC
		
          
       );
END ADC_CONTROL;

ARCHITECTURE BEHAVIORAL OF ADC_CONTROL IS


   -- CONSTANT ADC_SEL : STRING:="MCP3004"; --MCP3004 OR MCP3204
	CONSTANT SIG_DIFF:STD_LOGIC:='1';-- FOR SINGLE ENDED = '1'  OR FOR DIFFERENTIAL = '0'
	--CONSTANT ADC_NO_BIT: INTEGER RANGE 0 TO 15:=9;-- 9 FOR MCP3004 OR 11 FOR MCP3204
	
   
    SIGNAL DATA:  STD_LOGIC_VECTOR(15 DOWNTO 0);
     
    TYPE M_STATE_TYPE IS (IDEAL,CHIP_SEL,SEND_DATA,COMP_COUNT,RCV_DATA,SERIAL_DATA_IN,LATCH_IN_DATA,NEXT_CHANNAL );
    SIGNAL M_STATE : M_STATE_TYPE;    
    SIGNAL BIT_CNT: INTEGER RANGE 0 TO 15;
	 SIGNAL LATCH_CHANNAL_NO:  STD_LOGIC_VECTOR(12 DOWNTO 0);
    SIGNAL TEMP: STD_LOGIC_VECTOR (11 DOWNTO 0);
    SIGNAL ADC_CHANNAL : STD_LOGIC_VECTOR(1 DOWNTO 0);

    BEGIN
    





			
				PROCESS(CLK)
					BEGIN
						IF(RESET='1' )THEN
		
							ADC_CLOCK  <= '0';
							ADC_CS     <= '1';  
							SPI_MOSI   <= '0';
							TEMP<=(OTHERS=>'0');
							ADC_CHANNAL<="00";
							M_STATE <= IDEAL;
			
						ELSIF CLK'EVENT AND CLK = '1' THEN
				
							CASE M_STATE IS		
						
							WHEN IDEAL=>
							
									ADC_CLOCK  <= '0';
									ADC_CS   <= '1';  
									SPI_MOSI <= '0';
									BIT_CNT<=ADC_NO_BIT;
									M_STATE <= CHIP_SEL;
									IF(ADC_NO_BIT=9)THEN
										LATCH_CHANNAL_NO<="000001" & SIG_DIFF & '0' & ADC_CHANNAL & "000";
								
									ELSIF(ADC_NO_BIT=11)THEN
										LATCH_CHANNAL_NO<="0001" & SIG_DIFF & '0' & ADC_CHANNAL & "00XXX";
										
									END IF;
							
							
							WHEN CHIP_SEL=>
		
									ADC_CS   <= '0';
									M_STATE <= SEND_DATA;
						
							WHEN SEND_DATA=>
						
									SPI_MOSI<=LATCH_CHANNAL_NO (BIT_CNT);
									ADC_CLOCK<='0';
									M_STATE <= COMP_COUNT;
		
							WHEN COMP_COUNT=>
							
									ADC_CLOCK<='1';
									IF(BIT_CNT = 0)THEN			
										BIT_CNT<=ADC_NO_BIT;				
										M_STATE <= RCV_DATA;
									ELSE
										BIT_CNT<=BIT_CNT-1;
										M_STATE <= SEND_DATA;
									END IF;
			
							WHEN RCV_DATA=>
									ADC_CLOCK<='0';
									TEMP(BIT_CNT)<=SPI_MISO;
									M_STATE <= SERIAL_DATA_IN;
												
							WHEN SERIAL_DATA_IN=>					 
												
										ADC_CLOCK<='1';
									IF(BIT_CNT = 0)THEN			
										BIT_CNT<=12;							
										M_STATE <=LATCH_IN_DATA;
									ELSE
										BIT_CNT<=BIT_CNT-1;
										M_STATE <= RCV_DATA;
									END IF;
					
							WHEN LATCH_IN_DATA=>	
								
									IF(ADC_CHANNAL="00")THEN
										DATA_OUT_CH0<=TEMP(ADC_NO_BIT DOWNTO 0);
									ELSIF (ADC_CHANNAL="01")THEN
										DATA_OUT_CH1<=TEMP(ADC_NO_BIT DOWNTO 0);
									ELSIF (ADC_CHANNAL="10")THEN
										DATA_OUT_CH2<=TEMP(ADC_NO_BIT DOWNTO 0);
									ELSIF (ADC_CHANNAL="11")THEN
										DATA_OUT_CH3<=TEMP(ADC_NO_BIT DOWNTO 0);
									END IF;
									M_STATE <= NEXT_CHANNAL;
								
							WHEN NEXT_CHANNAL=>
								
										ADC_CHANNAL<=ADC_CHANNAL+1;
										M_STATE <= IDEAL;
												
			
		
							WHEN OTHERS=>	NULL;
								
								
							END CASE ;
						
						END IF;
		
				END PROCESS;
			
		
	END BEHAVIORAL;
		

