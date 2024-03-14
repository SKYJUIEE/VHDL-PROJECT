----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:52:41 11/20/2023 
-- Design Name: 
-- Module Name:    Seq_gen - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_arith.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Seq_gen is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           Q : out  STD_LOGIC);
end Seq_gen;

architecture Behavioral of Seq_gen is
signal Shift_register : std_logic_vector(0 to 19);
signal Din : std_logic;
begin
	
	process(clk, rst)
	begin
		Din <= Shift_register(19) xor Shift_register(16);
		if (Shift_register = "00000000000000000000") then
			Din <= '1';
		end if;
		
		
		
		
		if rst = '1' then
			Shift_register <= "00000000000000000000";
			
		elsif (clk'event and clk = '1') then
			
		Shift_register <= Din & Shift_register(0 to 18);
		
		
		
		end if;
	end process;
	Q <= Shift_register(0);


end Behavioral;



----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:09:24 11/20/2023 
-- Design Name: 
-- Module Name:    Dff - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Dff is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           D : in  STD_LOGIC;
           Q : out  STD_LOGIC);
end Dff;

architecture Behavioral of Dff is
signal temp : std_logic;
begin
		process(clk, rst, D)
		begin
		if (rst = '1') then
			temp <= '0';
		elsif rising_edge(clk) then
			temp <= D;
		end if;
		end process;
	Q <= temp;
		

end Behavioral;
----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:18:08 11/20/2023 
-- Design Name: 
-- Module Name:    Seq_detector - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Seq_detector is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           Random_seq : out  STD_LOGIC;
           Q : out  STD_LOGIC);
end Seq_detector;

architecture Behavioral of Seq_detector is

component Dff is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           D : in  STD_LOGIC;
           Q : out  STD_LOGIC);
end component;

component Seq_gen is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           Q : out  STD_LOGIC);
end component;

signal Seq : std_logic;
signal temp, Y,X,Q1,Q0,D1,D0 : std_logic;


begin

Random_sequence : Seq_gen port map (clk, rst, Seq);

D1 <= (X and Q1) or ( X and Q0);
D0 <= (not X and Q1) or (X and (not Q1) and (not Q0));
Y <= Q1 or (X and Q0);

X <= Seq;
Dff1 : Dff port map (clk, rst, D1, Q1);
Dff0 : Dff port map (clk, rst, D0, Q0);

Q <= Y;
Random_seq <= Seq;
end Behavioral;
--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   09:33:16 11/21/2023
-- Design Name:   
-- Module Name:   /home/ise/mini_project/seq_det1/testdect.vhd
-- Project Name:  seq_det1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Seq_detector
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
 
ENTITY testdect IS
END testdect;
 
ARCHITECTURE behavior OF testdect IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Seq_detector
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         Random_seq : OUT  std_logic;
         Q : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';

 	--Outputs
   signal Random_seq : std_logic;
   signal Q : std_logic;

   -- Clock period definitions
   constant clk_period : time := 100 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Seq_detector PORT MAP (
          clk => clk,
          rst => rst,
          Random_seq => Random_seq,
          Q => Q
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
		rst <= '1';
      wait for 100 ns;	
		rst <= '0';
		wait for 60000 ns;
		
      --wait for 100 ns;	

     
   end process;

END;
