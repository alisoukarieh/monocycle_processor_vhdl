LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY CPU_TB IS
END ENTITY CPU_TB;

ARCHITECTURE bench OF CPU_TB IS
    SIGNAL clk : STD_LOGIC := '0';
    SIGNAL reset : STD_LOGIC := '1';
    SIGNAL Afficheur_signal : STD_LOGIC_VECTOR(31 DOWNTO 0) := (OTHERS => '0');
    CONSTANT CLOCK_PERIOD : TIME := 20 ms;
    SIGNAL Done : BOOLEAN := False;
BEGIN
    clk <= '0' WHEN Done ELSE
        NOT clk AFTER 10 ns;
    reset <= '1', '0' AFTER 1 ns;
    cpu : ENTITY work.CPU
        PORT MAP(
            Clk => clk,
            Reset => reset,
            Afficheur => Afficheur_signal
        );
    PROCESS
    BEGIN
        WAIT FOR 2000 ns;
        ASSERT false REPORT "End of simulation" SEVERITY failure;
        done <= true;
        WAIT;
    END PROCESS;
END ARCHITECTURE bench;