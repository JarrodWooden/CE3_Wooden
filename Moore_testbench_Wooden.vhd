--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:56:20 03/06/2014
-- Design Name:   
-- Module Name:   C:/Users/C16Jarrod.Wooden/Documents/ECE281/CE3_Wooden/Moore_testbench_Wooden.vhd
-- Project Name:  CE3_Wooden
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: MooreElevatorController_Shell
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY Moore_testbench_Wooden IS
END Moore_testbench_Wooden;
 
ARCHITECTURE behavior OF Moore_testbench_Wooden IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT MooreElevatorController_Shell
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         stop : IN  std_logic;
         up_down : IN  std_logic;
         floor : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
   signal stop : std_logic := '0';
   signal up_down : std_logic := '0';

 	--Outputs
   signal floor : std_logic_vector(3 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
	
	--Answer to What is the clock frequency? What value would we set to simulate a 50MHz clock?
	--The frequency currently is 100MHz
	--10 ns would make a frequency of 50MHz
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: MooreElevatorController_Shell PORT MAP (
          clk => clk,
          reset => reset,
          stop => stop,
          up_down => up_down,
          floor => floor
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 20 ns;	

      -- insert stimulus here 
		
		reset <= '1';
		
		
		--floor 1
		
		wait for 20 ns;
		
		reset <= '0';
		
		up_down <= '0';
		stop <= '0';
		
		wait for 20 ns;
		
		up_down <= '1';
		stop <= '1';
		
		wait for 20 ns;
		
		up_down <= '1';
		stop <= '0';
		
		wait for 10 ns;
		stop<= '1';
		
		wait for 20 ns;
		--floor 2
		
		
		up_down <= '1';
		stop <= '0';
		
		wait for 10 ns;
		stop <= '1';
		
		wait for 20 ns;
		
		
		--floor 3
		
		up_down <= '1';
		stop <= '0';
		
		wait for 10 ns;
		stop <= '1';
		
		wait for 20 ns;
		
		--floor four
		
		up_down <= '1';
		stop <= '0';
		
		wait for 20 ns;
		
		up_down <= '0';
		stop <= '1';
		
		wait for 20 ns;
		
		--end of fourth floor
		
		--go back down to first floor
		
		
		up_down <= '0';
		stop <= '0';
		
		wait for 10 ns;
		stop <= '1';
		
		wait for 20 ns;
		
		up_down <= '0';
		stop <= '0';
		
		wait for 10 ns;
		stop <= '1';
		
		wait for 20 ns;
		
		up_down <= '0';
		stop <= '0';
		
		wait for 20 ns;

      wait;
   end process;

END;
