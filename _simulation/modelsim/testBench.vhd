LIBRARY altera  ; 
LIBRARY altera_lnsim  ; 
LIBRARY cyclonev  ; 
LIBRARY ieee  ; 
LIBRARY std  ; 
USE altera.altera_primitives_components.all  ; 
USE altera_lnsim.altera_lnsim_components.all  ; 
USE cyclonev.cyclonev_components.all  ; 
USE ieee.std_logic_1164.all  ; 
USE ieee.std_logic_arith.all  ; 
USE ieee.std_logic_textio.all  ; 
USE ieee.std_logic_unsigned.all  ; 
USE std.textio.all  ; 
ENTITY testBench  IS 
END ; 
 
ARCHITECTURE testBench_arch OF testBench IS
  SIGNAL aud_out   :  INTEGER range 0 to 1000; 
  SIGNAL switches   :  std_logic_vector (2 downto 0)  ; 
  SIGNAL CLK   :  STD_LOGIC  ; 
  SIGNAL RESET   :  STD_LOGIC  ; 
  COMPONENT audioController  
    PORT ( 
      aud_out  : out INTEGER; 
      switches  : in std_logic_vector (2 downto 0) ; 
      CLK  : in STD_LOGIC ; 
      RESET  : in STD_LOGIC ); 
  END COMPONENT ; 
BEGIN
  DUT  : audioController  
    PORT MAP ( 
      aud_out   => aud_out  ,
      switches   => switches  ,
      CLK   => CLK  ,
      RESET   => RESET   ) ; 



-- "Clock Pattern" : dutyCycle = 50
-- Start Time = 0 ns, End Time = 3 us, Period = 100 ns
  Process
	Begin
	CLK  <= '0'  ;
	wait for 50 ns ;
-- 50 ns, single loop till start period.
	for Z in 1 to 60
	loop
	    CLK  <= '1'  ;
	   wait for 50 ns ;
	    CLK  <= '0'  ;
	   wait for 50 ns ;
-- 2950 ns, repeat pattern in loop.
	end  loop;
	 CLK  <= '1'  ;
	wait for 50 ns ;
-- dumped values till 3 us
	wait;
 End Process;


-- "Constant Pattern"
-- Start Time = 0 ns, End Time = 3 us, Period = 0 ns
  Process
	Begin
	 reset  <= '0'  ;
	wait for 3 us ;
-- dumped values till 3 us
	wait;
 End Process;


-- "Repeater Pattern" Repeat Forever
-- Start Time = 0 ns, End Time = 3 us, Period = 1 us
  Process
	Begin
	    switches  <= "100"  ;
	   wait for 2 us ;
	    switches  <= "010"  ;
	   wait for 2 us ;
	    switches  <= "001"  ;
	   wait for 2 us ;
-- 3 us, repeat pattern in loop.
	wait;
 End Process;
END;
