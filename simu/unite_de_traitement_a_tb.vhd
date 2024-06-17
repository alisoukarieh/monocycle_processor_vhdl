LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY UniteDeTraitement_a_tb IS
END UniteDeTraitement_a_tb;

ARCHITECTURE bench OF UniteDeTraitement_a_tb IS
    SIGNAL Clk, Reset, WE : STD_LOGIC := '0';
    SIGNAL OP : STD_LOGIC_VECTOR(2 DOWNTO 0);
    SIGNAL Rw, Ra, Rb : STD_LOGIC_VECTOR(3 DOWNTO 0);
BEGIN
    Clk <= NOT Clk AFTER 10 NS;
    udt : ENTITY work.UniteDeTraitement_a
        PORT MAP(
            Clk => Clk,
            Reset => Reset,
            WE => WE,
            OP => OP,
            Rw => Rw,
            Ra => Ra,
            Rb => Rb
        );
    PROCESS
    BEGIN
        Ra <= "0000";
        Rb <= "0000";
        Rw <= "0000";
        OP <= "000";
        WE <= '0';
        Reset <= '1';
        WAIT FOR 25 NS;
        Reset <= '0';

        -- R(1) = R(15)
        Rw <= "0001";
        Ra <= "1111";
        Rb <= "0000";
        OP <= "011";
        WE <= '1';
        WAIT FOR 20 NS;

        WE <= '0';
        Ra <= "0001";
        WAIT UNTIL rising_edge(Clk);

        -- R(1) = R(1) + R(15)
        Rw <= "0001";
        Ra <= "0001";
        Rb <= "1111";
        OP <= "000"; -- ADD operation
        WE <= '1';
        WAIT FOR 20 NS;

        WE <= '0';
        Ra <= "0001";
        WAIT UNTIL rising_edge(Clk);

        -- R(2) = R(1) + R(15)
        Rw <= "0010";
        Ra <= "0001";
        Rb <= "1111";
        OP <= "000"; -- ADD operation
        WE <= '1';
        WAIT FOR 20 NS;

        WE <= '0';
        Ra <= "0010";
        WAIT FOR 20 NS;

        -- R(3) = R(1) - R(15)
        Rw <= "0011";
        Ra <= "0001";
        Rb <= "1111";
        OP <= "010"; -- SUB operation
        WE <= '1';
        WAIT FOR 20 NS;

        WE <= '0';
        Ra <= "0011";
        WAIT FOR 20 NS;

        --  R(5) = R(7) - R(15)
        Rw <= "0101";
        Ra <= "0111";
        Rb <= "1111";
        OP <= "010"; -- SUB operation
        WE <= '1';
        WAIT FOR 20 NS;

        WE <= '0';
        Ra <= "0101";
        WAIT FOR 20 NS;

        ASSERT false REPORT "End of simulation" SEVERITY failure;
    END PROCESS;
END bench;