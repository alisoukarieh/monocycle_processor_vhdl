LIBRARY ieee;
USE IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY CPU IS
    PORT (
        Clk, Reset : IN STD_LOGIC;
        Afficheur : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
    );
END CPU;

ARCHITECTURE struct OF CPU IS
    SIGNAL instruction_signal, psr_signal : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL RegWr_signal, WrEn_signal, ALUSrc_signal, WrSrc_signal, RegSel_signal, nPcSel_signal, PSREn_signal, RegAff_signal : STD_LOGIC;
    SIGNAL ALUCtrl_signal : STD_LOGIC_VECTOR(2 DOWNTO 0);

    SIGNAL flags_32bits_signal : STD_LOGIC_VECTOR(31 DOWNTO 0) := (OTHERS => '0');

BEGIN

    UDT : ENTITY work.UniteDeTraitement
        PORT MAP(
            Clk => Clk,
            Reset => Reset,
            RegWr => RegWr_signal,
            WrEn => WrEn_signal,
            Com1 => ALUSrc_signal,
            Com2 => WrSrc_signal,
            Com3 => RegSel_signal,
            N => flags_32bits_signal(31),
            Z => flags_32bits_signal(30),
            C => flags_32bits_signal(29),
            V => flags_32bits_signal(28),
            Rw => instruction_signal(15 DOWNTO 12),
            Rm => instruction_signal(3 DOWNTO 0),
            Rd => instruction_signal(15 DOWNTO 12),
            Ra => instruction_signal(19 DOWNTO 16),
            Imm => instruction_signal(7 DOWNTO 0),
            OP => ALUCtrl_signal,
            RegAff => RegAff_signal,
            Afficheur => Afficheur
        );

    dcd : ENTITY work.Decoder
        PORT MAP(
            instruction => instruction_signal,
            psr => psr_signal,
            PSREn => PSREn_signal,
            nPC_SEL => nPcSel_signal,
            RegWr => RegWr_signal,
            RegSel => RegSel_signal,
            ALUCtrl => ALUCtrl_signal,
            ALUSrc => ALUSrc_signal,
            WrSrc => WrSrc_signal,
            MemWr => WrEn_signal,
            RegAff => RegAff_signal
        );

    UGI : ENTITY work.UniteGestionInstructions
        PORT MAP(
            clk => Clk,
            reset => Reset,
            nPcSel => nPcSel_signal,
            offset => instruction_signal(23 DOWNTO 0),
            instruction => instruction_signal
        );

    PSR : ENTITY work.RegisterPSR
        PORT MAP(
            CLK => Clk,
            RST => Reset,
            WE => PSREn_signal,
            DATAIN => flags_32bits_signal,
            DATAOUT => psr_signal
        );
END struct;