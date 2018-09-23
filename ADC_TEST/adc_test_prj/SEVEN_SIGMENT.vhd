



LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_SIGNED.ALL;

ENTITY SEVEN_SEGMENT IS 

PORT	(	
			  CLK_32KHZ:IN STD_LOGIC;--CLOCK INPUT       
			  RESET:IN STD_LOGIC;--RESET INPUT
			  SIG_PD:OUT STD_LOGIC;		
		     sig_a : out  STD_LOGIC;
           sig_b : out  STD_LOGIC;
           sig_c : out  STD_LOGIC;
           sig_d : out  STD_LOGIC;
           sig_e : out  STD_LOGIC;
           sig_f : out  STD_LOGIC;
           sig_g : out  STD_LOGIC;
       
           sel_disp1 : out  STD_LOGIC;
           sel_disp2 : out  STD_LOGIC;
           sel_disp3 : out  STD_LOGIC;
           sel_disp4 : out  STD_LOGIC;
           sel_disp5 : out  STD_LOGIC;
           sel_disp6 : out  STD_LOGIC;
			  data_disp_1: IN STD_LOGIC_VECTOR (3 downto 0);
			  data_disp_2: IN STD_LOGIC_VECTOR (3 downto 0);
			  data_disp_3: IN STD_LOGIC_VECTOR (3 downto 0);
			  data_disp_4: IN STD_LOGIC_VECTOR (3 downto 0);
			  data_disp_5: IN STD_LOGIC_VECTOR (3 downto 0);
			  data_disp_6: IN STD_LOGIC_VECTOR (3 downto 0)
		
);

END SEVEN_SEGMENT; 


ARCHITECTURE BEHAVE OF SEVEN_SEGMENT IS 

signal BCD: STD_LOGIC_VECTOR(2 DOWNTO 0);
signal COUNT: STD_LOGIC_VECTOR(9 DOWNTO 0);
signal COUNT_BCD: STD_LOGIC_VECTOR(3 DOWNTO 0);
signal DISP: STD_LOGIC_VECTOR(6 DOWNTO 0);
SIGNAL CLK_7_SIG:STD_LOGIC;

BEGIN

process (CLK_32KHZ) 
begin
   if reset='1'  then 
     COUNT <= (others => '0');
  elsif CLK_32KHZ='1' and CLK_32KHZ'event then
      
         COUNT <= COUNT + 1;
     
   end if;
end process;


CLK_7_SIG<=COUNT(4);

process (CLK_7_SIG) 
begin
   if( reset='1' or BCD=4 )then 
     BCD <= (others => '0');
  elsif CLK_7_SIG='1' and CLK_7_SIG'event then
      
         BCD <= BCD + 1;
     
   end if;
end process;




process (CLK_7_SIG) 
begin
   case (BCD) is 
      when "000" =>
           sel_disp1 <='1';
           sel_disp2 <='0';
           sel_disp3 <='0';
           sel_disp4 <='0';
           sel_disp5 <='1';
           sel_disp6 <='1';

		  COUNT_BCD<=data_disp_1;
      when "001" =>
           sel_disp1 <='0';
           sel_disp2 <='1';
           sel_disp3 <='0';
           sel_disp4 <='0';
           sel_disp5 <='1';
           sel_disp6 <='1';


		  COUNT_BCD<=data_disp_2;

      when "010" =>
           sel_disp1 <='0';
           sel_disp2 <='0';
           sel_disp3 <='1';
           sel_disp4 <='0';
           sel_disp5 <='1';
           sel_disp6 <='1';

		  COUNT_BCD<=data_disp_3;


      when "011" =>
           sel_disp1 <='0';
           sel_disp2 <='0';
           sel_disp3 <='0';
           sel_disp4 <='1';
           sel_disp5 <='1';
           sel_disp6 <='1';

		  COUNT_BCD<=data_disp_4;

      when "100" =>
--           sel_disp1 <='1';
--           sel_disp2 <='1';
--           sel_disp3 <='1';
--           sel_disp4 <='1';
--           sel_disp5 <='0';
--           sel_disp6 <='1';

		--  COUNT_BCD<=data_disp_5;

      when "101" =>
--           sel_disp1 <='1';
--           sel_disp2 <='1';
--           sel_disp3 <='1';
--           sel_disp4 <='1';
--           sel_disp5 <='1';
--           sel_disp6 <='0';


		 -- COUNT_BCD<=data_disp_6;


    
      when others =>
       null;
   end case;
		
end process;
SIG_PD<='1';

		     sig_a <=NOT (DISP(0));
           sig_b <=NOT (DISP(1));
           sig_c <=NOT (DISP(2));
           sig_d <=NOT (DISP(3));
           sig_e <=NOT (DISP(4));
           sig_f <=NOT (DISP(5));
           sig_g <=NOT (DISP(6));


--SIG_7<=NOT (DISP);

with COUNT_BCD select
DISP	<= 
		"1111110" when "0000" ,  -- 0
	   "0110000" when "0001" ,  -- 1
	   "1101101" when "0010" ,  -- 2
	   "1111001" when "0011" ,  -- 3	   
		"0110011" when "0100" ,  -- 4
	   "1011011" when "0101" ,  -- 5
	   "1011111" when "0110" ,  -- 6
	   "1110000" when "0111" ,  -- 7
	   "1111111" when "1000" ,  -- 8
	   "1111011" when "1001" ,  -- 9
	   "1110111" when "1010" ,  -- A
	   "0011111" when "1011" ,  -- B
	   "1001110" when "1100" ,  -- C
	   "0111101" when "1101" ,  -- D
	   "1001111" when "1110" ,  -- E
	   "1000111" when "1111" ,  -- F
	   "0000001" when others;   -- '-'
END BEHAVE;
