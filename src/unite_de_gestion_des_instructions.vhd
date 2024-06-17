LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY UniteGestionInstructions IS
    PORT (
        clk : IN STD_LOGIC;
        reset : IN STD_LOGIC;
        nPcSel : IN STD_LOGIC;
        offset : IN STD_LOGIC_VECTOR(23 DOWNTO 0);
        instruction : OUT STD_LOGIC_VECTOR(31 DOWNTO 0));
END UniteGestionInstructions;

ARCHITECTURE Behavioral OF UniteGestionInstructions IS
    SIGNAL PC : STD_LOGIC_VECTOR(31 DOWNTO 0) := (OTHERS => '0');
    SIGNAL extendedOffset : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL instructionMemoryOutput : STD_LOGIC_VECTOR(31 DOWNTO 0);
BEGIN
    IM : ENTITY work.instruction_memory
        PORT MAP(
            PC => PC,
            Instruction => instructionMemoryOutput
        );

    instruction <= instructionMemoryOutput;

    extendedOffset(31 DOWNTO 24) <= (OTHERS => offset(23));
    extendedOffset(23 DOWNTO 0) <= offset;

    PROCESS (clk, reset)
    BEGIN
        IF reset = '1' THEN
            PC <= (OTHERS => '0');
        ELSIF rising_edge(clk) THEN
            IF nPcSel = '0' THEN
                PC <= PC + 1;
            ELSE
                PC <= PC + 1 + extendedOffset;
            END IF;
        END IF;
    END PROCESS;

END Behavioral;