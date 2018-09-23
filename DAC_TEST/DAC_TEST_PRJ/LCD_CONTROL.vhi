
-- VHDL Instantiation Created from source file LCD_CONTROL.vhd -- 17:17:19 09/23/2018
--
-- Notes: 
-- 1) This instantiation template has been automatically generated using types
-- std_logic and std_logic_vector for the ports of the instantiated module
-- 2) To use this template to instantiate this entity, cut-and-paste and then edit

	COMPONENT LCD_CONTROL
	PORT(
		reset : IN std_logic;
		CLK_12MHZ : IN std_logic;
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

	Inst_LCD_CONTROL: LCD_CONTROL PORT MAP(
		reset => ,
		CLK_12MHZ => ,
		LCD_RS => ,
		LCD_E => ,
		LCD_RW => ,
		C1L1 => ,
		C2L1 => ,
		C3L1 => ,
		C4L1 => ,
		C5L1 => ,
		C6L1 => ,
		C7L1 => ,
		C8L1 => ,
		C9L1 => ,
		C10L1 => ,
		C11L1 => ,
		C12L1 => ,
		C13L1 => ,
		C14L1 => ,
		C15L1 => ,
		C16L1 => ,
		C1L2 => ,
		C2L2 => ,
		C3L2 => ,
		C4L2 => ,
		C5L2 => ,
		C6L2 => ,
		C7L2 => ,
		C8L2 => ,
		C9L2 => ,
		C10L2 => ,
		C11L2 => ,
		C12L2 => ,
		C13L2 => ,
		C14L2 => ,
		C15L2 => ,
		C16L2 => ,
		DATA_BUS => 
	);


