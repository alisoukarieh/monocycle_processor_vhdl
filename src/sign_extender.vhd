LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY SignExtender IS
    GENERIC (
        N : INTEGER := 8
    );
    PORT (
        E : IN STD_LOGIC_VECTOR(N - 1 DOWNTO 0);
        S : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
    );
END ENTITY SignExtender;

ARCHITECTURE Behavioral OF SignExtender IS
BEGIN
    PROCESS (E)
    BEGIN
        IF E(N - 1) = '0' THEN
            S <= (31 DOWNTO N => '0') & E;
        ELSE
            S <= (31 DOWNTO N => '1') & E(N - 1 DOWNTO 0);
        END IF;
    END PROCESS;
END ARCHITECTURE Behavioral;