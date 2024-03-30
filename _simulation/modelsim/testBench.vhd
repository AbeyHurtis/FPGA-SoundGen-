LIBRARY altera  ; 
LIBRARY altera_lnsim  ; 
LIBRARY cyclonev  ; 
LIBRARY ieee  ; 
LIBRARY std  ; 
USE altera.altera_primitives_components.all  ; 
USE altera_lnsim.altera_lnsim_components.all  ; 
USE cyclonev.cyclonev_components.all  ; 
USE ieee.std_logic_1164.all  ; 
USE ieee.std_logic_textio.all  ; 
USE ieee.std_logic_unsigned.all  ; 
USE std.textio.all  ; 
ENTITY testBench  IS 
END ; 
 
ARCHITECTURE testBench_arch OF testBench IS
  SIGNAL CLOCK_50   :  STD_LOGIC  ; 
  SIGNAL KEY   :  std_logic_vector (3 downto 0)  ; 
  SIGNAL AUD_DACLRCK   :  STD_LOGIC  ; 
  SIGNAL AUD_BCLK   :  STD_LOGIC  ; 
  SIGNAL AUD_DACDAT   :  STD_LOGIC  ; 
  SIGNAL AUD_XCK   :  STD_LOGIC  ; 
  COMPONENT audioController  
    PORT ( 
      CLOCK_50  : in STD_LOGIC ; 
      KEY  : in std_logic_vector (3 downto 0) ; 
      AUD_DACLRCK  : buffer STD_LOGIC ; 
      AUD_BCLK  : buffer STD_LOGIC ; 
      AUD_DACDAT  : buffer STD_LOGIC ; 
      AUD_XCK  : buffer STD_LOGIC ); 
  END COMPONENT ; 
BEGIN
  DUT  : audioController  
    PORT MAP ( 
      CLOCK_50   => CLOCK_50  ,
      KEY   => KEY  ,
      AUD_DACLRCK   => AUD_DACLRCK  ,
      AUD_BCLK   => AUD_BCLK  ,
      AUD_DACDAT   => AUD_DACDAT  ,
      AUD_XCK   => AUD_XCK   ) ; 



-- "Clock Pattern" : dutyCycle = 50
-- Start Time = 0 ns, End Time = 100 us, Period = 50 ns
  Process
	Begin
	 clock_50  <= '0'  ;
	wait for 25 ns ;
-- 25 ns, single loop till start period.
	for Z in 1 to 1000
	loop
	    clock_50  <= '1'  ;
	   wait for 25 ns ;
	    clock_50  <= '0'  ;
	   wait for 25 ns ;
-- 9975 ns, repeat pattern in loop.
	end  loop;
	 clock_50  <= '1'  ;
	wait for 25 ns ;
-- dumped values till 10 us
	wait;
 End Process;


-- "Constant Pattern"
-- Start Time = 0 ns, End Time = 100 us, Period = 0 ns
  Process
	Begin
	 key  <= "1011"  ;
	wait for 10000 ns ;
-- dumped values till 10 us
	wait;
 End Process;
END;
