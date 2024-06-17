LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY UAL_32bit_TB IS
END UAL_32bit_TB;

ARCHITECTURE bench OF UAL_32bit_TB IS
    SIGNAL A : STD_LOGIC_VECTOR(31 DOWNTO 0) := (OTHERS => '0');
    SIGNAL B : STD_LOGIC_VECTOR(31 DOWNTO 0) := (OTHERS => '0');
    SIGNAL OP : STD_LOGIC_VECTOR(2 DOWNTO 0) := (OTHERS => '0');
    SIGNAL S : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL N : STD_LOGIC;
    SIGNAL Z : STD_LOGIC;
    SIGNAL C : STD_LOGIC;
    SIGNAL V : STD_LOGIC;

BEGIN
    alu : ENTITY work.UAL_32bits
        PORT MAP(
            OP => OP,
            A => A,
            B => B,
            S => S,
            N => N,
            Z => Z,
            C => C,
            V => V
        );

    PROCESS
    BEGIN
        -- Test case 1: ADD for Zero Flag
        A <= x"00000000"; -- 0
        B <= x"00000000"; -- 0
        OP <= "000"; -- ADD
        WAIT FOR 100 ns;
        ASSERT Z = '1' REPORT "Zero flag failed in ADD operation" SEVERITY error;

        -- Test case 2: SUB for Negative Flag
        A <= x"00000000"; -- 1
        B <= x"00000002"; -- 2
        OP <= "010"; -- SUB
        WAIT FOR 100 ns;
        ASSERT N = '1' REPORT "Negative flag failed in SUB operation" SEVERITY error;

        -- Test case 3: ADD for Carry Flag
        A <= x"FFFFFFFF"; -- Max positive
        B <= x"00000001"; -- 1
        OP <= "000"; -- ADD
        WAIT FOR 100 ns;
        ASSERT C = '1' REPORT "Carry flag failed in ADD operation" SEVERITY error;

        -- Test case 4: ADD for Overflow Flag
        A <= x"7FFFFFFF"; -- Max positive 32-bit integer
        B <= x"00000001"; -- Small positive
        OP <= "000"; -- ADD
        WAIT FOR 100 ns;
        ASSERT V = '1' REPORT "Overflow flag failed in ADD operation" SEVERITY error;
        WAIT;
    END PROCESS;
END bench;