LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY Multiplexer_TB IS
END ENTITY Multiplexer_TB;

ARCHITECTURE bench OF Multiplexer_TB IS
    CONSTANT N : INTEGER := 8;
    SIGNAL A, B : STD_LOGIC_VECTOR(N - 1 DOWNTO 0);
    SIGNAL COM : STD_LOGIC;
    SIGNAL S : STD_LOGIC_VECTOR(N - 1 DOWNTO 0);
BEGIN

    UUT : ENTITY work.Multiplexer
        GENERIC MAP(
            N => N
        )
        PORT MAP(
            A => A,
            B => B,
            COM => COM,
            S => S
        );

    PROCESS
    BEGIN
        A <= "10101010";
        B <= "11110000";
        COM <= '0';
        WAIT FOR 10 ns;

        A <= "10101010";
        B <= "11110000";
        COM <= '1';
        WAIT FOR 10 ns;
        WAIT;
    END PROCESS;
END ARCHITECTURE bench;