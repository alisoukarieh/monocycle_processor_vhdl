LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY UniteGestionInstructionsInterruptions IS
  PORT (
    clk : IN STD_LOGIC;
    reset : IN STD_LOGIC;
    nPcSel : IN STD_LOGIC;
    offset : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    IRQ : IN STD_LOGIC;
    VICPC : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    IRQ_END : IN STD_LOGIC;
    instruction : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    IRQ_SERV : OUT STD_LOGIC
  );
END UniteGestionInstructionsInterruptions;

ARCHITECTURE Behavioral OF UniteGestionInstructionsInterruptions IS
  SIGNAL PC, LR : unsigned(31 DOWNTO 0) := (OTHERS => '0');
  SIGNAL instructionMemoryOutput : STD_LOGIC_VECTOR(31 DOWNTO 0);
BEGIN
  IM : ENTITY work.instruction_memory_IRQ
    PORT MAP(
      PC => STD_LOGIC_VECTOR(PC),
      Instruction => instruction
    );
  PROCESS (clk, reset)
  BEGIN
    IF reset = '1' THEN
      PC <= (OTHERS => '0');
      IRQ_SERV <= '0';
    ELSIF rising_edge(clk) THEN
      IF IRQ = '1' AND (PC < x"00000009") THEN
        IF npcsel = '0' THEN
          LR <= PC + 1;
        ELSE
          LR <= PC + 1 + unsigned(offset);
        END IF;
        PC <= unsigned(VICPC);
        IRQ_SERV <= '1';
      ELSIF IRQ_END = '1' THEN
        PC <= LR;
        IRQ_SERV <= '0';
      ELSIF npcsel = '0' THEN
        PC <= PC + 1;
      ELSE
        PC <= PC + 1 + unsigned(offset);
      END IF;
    END IF;
  END PROCESS;

END Behavioral;