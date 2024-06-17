LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY Register32_tb IS
END Register32_tb;

ARCHITECTURE bench OF Register32_tb IS
    SIGNAL CLK : STD_LOGIC := '0';
    SIGNAL RST : STD_LOGIC := '0';
    SIGNAL WE : STD_LOGIC := '0';
    SIGNAL DATAIN : STD_LOGIC_VECTOR(31 DOWNTO 0) := (OTHERS => '0');
    SIGNAL DATAOUT : STD_LOGIC_VECTOR(31 DOWNTO 0);
    CONSTANT clk_period : TIME := 10 ns;
BEGIN
    uut : ENTITY work.RegisterPSR
        PORT MAP(
            CLK => CLK,
            RST => RST,
            WE => WE,
            DATAIN => DATAIN,
            DATAOUT => DATAOUT
        );

    clk_process : PROCESS
    BEGIN
        CLK <= '0';
        WAIT FOR clk_period/2;
        CLK <= '1';
        WAIT FOR clk_period/2;
    END PROCESS;

    sim_proc : PROCESS
    BEGIN
        RST <= '1';
        WAIT FOR 20 ns;
        RST <= '0';
        WAIT FOR 10 ns;

        DATAIN <= "11110000111100001111000011110000";
        WE <= '1';
        WAIT FOR 20 ns;

        WE <= '0';
        DATAIN <= "00001111000011110000111100001111";
        WAIT FOR 20 ns;

        WE <= '1';
        WAIT FOR 20 ns;

        ASSERT false REPORT "End of simulation" SEVERITY failure;
    END PROCESS;
END bench;