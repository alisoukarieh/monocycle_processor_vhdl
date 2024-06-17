LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY UniteGestionInstruction_tb IS
END UniteGestionInstruction_tb;

ARCHITECTURE bench OF UniteGestionInstruction_tb IS
    SIGNAL clk : STD_LOGIC := '0';
    SIGNAL reset : STD_LOGIC := '1';
    SIGNAL nPcSel : STD_LOGIC := '0';
    SIGNAL offset : STD_LOGIC_VECTOR(23 DOWNTO 0) := (OTHERS => '0');
    SIGNAL instruction : STD_LOGIC_VECTOR(31 DOWNTO 0);
BEGIN
    uut : ENTITY work.UniteGestionInstructions
        PORT MAP(
            clk => clk,
            reset => reset,
            nPcSel => nPcSel,
            offset => offset,
            instruction => instruction
        );

    clock_process : PROCESS
    BEGIN
        WHILE true LOOP
            clk <= '0';
            WAIT FOR 10 ns;
            clk <= '1';
            WAIT FOR 10 ns;
        END LOOP;
    END PROCESS;

    sim : PROCESS
    BEGIN
        reset <= '1';
        WAIT FOR 40 ns;
        reset <= '0';
        WAIT FOR 20 ns;

        -- Test Case 1: Increment PC normally
        nPcSel <= '0';
        offset <= (OTHERS => '0');
        WAIT FOR 50 ns;

        -- Test Case 2: Increment PC with offset
        nPcSel <= '1';
        offset <= "000000000000000000000010"; -- Increment by 2
        WAIT FOR 100 ns;

        ASSERT false REPORT "End of simulation" SEVERITY failure;
    END PROCESS;
END bench;