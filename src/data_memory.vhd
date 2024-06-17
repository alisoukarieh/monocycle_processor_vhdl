LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY DataMemory IS
    PORT (
        CLK : IN STD_LOGIC;
        Reset : IN STD_LOGIC;
        DataIn : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        DataOut : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        Addr : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
        WrEn : IN STD_LOGIC
    );
END DataMemory;

ARCHITECTURE Behavioral OF DataMemory IS
    TYPE memory_array IS ARRAY (0 TO 63) OF STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL memory : memory_array;
BEGIN

    PROCESS (CLK)
    BEGIN
        IF Reset = '1' THEN
            FOR i IN 0 TO 63 LOOP
                memory(i) <= STD_LOGIC_VECTOR(to_Unsigned(i, 32));
            END LOOP;
        ELSIF rising_edge(CLK) THEN
            IF WrEn = '1' THEN
                memory(to_integer(unsigned(Addr))) <= DataIn;
            END IF;
        END IF;
    END PROCESS;
    DataOut <= memory(to_integer(unsigned(Addr)));
END Behavioral;