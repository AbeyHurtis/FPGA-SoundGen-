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
ENTITY testB  IS 
END ; 
 
ARCHITECTURE testB_arch OF testB IS
  SIGNAL switch   :  STD_LOGIC  ; 
  SIGNAL clk   :  STD_LOGIC  ; 
  SIGNAL pwm_out   :  STD_LOGIC  ; 
  SIGNAL reset   :  STD_LOGIC  ; 
  COMPONENT testproject  
    PORT ( 
      switch  : in STD_LOGIC ; 
      clk  : in STD_LOGIC ; 
      pwm_out  : buffer STD_LOGIC ; 
      reset  : in STD_LOGIC ); 
  END COMPONENT ; 
BEGIN
  DUT  : testproject  
    PORT MAP ( 
      switch   => switch  ,
      clk   => clk  ,
      pwm_out   => pwm_out  ,
      reset   => reset   ) ; 



-- "Clock Pattern" : dutyCycle = 50
-- Start Time = 0 ns, End Time = 1 us, Period = 100 ns
  Process
	Begin
	 clk  <= '0'  ;
	wait for 50 ns ;
-- 50 ns, single loop till start period.
	for Z in 1 to 9
	loop
	    clk  <= '1'  ;
	   wait for 50 ns ;
	    clk  <= '0'  ;
	   wait for 50 ns ;
-- 950 ns, repeat pattern in loop.
	end  loop;
	 clk  <= '1'  ;
	wait for 50 ns ;
-- dumped values till 1 us
	wait;
 End Process;


-- "Constant Pattern"
-- Start Time = 100 ns, End Time = 1 us, Period = 0 ns
  Process
	Begin
	 reset  <= '1'  ;
	wait for 100 ns ;
	 reset  <= '0'  ;
	wait for 900 ns ;
-- dumped values till 1 us
	wait;
 End Process;


-- "Clock Pattern" : dutyCycle = 50
-- Start Time = 0 ns, End Time = 1 us, Period = 10 ns
  Process
	Begin
	 switch  <= '0'  ;
	wait for 5 ns ;
-- 5 ns, single loop till start period.
	for Z in 1 to 99
	loop
	    switch  <= '1'  ;
	   wait for 5 ns ;
	    switch  <= '0'  ;
	   wait for 5 ns ;
-- 995 ns, repeat pattern in loop.
	end  loop;
	 switch  <= '1'  ;
	wait for 5 ns ;
-- dumped values till 1 us
	wait;
 End Process;
END;
