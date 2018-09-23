LIBRARY IEEE;
    USE IEEE.STD_LOGIC_1164.ALL;
    USE IEEE.STD_LOGIC_ARITH.ALL;
    USE IEEE.STD_LOGIC_UNSIGNED.ALL;

    
    ENTITY DAC IS
        PORT (  CLK			:IN  STD_LOGIC;
                RESET 		:IN  STD_LOGIC;
                DAC_CLK   	:OUT STD_LOGIC;
                DAC_CS    	:OUT STD_LOGIC;		  
                DAC_MOSI  	:OUT STD_LOGIC;
                DAC_CHANNEL	:IN  STD_LOGIC_VECTOR(1 DOWNTO 0):="01";
                DAC_DATA  	:IN  STD_LOGIC_VECTOR(7 DOWNTO 0)
                );
    END DAC;
    
    ARCHITECTURE BEHAVIORAL OF DAC IS
    
     SIGNAL DATA:  STD_LOGIC_VECTOR(15 DOWNTO 0);
     
    TYPE M_STATE_TYPE IS (ideal,in_data_latch,send_data,comp_count );
    SIGNAL M_STATE : M_STATE_TYPE;    
    SIGNAL bit_cnt: integer range 0 to 15;
    
    
    BEGIN
    
    
    
        PROCESS(CLK)
		
          BEGIN
    IF(RESET='1' )THEN
       
          DAC_CLK  <= '0';
          DAC_CS   <= '1';  
          DAC_MOSI <= '0';
          M_STATE <= ideal;
    
    ELSIF CLK'EVENT AND CLK = '1' THEN
        
                CASE M_STATE IS		
                
                    WHEN ideal=>
					
							DAC_CLK  <= '0';
							DAC_CS   <= '1';  
							DAC_MOSI <= '0';
							bit_cnt<=0;
							M_STATE <= in_data_latch;
					
					WHEN in_data_latch=>

							DATA<=( "0000" & dac_data & "10" & DAC_CHANNEL);
							DAC_CS   <= '0';
                			M_STATE <= send_data;
                
					WHEN send_data=>
                
							DAC_MOSI<=DATA (bit_cnt);
							DAC_CLK<='1';
							M_STATE <= comp_count;
 
					WHEN comp_count=>
					
							DAC_CLK<='0';
							IF(bit_cnt = 15)THEN
								DAC_CS<='1';
								M_STATE <= ideal;
							ELSE
								bit_cnt<=bit_cnt+1;
								M_STATE <= send_data;
							END IF;
      
 
                    WHEN OTHERS=>	NULL;
                        
                        
                END CASE ;
    END IF;

    END PROCESS;
    
   
    END BEHAVIORAL;