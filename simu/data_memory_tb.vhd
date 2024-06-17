LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY DataMemory_tb IS
END DataMemory_tb;

ARCHITECTURE bench OF DataMemory_tb IS
    SIGNAL CLK : STD_LOGIC := '0';
    SIGNAL Reset : STD_LOGIC := '0';
    SIGNAL DataIn : STD_LOGIC_VECTOR(31 DOWNTO 0) := (OTHERS => '0');
    SIGNAL DataOut : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL Addr : STD_LOGIC_VECTOR(5 DOWNTO 0) := (OTHERS => '0');
    SIGNAL WrEn : STD_LOGIC := '0';
    CONSTANT CLK_period : TIME := 10 ns;
BEGIN
    uut : ENTITY work.DataMemory
        PORT MAP(
            CLK => CLK,
            Reset => Reset,
            DataIn => DataIn,
            DataOut => DataOut,
            Addr => Addr,
            WrEn => WrEn
        );

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
        WAIT FOR 25 ns;
        Reset <= '0';

        Addr <= "000101";
        DataIn <= x"12345678";
        WrEn <= '1';
        WAIT FOR CLK_period * 2;

        Addr <= "000001";
        DataIn <= x"12341678";
        WAIT FOR CLK_period * 2;

        WrEn <= '0';

        Addr <= "000101";
        WAIT FOR CLK_period * 2;

        Addr <= "000001";
        WAIT FOR CLK_period * 2;

        ASSERT DataOut = x"12345678"
        REPORT "Test failed: DataOut does not match expected x'12345678'"
            SEVERITY error;

        REPORT "Test completed successfully";
        ASSERT false REPORT "End of simulation" SEVERITY failure;
        WAIT;
    END PROCESS;

END bench;