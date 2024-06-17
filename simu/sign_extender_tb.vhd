LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY SignExtender_TB IS
END ENTITY SignExtender_TB;

ARCHITECTURE bench OF SignExtender_TB IS
    CONSTANT N : INTEGER := 8;
    SIGNAL E : STD_LOGIC_VECTOR(N - 1 DOWNTO 0);
    SIGNAL S : STD_LOGIC_VECTOR(31 DOWNTO 0);
BEGIN

    extender : ENTITY work.SignExtender
        GENERIC MAP(
            N => N
        )
        PORT MAP(
            E => E,
            S => S
        );

    PROCESS
    BEGIN
        -- Positive number
        E <= "01101011";
        WAIT FOR 10 ns;

        -- Negative number
        E <= "11110010";
        WAIT FOR 10 ns;

        --  Zero
        E <= "00000000";
        WAIT FOR 10 ns;

        -- Maximum positive number
        E <= "01111111";
        WAIT FOR 10 ns;

        -- Minimum negative number
        E <= "10000000";
        WAIT FOR 10 ns;
        WAIT;
    END PROCESS;
END ARCHITECTURE bench;