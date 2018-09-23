
-- VHDL Instantiation Created from source file ADC_CONTROL.vhd -- 21:51:55 09/23/2018
--
-- Notes: 
-- 1) This instantiation template has been automatically generated using types
-- std_logic and std_logic_vector for the ports of the instantiated module
-- 2) To use this template to instantiate this entity, cut-and-paste and then edit

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

	Inst_ADC_CONTROL: ADC_CONTROL PORT MAP(
		CLK => ,
		RESET => ,
		ADC_CLOCK => ,
		ADC_CS => ,
		SPI_MISO => ,
		SPI_MOSI => ,
		DATA_OUT_CH0 => ,
		DATA_OUT_CH1 => ,
		DATA_OUT_CH2 => ,
		DATA_OUT_CH3 => 
	);


