LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY UniteDeTraitement_b_tb IS
END UniteDeTraitement_b_tb;

ARCHITECTURE bench OF UniteDeTraitement_b_tb IS
    SIGNAL Reset, RegWr, WrEn, Com1, Com2 : STD_LOGIC;
    SIGNAL Rw, Ra, Rb : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL Imm : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL OP : STD_LOGIC_VECTOR(2 DOWNTO 0);
    CONSTANT CLOCK_PERIOD : TIME := 10 Ns;
    SIGNAL Done : BOOLEAN := false;
    SIGNAL CLK : STD_LOGIC := '0';
BEGIN
    clk <= '0' WHEN Done ELSE
        NOT clk AFTER CLOCK_PERIOD / 2;
    Reset <= '1', '0' AFTER CLOCK_PERIOD;

    UDT : ENTITY work.UniteDeTraitement_b
        PORT MAP(
            Clk => Clk,
            Reset => Reset,
            RegWr => RegWr,
            WrEn => WrEn,
            Com1 => Com1,
            Com2 => Com2,
            Rw => Rw,
            Ra => Ra,
            Rb => Rb,
            Imm => Imm,
            OP => OP
        );

    PROCESS
    BEGIN
        RegWr <= '0';
        WrEn <= '0';
        Com1 <= '0';
        Com2 <= '0';
        Rw <= "0000";
        Ra <= "0000";
        Rb <= "0000";
        Imm <= "00000000";
        OP <= "000";

        WAIT FOR CLOCK_PERIOD;

        -- Addition of 2 registers
        Ra <= "0001";
        Rb <= "1111";
        Rw <= "0001";
        RegWr <= '1';
        OP <= "000";
        Com1 <= '0';
        WAIT UNTIL rising_edge(clk);

        -- Addition of a register and an immediate value 
        Imm <= "00000001";
        Com1 <= '1';
        WAIT UNTIL rising_edge(clk);

        -- Substraction of 2 registers
        Com1 <= '0';
        OP <= "010";
        WAIT UNTIL rising_edge(clk);

        -- Substraction of a register and an immediate value
        Com1 <= '1';
        Imm <= "00000010";
        WAIT UNTIL rising_edge(clk);

        -- Copy of a register: B into A 
        Com1 <= '0';
        OP <= "001";
        WAIT UNTIL rising_edge(clk);

        -- Memory write 
        WrEn <= '1';
        WAIT UNTIL rising_edge(clk);

        -- Memory read
        WrEn <= '0';
        Com2 <= '1';
        WAIT UNTIL rising_edge(clk);
        WAIT FOR CLOCK_PERIOD;
        Done <= true;
        WAIT;
    END PROCESS;
END bench;