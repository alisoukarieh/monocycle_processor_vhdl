LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY Multiplexer IS
    GENERIC (
        N : INTEGER := 32
    );
    PORT (
        A, B : IN STD_LOGIC_VECTOR(N - 1 DOWNTO 0);
        COM : IN STD_LOGIC;
        S : OUT STD_LOGIC_VECTOR(N - 1 DOWNTO 0)
    );
END ENTITY Multiplexer;

ARCHITECTURE Behavioral OF Multiplexer IS
BEGIN
    PROCESS (A, B, COM)
    BEGIN
        IF COM = '0' THEN
            S <= A;
        ELSE
            S <= B;
        END IF;
    END PROCESS;
END ARCHITECTURE Behavioral;