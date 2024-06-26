LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY RegisterPSR IS
    PORT (
        CLK : IN STD_LOGIC;
        RST : IN STD_LOGIC;
        WE : IN STD_LOGIC;
        DATAIN : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        DATAOUT : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
    );
END RegisterPSR;

ARCHITECTURE Behavioral OF RegisterPSR IS
    SIGNAL REG : STD_LOGIC_VECTOR(31 DOWNTO 0);
BEGIN
    PROCESS (CLK, RST)
    BEGIN
        IF RST = '1' THEN
            REG <= (OTHERS => '0');
        ELSIF rising_edge(CLK) THEN
            IF WE = '1' THEN
                REG <= DATAIN;
            END IF;
        END IF;
    END PROCESS;

    DATAOUT <= REG;
END Behavioral;