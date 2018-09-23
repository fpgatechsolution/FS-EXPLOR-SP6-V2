
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity top is
    Port ( 	reset 		: in  STD_LOGIC;
			clk_12mhz 	: in  STD_LOGIC;
			SIG_PD 		: OUT std_logic;
			lcd_dip		: in  STD_LOGIC;
			sig_a 		: OUT std_logic;
			sig_b 		: OUT std_logic;
			sig_c 		: OUT std_logic;
			sig_d 		: OUT std_logic;
			sig_e 		: OUT std_logic;
			sig_f 		: OUT std_logic;
			sig_g 		: OUT std_logic;
			sel_disp1 	: OUT std_logic;
			sel_disp2 	: OUT std_logic;
			sel_disp3 	: OUT std_logic;
			sel_disp4 	: OUT std_logic;
			
			sck			: OUT std_logic;
			cs_adc		: OUT std_logic;
			adc_out		: OUT std_logic;
			adc_in		: in std_logic;
			
            dip_led 	: out  STD_LOGIC_VECTOR (14 downto 0));
end top;

architecture Behavioral of top is	COMPONENT SEVEN_SEGMENT
	PORT(
		CLK_32KHZ : IN std_logic;
		RESET : IN std_logic;
		data_disp_1 : IN std_logic_vector(3 downto 0);
		data_disp_2 : IN std_logic_vector(3 downto 0);
		data_disp_3 : IN std_logic_vector(3 downto 0);
		data_disp_4 : IN std_logic_vector(3 downto 0);
		data_disp_5 : IN std_logic_vector(3 downto 0);
		data_disp_6 : IN std_logic_vector(3 downto 0);          
		SIG_PD : OUT std_logic;
		sig_a : OUT std_logic;
		sig_b : OUT std_logic;
		sig_c : OUT std_logic;
		sig_d : OUT std_logic;
		sig_e : OUT std_logic;
		sig_f : OUT std_logic;
		sig_g : OUT std_logic;
		sel_disp1 : OUT std_logic;
		sel_disp2 : OUT std_logic;
		sel_disp3 : OUT std_logic;
		sel_disp4 : OUT std_logic;
		sel_disp5 : OUT std_logic;
		sel_disp6 : OUT std_logic
		);
	END COMPONENT;
	COMPONENT LCD_CONTROL 
	PORT(
		reset : IN std_logic;
		clk_12Mhz : IN std_logic;
		C1L1 : IN std_logic_vector(7 downto 0);
		C2L1 : IN std_logic_vector(7 downto 0);
		C3L1 : IN std_logic_vector(7 downto 0);
		C4L1 : IN std_logic_vector(7 downto 0);
		C5L1 : IN std_logic_vector(7 downto 0);
		C6L1 : IN std_logic_vector(7 downto 0);
		C7L1 : IN std_logic_vector(7 downto 0);
		C8L1 : IN std_logic_vector(7 downto 0);
		C9L1 : IN std_logic_vector(7 downto 0);
		C10L1 : IN std_logic_vector(7 downto 0);
		C11L1 : IN std_logic_vector(7 downto 0);
		C12L1 : IN std_logic_vector(7 downto 0);
		C13L1 : IN std_logic_vector(7 downto 0);
		C14L1 : IN std_logic_vector(7 downto 0);
		C15L1 : IN std_logic_vector(7 downto 0);
		C16L1 : IN std_logic_vector(7 downto 0);
		C1L2 : IN std_logic_vector(7 downto 0);
		C2L2 : IN std_logic_vector(7 downto 0);
		C3L2 : IN std_logic_vector(7 downto 0);
		C4L2 : IN std_logic_vector(7 downto 0);
		C5L2 : IN std_logic_vector(7 downto 0);
		C6L2 : IN std_logic_vector(7 downto 0);
		C7L2 : IN std_logic_vector(7 downto 0);
		C8L2 : IN std_logic_vector(7 downto 0);
		C9L2 : IN std_logic_vector(7 downto 0);
		C10L2 : IN std_logic_vector(7 downto 0);
		C11L2 : IN std_logic_vector(7 downto 0);
		C12L2 : IN std_logic_vector(7 downto 0);
		C13L2 : IN std_logic_vector(7 downto 0);
		C14L2 : IN std_logic_vector(7 downto 0);
		C15L2 : IN std_logic_vector(7 downto 0);
		C16L2 : IN std_logic_vector(7 downto 0);        
		LCD_RS : OUT std_logic;
		LCD_E : OUT std_logic;
		LCD_RW : OUT std_logic;
		DATA_BUS : OUT std_logic_vector(7 downto 0)
		);
	END COMPONENT;

	COMPONENT clk_dcm
	PORT(
		CLK_IN1 : IN std_logic;
		CLK_OUT1 : OUT std_logic;
		CLK_OUT2 : OUT std_logic
		);
	END COMPONENT;
	
	
	
	COMPONENT ADC_CONTROL
	PORT(
		CLK : IN std_logic;
		RESET : IN std_logic;
		SPI_MISO : IN std_logic;          
		ADC_CLOCK : OUT std_logic;
		ADC_CS : OUT std_logic;
		SPI_MOSI : OUT std_logic;
		DATA_OUT_CH0 : OUT std_logic_vector(9 downto 0);
		DATA_OUT_CH1 : OUT std_logic_vector(9 downto 0);
		DATA_OUT_CH2 : OUT std_logic_vector(9 downto 0);
		DATA_OUT_CH3 : OUT std_logic_vector(9 downto 0)
		);
	END COMPONENT;
	
 	COMPONENT binbcd16
	PORT(
		B : IN std_logic_vector(15 downto 0);          
		P : OUT std_logic_vector(18 downto 0)
		);
	END COMPONENT;



signal b1,b2,b3,b4,b5:STD_LOGIC_VECTOR (7 downto 0);
signal DATA_BUS:STD_LOGIC_VECTOR (7 downto 0);
signal sig_a1,sig_b1,sig_c1,sig_d1,sig_e1,sig_f1,sig_g1,SIG_PD1,sel_disp11,sel_disp22,sel_disp33,sel_disp44:STD_LOGIC;

signal LCD_RS,LCD_e:STD_LOGIC;
signal bcd:std_logic_vector(18 downto 0);

SIGNAL B1_CH1,B2_CH1,B3_CH1,B4_CH1:STD_LOGIC_VECTOR (7 DOWNTO 0);
SIGNAL B1_CH2,B2_CH2,B3_CH2,B4_CH2:STD_LOGIC_VECTOR (7 DOWNTO 0);
SIGNAL B1_CH3,B2_CH3,B3_CH3,B4_CH3:STD_LOGIC_VECTOR (7 DOWNTO 0);
SIGNAL B1_CH4,B2_CH4,B3_CH4,B4_CH4:STD_LOGIC_VECTOR (7 DOWNTO 0);
SIGNAL BCD_CH1:STD_LOGIC_VECTOR(18 DOWNTO 0);
SIGNAL BCD_CH2:STD_LOGIC_VECTOR(18 DOWNTO 0);
SIGNAL BCD_CH3:STD_LOGIC_VECTOR(18 DOWNTO 0);
SIGNAL BCD_CH4:STD_LOGIC_VECTOR(18 DOWNTO 0);

SIGNAL COUNT_VAL_CH1:STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL COUNT_VAL_CH2:STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL COUNT_VAL_CH3:STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL COUNT_VAL_CH4:STD_LOGIC_VECTOR(15 DOWNTO 0);

SIGNAL DATA_OUT_ADC_CH1:STD_LOGIC_VECTOR(9 DOWNTO 0);
SIGNAL DATA_OUT_ADC_CH2:STD_LOGIC_VECTOR(9 DOWNTO 0);
SIGNAL DATA_OUT_ADC_CH3:STD_LOGIC_VECTOR(9 DOWNTO 0);
SIGNAL DATA_OUT_ADC_CH4:STD_LOGIC_VECTOR(9 DOWNTO 0);

SIGNAL MUL_CH1:STD_LOGIC_VECTOR(35 DOWNTO 0);
SIGNAL MUL_CH2:STD_LOGIC_VECTOR(35 DOWNTO 0);
SIGNAL MUL_CH3:STD_LOGIC_VECTOR(35 DOWNTO 0);
SIGNAL MUL_CH4:STD_LOGIC_VECTOR(35 DOWNTO 0);

SIGNAL M_CH1:STD_LOGIC_VECTOR(23 DOWNTO 0);
SIGNAL M_CH2:STD_LOGIC_VECTOR(23 DOWNTO 0);
SIGNAL M_CH3:STD_LOGIC_VECTOR(17 DOWNTO 0);
SIGNAL M_CH4:STD_LOGIC_VECTOR(17 DOWNTO 0);

SIGNAL TEST_CS_ADC:STD_LOGIC;
SIGNAL TEST_ADC_IN:STD_LOGIC;
SIGNAL TEST_ADC_OUT:STD_LOGIC;
SIGNAL TEST_SCK:STD_LOGIC;
SIGNAL CLK_12MH,clk_1mh:STD_LOGIC;

begin

--######################################################################################
--################################### DCM ##############################################


	Inst_dcm: clk_dcm PORT MAP(
		CLK_IN1 =>CLK_12MHZ ,
		CLK_OUT1 =>CLK_12MH ,
		CLK_OUT2 =>clk_1mh 
	);

--#######################################################################################
--########################## SEVEN SEGMENT ##############################################

	
	Inst_SEVEN_SEGMENT: SEVEN_SEGMENT PORT MAP(
		CLK_32KHZ =>CLK_12MH ,
		RESET =>RESET ,
		SIG_PD =>SIG_PD1 ,
		sig_a =>sig_a1 ,
		sig_b => sig_b1,
		sig_c =>sig_c1 ,
		sig_d =>sig_d1 ,
		sig_e =>sig_e1 ,
		sig_f =>sig_f1 ,
		sig_g =>sig_g1 ,
		sel_disp1 =>sel_disp11 ,
		sel_disp2 =>sel_disp22 ,
		sel_disp3 =>sel_disp3 ,
		sel_disp4 =>sel_disp4 ,
		sel_disp5 =>open ,
		sel_disp6 =>open ,
		data_disp_1 =>B1_CH1( 3 DOWNTO 0) ,
		data_disp_2 =>B2_CH1( 3 DOWNTO 0) ,
		data_disp_3 =>B3_CH1( 3 DOWNTO 0) ,
		data_disp_4 =>B4_CH1 ( 3 DOWNTO 0),
		data_disp_5 =>"0001",
		data_disp_6 =>"0001"
);


dip_led(9 downto 0)<=DATA_OUT_ADC_CH1(9 downto 0);




		SIG_PD <=SIG_PD1 when lcd_dip='1' else DATA_BUS(0);
		sig_a <=sig_g1  when lcd_dip='1' else DATA_BUS(3);
		sig_b <= sig_f1 when lcd_dip='1' else DATA_BUS(2);
		sig_c <=sig_e1  when lcd_dip='1' else DATA_BUS(1);
		sig_d <=sig_d1  when lcd_dip='1' else DATA_BUS(4);
		sig_e <=sig_c1  when lcd_dip='1' else DATA_BUS(5);
		sig_f <=sig_b1  when lcd_dip='1' else DATA_BUS(7);
		sig_g <=sig_a1  when lcd_dip='1' else DATA_BUS(6);
		sel_disp1 <=sel_disp11  when lcd_dip='1' else LCD_e;
		sel_disp2 <=sel_disp22  when lcd_dip='1' else LCD_rs;



--#######################################################################################
--########################## LCD CONTROL ################################################


	INST_LCD: LCD_CONTROL  PORT MAP(
		RESET => RESET ,
		CLK_12MHZ =>CLK_12MH ,
		LCD_RS =>LCD_RS ,
		LCD_E =>LCD_E ,
		LCD_RW =>OPEN ,
		C1L1 =>X"43",
		C2L1 =>X"30",
		C3L1 =>X"20",
		C4L1 =>B1_CH1,
		C5L1 =>B2_CH1 ,
		C6L1 =>B3_CH1  ,
		C7L1 =>B4_CH1 ,
		C8L1 =>X"20"  ,
		C9L1 =>X"20"  ,
		C10L1 =>X"43"  ,
		C11L1 =>X"31"  ,
		C12L1 =>X"20"  ,
		C13L1 =>B1_CH2,
		C14L1 =>B2_CH2,
		C15L1 =>B3_CH2,
		C16L1 =>B4_CH2,
		
		C1L2 =>X"43",
		C2L2 =>X"32",
		C3L2 =>X"20",
		C4L2 =>B1_CH3,
		C5L2 =>B2_CH3 ,
		C6L2 =>B3_CH3 ,
		C7L2 =>B4_CH3  ,
		C8L2 =>X"20"  ,
		C9L2 =>X"20"  ,
		C10L2 =>X"43" ,
		C11L2 =>X"33" ,
		C12L2 =>X"20" ,
		C13L2 =>B1_CH4 ,
		C14L2 =>B2_CH4 ,
		C15L2 =>B3_CH4 ,
		C16L2 =>B4_CH4 ,
		DATA_BUS =>DATA_BUS 
	);

--######################################################################################
--################################### Bcd to Ascii #####################################
B4_CH1<=("0011" & BCD_CH1( 3 DOWNTO 0));
B3_CH1<=("0011" & BCD_CH1( 7 DOWNTO 4));
B2_CH1<=("0011" & BCD_CH1( 11 DOWNTO 8));
B1_CH1<=("0011" & BCD_CH1( 15 DOWNTO 12));
--######################################################################################
--###################################Binary to bcd######################################
	INST_binbcd16_CH1: binbcd16 PORT MAP(
		B => COUNT_VAL_CH1,
		P =>BCD_CH1 
	);
COUNT_VAL_CH1<=("000000" & DATA_OUT_ADC_CH1);



--######################################################################################
--################################### Bcd to Ascii #####################################
B4_CH2<=("0011" & BCD_CH2( 3 DOWNTO 0));
B3_CH2<=("0011" & BCD_CH2( 7 DOWNTO 4));
B2_CH2<=("0011" & BCD_CH2( 11 DOWNTO 8));
B1_CH2<=("0011" & BCD_CH2( 15 DOWNTO 12));
--######################################################################################
--###################################Binary to bcd######################################
	INST_binbcd16_CH2: binbcd16 PORT MAP(
		B => COUNT_VAL_CH2,
		P =>BCD_CH2 
	);
COUNT_VAL_CH2<=("000000" & DATA_OUT_ADC_CH2);




--######################################################################################
--################################### Bcd to Ascii #####################################
B4_CH3<=("0011" & BCD_CH3( 3 DOWNTO 0));
B3_CH3<=("0011" & BCD_CH3( 7 DOWNTO 4));
B2_CH3<=("0011" & BCD_CH3( 11 DOWNTO 8));
B1_CH3<=("0011" & BCD_CH3( 15 DOWNTO 12));
--######################################################################################
--###################################Binary to bcd######################################
	INST_binbcd16_CH3: binbcd16 PORT MAP(
		B => COUNT_VAL_CH3,
		P =>BCD_CH3 
	);
COUNT_VAL_CH3<=("000000" & DATA_OUT_ADC_CH3);




--######################################################################################
--################################### Bcd to Ascii #####################################
B4_CH4<=("0011" & BCD_CH4( 3 DOWNTO 0));
B3_CH4<=("0011" & BCD_CH4( 7 DOWNTO 4));
B2_CH4<=("0011" & BCD_CH4( 11 DOWNTO 8));
B1_CH4<=("0011" & BCD_CH4( 15 DOWNTO 12));
--######################################################################################
--###################################Binary to bcd######################################
	INST_binbcd16_CH4: binbcd16 PORT MAP(
		B => COUNT_VAL_CH4,
		P =>BCD_CH4 
	);
COUNT_VAL_CH4<=("000000" & DATA_OUT_ADC_CH4);





--######################################################################################
--################################### ADC ##############################################



	Inst_ADC_CONTROL: ADC_CONTROL PORT MAP(
		CLK =>clk_1mh ,
		RESET =>RESET ,
		ADC_CLOCK =>sck ,
		ADC_CS =>cs_adc ,
		SPI_MISO =>adc_in ,
		SPI_MOSI =>ADC_OUT ,
		DATA_OUT_CH0 =>DATA_OUT_ADC_CH1 ,
		DATA_OUT_CH1 =>DATA_OUT_ADC_CH2 ,
		DATA_OUT_CH2 =>DATA_OUT_ADC_CH3 ,
		DATA_OUT_CH3 =>DATA_OUT_ADC_CH4 
	);






end Behavioral;

