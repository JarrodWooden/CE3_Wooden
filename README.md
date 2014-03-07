CE3_Wooden
==========

*********

#Introduction

This lab was to demonstrate the difference between a Moore Machine and a Mealy Machine

For this example, I designed an elevator controler.

The elevator controller has four floors, and each floor will represent a state in the circuit.

If the `up_down` button is a '1' it will go up as long as stop is a '0'.

If both the `up_down` button and the `stop` are '0' then the elevator will go down states (floors).

Here is a picture of the state diagram:

![alt text](https://raw.github.com/JarrodWooden/CE3_Wooden/master/State_Diagram.PNG "Elevator State Diagram")

*********

#Moore Machine

Luckily, Captain Silva gave the class code to start with and we had to correct to make the code actually function

The VHDL file can be found above.

Before we move on to the steps I conducted to complete CE3, lets answer the questions posed in the lab.

Questions Answered:

    ```
    		--Question: is reset synchronous or asynchronous?
			--ANSWER: synchronus if reset is only checked on the rising edge edge the clock
			
    ```
    
    If the `stop` button is set to don't stop ('0'), it can move to whichever floor button `up_down` is set to
    
    ```
    	--Answer to What is the clock frequency? What value would we set to simulate a 50MHz clock?
     	--The frequency currently is 100MHz
    	--10 ns would make a frequency of 50MHz
  	```
  	
  	
For the Moore Machine I simply made the state memory remember the current state.

When the clk reached a rising edge the state memory process would run and would reset if reset was '1' 
or it would make the current `floor_state` equal the `next_floor_state` (which could be just the current floor
state again if `stop` = '1'

I changed in-efficient code in the Moore Machine where the state memory process was checking from the rising edge to:

      ```
      	--bad code need RISING_EDGE, because making the comparison before could delay the clock
	      if (rising_edge(clk)) then
      ```
      
I also broke up the code from one long code that could be prone to many mistakes to good zen code, broken up into
three processes that takes care of Input Logic (Next Floor Logic), State Memory, and Output Logic

I also added to the Enumeration portion of the code a `next_floor_state` that I mentioned above so that
when I broke the code up into three organized processes, I could keep track of the next state easier.

Where I added the `next_floor_state` is here:

      ```
      --need to add a next floor state variable as well that take on the types above
      signal next_floor_state, floor_state : floor_state_type;
      ```
      
The last thing to do is added Output Logic that is easier to be seen than explained:

      ```
      floor <= "0001" when (floor_state = floor1) else
		  	"0010" when (floor_state = floor2) else
			  "0011" when (floor_state = floor3) else
			  "0100" when (floor_state = floor4) else
			  "0001"; --need else because we don't want any chance of creating memory outside of "STATE MEMORY"
  	  ```
  	  
The Output Logic was simply setting the states to the correct ouput

***************

#Mealy Machine

***************

The only code changed for the Mealy Machine was the output logic. The reason being is that to create a Mealy
machine the ouput must be directly affected by an input.

In other words, one of the inputs goes directly to the output without first passing through the register.

To do this we created a controller that will also display the next floor for the passenger. The next floor 
will be dependent on the current floor and the direction the elevator is heading. (Either up or down)

The code added can be seen below:

    ```
    -----------------------------------------------------------
    --Code your Ouput Logic for your Mealy machine below
    --Remember, now you have 2 outputs (floor and nextfloor)
    -----------------------------------------------------------
    floor <= "0001" when (floor_state = floor1) else
			"0010" when (floor_state = floor2) else
			"0011" when (floor_state = floor3) else
			"0100" when (floor_state = floor4) else
			"0001"; --need else because we don't want any chance of creating memory outside of "STATE MEMORY"
			
    nextfloor <= 	"0010" when (floor_state = floor1 and up_down = '1') else
			"0011" when (floor_state = floor2 and up_down = '1') else
			"0100" when (floor_state = floor3 and up_down = '1') else
			"0011" when (floor_state = floor4 and up_down = '0') else
			"0010" when (floor_state = floor3 and up_down = '0') else
			"0001" when (floor_state = floor2 and up_down = '0') else
			"0001";
		```

So if the elevator was heading up the next floor will be set to the one above it until it reaches the top and
if the elevator was heading down it will set the next floor to the floor below the current floor etc.


***************

#Testbenches


**************

All I did for the testbench was go up each floor by setting `stop` to '0', then waiting one clock cycle, then
setting it back to '1' for two clock cycles to see the output on that floor.

An example of the code on one of the floors can be seen below:

      ```
      up_down <= '1';
		  stop <= '0';
		
		  wait for 10 ns;
		  stop<= '1';
		
	  	wait for 20 ns;
  	  ```
  	  
The code will go up one floor and then wait on that floor for 2 clock cylcles.

The reason why I know that this was right was because once I simulated the testbench I knew that the Moore controller 
functioned correctly was because from the simulation results (that can be seen below) I can see that when the rising
edge of the clock hits, and the stop button is inactive, the elevator can move up or down on that pulse, which the
simulation demonstrates correctly.

Moore Simulation Below:

![alt text](https://raw.github.com/JarrodWooden/CE3_Wooden/master/Moore_SimSnap.PNG "Moore Simulation Picture")

I used the same concept for the Mealy Machine as well.

The Mealy Machine Simulation is Below:

![alt text](https://raw.github.com/JarrodWooden/CE3_Wooden/master/Mealy_Snap.PNG "Mealy Simulation Picture")


The same reasoning for checking functionality for the Moore Machine was used to check the Mealy Machine, the
only difference was that I also checked to make sure that the `nextstate` output was also correct when the rising
edge of the clock hit.

  	
  	
Thank you for reading my README and have a Great Air Force Day

  	
  	
