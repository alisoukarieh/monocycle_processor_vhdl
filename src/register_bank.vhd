LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY RegisterBank IS
    PORT (
        CLK, Reset, WE : IN STD_LOGIC;
        W : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        RA, RB, RW : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        A, B : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
    );
END RegisterBank;

ARCHITECTURE Behavioral OF RegisterBank IS
    TYPE table IS ARRAY(15 DOWNTO 0) OF STD_LOGIC_VECTOR(31 DOWNTO 0);

    FUNCTION init_banc RETURN table IS
        VARIABLE result : table;
    BEGIN
        FOR i IN 0 TO 14 LOOP
            result(i) := (OTHERS => '0');
        END LOOP;
        result(15) := X"00000030";
        RETURN result;
    END;

    SIGNAL Banc : table := init_banc;
BEGIN
    PROCESS (CLK, Reset)
    BEGIN
        IF Reset = '1' THEN
            Banc <= init_banc;
        ELSIF rising_edge(CLK) THEN
            IF WE = '1' THEN
                Banc(to_integer(unsigned(RW))) <= W;
            END IF;
        END IF;
    END PROCESS;

    A <= Banc(to_integer(unsigned(RA)));
    B <= Banc(to_integer(unsigned(RB)));

END Behavioral;