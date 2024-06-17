LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY CPU_INTERRUPTIONS_TB IS
END ENTITY CPU_INTERRUPTIONS_TB;

ARCHITECTURE bench OF CPU_INTERRUPTIONS_TB IS
    SIGNAL clk, IRQ0, IRQ1 : STD_LOGIC := '0';
    SIGNAL reset : STD_LOGIC := '1';
    SIGNAL Afficheur_signal : STD_LOGIC_VECTOR(31 DOWNTO 0) := (OTHERS => '0');
    CONSTANT CLOCK_PERIOD : TIME := 20 ms;
    SIGNAL Done : BOOLEAN := False;
BEGIN
    clk <= '0' WHEN Done ELSE
        NOT clk AFTER 10 ns;
    reset <= '1', '0' AFTER 1 ns;
    cpu : ENTITY work.CPUInterruption
        PORT MAP(
            Clk => clk,
            IRQ0 => IRQ0,
            IRQ1 => IRQ1,
            Reset => reset,
            Afficheur => Afficheur_signal
        );

    PROCESS
    BEGIN
        WAIT FOR 4000 ns;
        IRQ0 <= '1';
        WAIT FOR 10 ns;
        IRQ0 <= '0';
        WAIT FOR 5000 ns;
        ASSERT false REPORT "End of simulation" SEVERITY failure;
        done <= true;
        WAIT;
    END PROCESS;

END ARCHITECTURE bench;