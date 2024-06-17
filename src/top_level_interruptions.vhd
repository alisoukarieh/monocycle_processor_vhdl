LIBRARY ieee;
USE IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY top_level_interruptions IS
    PORT (
        Clk, Reset, Pol, IRQ0, IRQ1 : IN STD_LOGIC;
        Segout : OUT STD_LOGIC_VECTOR(0 TO 27)
    );
END top_level_interruptions;

ARCHITECTURE struct OF top_level_interruptions IS
    SIGNAL afficheur_s : STD_LOGIC_VECTOR(15 DOWNTO 0);
BEGIN
    dcd_7seg_1 : ENTITY work.SEVEN_SEG
        PORT MAP(
            Data => afficheur_s(15 DOWNTO 12),
            Pol => pol,
            Segout => Segout(21 TO 27)
        );

    dcd_7seg_2 : ENTITY work.SEVEN_SEG
        PORT MAP(
            Data => afficheur_s(11 DOWNTO 8),
            Pol => pol,
            Segout => Segout(14 TO 20) -- 14 to 20
        );

    dcd_7seg_3 : ENTITY work.SEVEN_SEG
        PORT MAP(
            Data => afficheur_s(7 DOWNTO 4),
            Pol => pol,
            Segout => Segout(7 TO 13)
        );

    dcd_7seg_4 : ENTITY work.SEVEN_SEG
        PORT MAP(
            Data => afficheur_s(3 DOWNTO 0),
            Pol => pol,
            Segout => Segout(0 TO 6)
        );

    cpu : ENTITY work.CPUInterruption
        PORT MAP(
            Clk => Clk,
            Reset => Reset,
            IRQ0 => NOT IRQ0,
            IRQ1 => NOT IRQ1,
            Afficheur(15 DOWNTO 0) => afficheur_s,
            Afficheur(31 DOWNTO 16) => OPEN
        );
END struct;