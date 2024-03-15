LIBRARY ieee ;
USE ieee.std_logic_1164.all ;

ENTITY testproject IS
PORT(SW : IN STD_LOGIC_vector (9 downto 0) ;
LEDR : OUT STD_LOGIC_vector (9 downto 0));
END testproject ;




ARCHITECTURE LogicFunction OF testproject IS

component testproject1 pORT(SW : IN STD_LOGIC_vector (9 downto 0);
		LEDR: OUT STD_LOGIC_vector (9 downto 0));
END testporject1; 


BEGIN
LEDR(0) <= (SW(0) AND NOT SW(1)) OR (NOT SW(0) AND SW(1)) ;

port map 

END LogicFunction ;
