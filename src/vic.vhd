LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY VIC IS
    PORT (
        CLK : IN STD_LOGIC;
        RESET : IN STD_LOGIC;
        IRQ_SERV : IN STD_LOGIC;
        IRQ0 : IN STD_LOGIC;
        IRQ1 : IN STD_LOGIC;
        IRQ : OUT STD_LOGIC;
        VICPC : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
    );
END VIC;

ARCHITECTURE Behavioral OF VIC IS
    SIGNAL IRQ0_prev : STD_LOGIC := '0';
    SIGNAL IRQ1_prev : STD_LOGIC := '0';
    SIGNAL IRQ0_memo : STD_LOGIC := '0';
    SIGNAL IRQ1_memo : STD_LOGIC := '0';
BEGIN
    Interrupt_Detection : PROCESS (CLK)
    BEGIN
        IF rising_edge(CLK) THEN
            IF RESET = '1' THEN
                IRQ0_prev <= '0';
                IRQ1_prev <= '0';
                IRQ0_memo <= '0';
                IRQ1_memo <= '0';
            ELSE
                IRQ0_prev <= IRQ0;
                IRQ1_prev <= IRQ1;

                IF IRQ0 = '1' AND IRQ0_prev = '0' THEN
                    IRQ0_memo <= '1';
                ELSIF IRQ_SERV = '1' THEN
                    IRQ0_memo <= '0';
                END IF;

                IF IRQ1 = '1' AND IRQ1_prev = '0' THEN
                    IRQ1_memo <= '1';
                ELSIF IRQ_SERV = '1' THEN
                    IRQ1_memo <= '0';
                END IF;
            END IF;
        END IF;
    END PROCESS Interrupt_Detection;

    Output_Logic : PROCESS (IRQ0_memo, IRQ1_memo)
    BEGIN
        IRQ <= IRQ0_memo OR IRQ1_memo;
        IF IRQ0_memo = '1' THEN
            VICPC <= x"00000009";
        ELSIF IRQ1_memo = '1' THEN
            VICPC <= x"00000015";
        ELSE
            VICPC <= (OTHERS => '0');
        END IF;
    END PROCESS Output_Logic;

END Behavioral;