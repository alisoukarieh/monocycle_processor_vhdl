LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY Decoder IS
    PORT (
        instruction : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        psr : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        nPC_SEL : OUT STD_LOGIC;
        PSREn : OUT STD_LOGIC;
        RegWr : OUT STD_LOGIC;
        RegSel : OUT STD_LOGIC;
        ALUCtrl : OUT STD_LOGIC_VECTOR (2 DOWNTO 0);
        ALUSrc : OUT STD_LOGIC;
        WrSrc : OUT STD_LOGIC;
        MemWr : OUT STD_LOGIC;
        RegAff : OUT STD_LOGIC
    );
END Decoder;

ARCHITECTURE Behavioral OF Decoder IS
    TYPE enum_instruction IS (MOV, ADDi, ADDR, CMP, LDR, STR, BAL, BLT, NO_OP);
    SIGNAL instr_courante : enum_instruction;

    FUNCTION Decode_Instruction_Vector_to_Enum(inst_vector : STD_LOGIC_VECTOR(31 DOWNTO 0)) RETURN enum_instruction IS
    BEGIN
        IF inst_vector(31 DOWNTO 20) = "111000101000" THEN
            RETURN ADDI;
        ELSIF inst_vector(31 DOWNTO 20) = "111000001000" THEN
            RETURN ADDr;
        ELSIF inst_vector(31 DOWNTO 24) = "11101010" THEN
            RETURN BAL;
        ELSIF inst_vector(31 DOWNTO 24) = "10111010" THEN
            RETURN BLT;
        ELSIF inst_vector(24 DOWNTO 21) = "1010" THEN
            RETURN CMP;
        ELSIF inst_vector(31 DOWNTO 20) = "111001100001" THEN
            RETURN LDR;
        ELSIF inst_vector(31 DOWNTO 20) = "111000111010" THEN
            RETURN MOV;
        ELSIF inst_vector(31 DOWNTO 20) = "111001100000" THEN
            RETURN STR;
        ELSE
            RETURN NO_OP;
        END IF;
    END FUNCTION;
BEGIN
    instr_courante <= Decode_Instruction_Vector_to_Enum(instruction);

    PROCESS (instr_courante)
    BEGIN
        nPC_SEL <= '0';
        PSREn <= '0';
        RegWr <= '0';
        RegSel <= '0';
        ALUCtrl <= (OTHERS => '0');
        ALUSrc <= '0';
        WrSrc <= '0';
        MemWr <= '0';
        RegAff <= '0';

        CASE instr_courante IS
            WHEN ADDi =>
                nPC_SEL <= '0';
                RegWr <= '1';
                ALUSrc <= '1';
                ALUCtrl <= "000";
                PSREn <= '0';
                MemWr <= '0';
                WrSrc <= '0';
                RegAff <= '0';
            WHEN ADDR =>
                nPC_SEL <= '0';
                RegWr <= '1';
                ALUSrc <= '0';
                ALUCtrl <= "000";
                PSREn <= '0';
                MemWr <= '0';
                WrSrc <= '0';
                RegAff <= '0';
            WHEN BAL =>
                nPC_SEL <= '1';
                RegWr <= '0';
                PSREn <= '0';
                MemWr <= '0';
                RegAff <= '0';
            WHEN BLT =>
                nPC_SEL <= psr(31);
                RegWr <= '0';
                PSREn <= '0';
                MemWr <= '0';
                RegAff <= '0';
            WHEN CMP =>
                nPC_SEL <= '0';
                RegWr <= '0';
                ALUSrc <= '1';
                ALUCtrl <= "010";
                PSREn <= '1';
                MemWr <= '0';
                RegAff <= '0';
            WHEN LDR =>
                nPC_SEL <= '0';
                RegWr <= '1';
                ALUSrc <= '1';
                ALUCtrl <= "000";
                PSREn <= '0';
                MemWr <= '0';
                WrSrc <= '1';
                RegAff <= '0';
            WHEN MOV =>
                nPC_SEL <= '0';
                RegWr <= '1';
                ALUSrc <= '1';
                ALUCtrl <= "001";
                PSREn <= '0';
                MemWr <= '0';
                WrSrc <= '0';
                RegAff <= '0';
            WHEN STR =>
                nPC_SEL <= '0';
                RegWr <= '0';
                RegSel <= '1';
                ALUSrc <= '1';
                ALUCtrl <= "000";
                PSREn <= '0';
                MemWr <= '1';
                WrSrc <= '1';
                RegAff <= '1';
            WHEN OTHERS =>
                NULL;
        END CASE;
    END PROCESS;
END Behavioral;