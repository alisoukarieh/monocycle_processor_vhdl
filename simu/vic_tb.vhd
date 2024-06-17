LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY VIC_tb IS
END VIC_tb;

ARCHITECTURE bench OF VIC_tb IS
    COMPONENT VIC
        PORT (
            CLK : IN STD_LOGIC;
            RESET : IN STD_LOGIC;
            IRQ_SERV : IN STD_LOGIC;
            IRQ0 : IN STD_LOGIC;
            IRQ1 : IN STD_LOGIC;
            IRQ : OUT STD_LOGIC;
            VICPC : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
        );
    END COMPONENT;
    SIGNAL CLK : STD_LOGIC := '0';
    SIGNAL RESET : STD_LOGIC := '1';
    SIGNAL IRQ_SERV : STD_LOGIC := '0';
    SIGNAL IRQ0 : STD_LOGIC := '0';
    SIGNAL IRQ1 : STD_LOGIC := '0';
    SIGNAL IRQ : STD_LOGIC;
    SIGNAL VICPC : STD_LOGIC_VECTOR(31 DOWNTO 0);
BEGIN
    uut : ENTITY work.VIC
        PORT MAP(
            CLK => CLK,
            RESET => RESET,
            IRQ_SERV => IRQ_SERV,
            IRQ0 => IRQ0,
            IRQ1 => IRQ1,
            IRQ => IRQ,
            VICPC => VICPC
        );

    clk_process : PROCESS
    BEGIN
        WHILE true LOOP
            CLK <= '0';
            WAIT FOR 10 ns;
            CLK <= '1';
            WAIT FOR 10 ns;
        END LOOP;
    END PROCESS;

    stim_proc : PROCESS
    BEGIN
        RESET <= '1';
        WAIT FOR 20 ns;
        RESET <= '0';

        WAIT FOR 20 ns;
        ASSERT VICPC = (31 DOWNTO 0 => '0') REPORT "VICPC should be 0 on reset" SEVERITY error;

        -- Test irq0
        IRQ0 <= '1';
        WAIT FOR 20 ns;
        IRQ0 <= '0';

        WAIT FOR 20 ns;
        ASSERT VICPC = x"00000009" REPORT "VICPC should be 0x00000009 for IRQ0" SEVERITY error;

        IRQ_SERV <= '1';
        WAIT FOR 20 ns;
        IRQ_SERV <= '0';

        -- Test irq1
        IRQ1 <= '1';
        WAIT FOR 20 ns;
        IRQ1 <= '0';

        WAIT FOR 20 ns;
        ASSERT VICPC = x"00000015" REPORT "VICPC should be 0x00000015 for IRQ1" SEVERITY error;

        IRQ_SERV <= '1';
        WAIT FOR 20 ns;
        IRQ_SERV <= '0';

        -- Test priority
        IRQ0 <= '1';
        IRQ1 <= '1';
        WAIT FOR 20 ns;
        IRQ0 <= '0';
        IRQ1 <= '0';

        WAIT FOR 20 ns;
        ASSERT VICPC = x"00000009" REPORT "VICPC should be 0x00000009 for IRQ0" SEVERITY error;

        IRQ_SERV <= '1';
        WAIT FOR 20 ns;
        IRQ_SERV <= '0';

        -- Wait and end simulation
        WAIT FOR 100 ns;
        REPORT "Simulation ended successfully" SEVERITY note;
        ASSERT false REPORT "End of simulation" SEVERITY failure;
        WAIT;
    END PROCESS;
END bench;