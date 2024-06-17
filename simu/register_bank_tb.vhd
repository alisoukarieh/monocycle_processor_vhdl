LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY RegisterBank_tb IS
END RegisterBank_tb;

ARCHITECTURE bench OF RegisterBank_tb IS
   SIGNAL CLK : STD_LOGIC := '0';
   SIGNAL Reset : STD_LOGIC := '0';
   SIGNAL W : STD_LOGIC_VECTOR(31 DOWNTO 0) := (OTHERS => '0');
   SIGNAL RA : STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');
   SIGNAL RB : STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');
   SIGNAL RW : STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');
   SIGNAL WE : STD_LOGIC := '0';
   SIGNAL A : STD_LOGIC_VECTOR(31 DOWNTO 0);
   SIGNAL B : STD_LOGIC_VECTOR(31 DOWNTO 0);
   CONSTANT CLK_period : TIME := 10 ns;
BEGIN
   uut : ENTITY work.RegisterBank PORT MAP (
      CLK => CLK,
      Reset => Reset,
      W => W,
      RA => RA,
      RB => RB,
      RW => RW,
      WE => WE,
      A => A,
      B => B
      );
   -- Clock process definitions
   CLK_process : PROCESS
   BEGIN
      CLK <= '0';
      WAIT FOR CLK_period/2;
      CLK <= '1';
      WAIT FOR CLK_period/2;
   END PROCESS;
   PROCESS
   BEGIN
      Reset <= '1';
      WAIT FOR 20 ns;
      Reset <= '0';
      WAIT FOR 10 ns;

      -- Writing to register 3
      W <= X"ABCD1234";
      RW <= "0011";
      WE <= '1';
      WAIT FOR CLK_period;

      WE <= '0';
      WAIT FOR CLK_period;

      -- Reading from register 3
      RA <= "0011";
      WAIT FOR 5 ns;

      -- Check output on port A
      ASSERT A = X"ABCD1234"
      REPORT "Mismatch in register output at Register 3" SEVERITY error;

      -- Writing to register 5
      W <= X"DEADBEEF";
      RW <= "0101";
      WE <= '1';
      WAIT FOR CLK_period;

      WE <= '0';
      WAIT FOR CLK_period;

      -- Reading from register 5
      RB <= "0101";
      WAIT FOR 5 ns;

      -- Check output on port B
      ASSERT B = X"DEADBEEF"
      REPORT "Mismatch in register output at Register 5" SEVERITY error;

      ASSERT false REPORT "End of simulation" SEVERITY failure;
   END PROCESS;

END bench;