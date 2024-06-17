LIBRARY ieee;
USE IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY CPUInterruption IS
    PORT (
        Clk, Reset, IRQ0, IRQ1 : IN STD_LOGIC;
        Afficheur : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
    );
END CPUInterruption;

ARCHITECTURE struct OF CPUInterruption IS
    SIGNAL instruction_signal, psr_signal, vicpc_signal, extended_offset : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL RegWr_signal, WrEn_signal, ALUSrc_signal, WrSrc_signal, RegSel_signal, nPcSel_signal, PSREn_signal, RegAff_signal, IRQ_END_signal, IRQ_SERV_signal, IRQ_sigal : STD_LOGIC;
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

    dcd : ENTITY work.DecoderInterruption
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
            RegAff => RegAff_signal,
            IRQ_END => IRQ_END_signal
        );

    extender : ENTITY work.SignExtender(Behavioral)
        GENERIC MAP(N => 24)
        PORT MAP(
            E => instruction_signal(23 DOWNTO 0),
            S => extended_offset
        );

    UGI : ENTITY work.UniteGestionInstructionsInterruptions
        PORT MAP(
            clk => Clk,
            reset => Reset,
            nPcSel => nPcSel_signal,
            offset => extended_offset,
            instruction => instruction_signal,
            IRQ_END => IRQ_END_signal,
            IRQ => IRQ_sigal,
            VICPC => vicpc_signal,
            IRQ_SERV => IRQ_SERV_signal
        );

    VIC : ENTITY work.VIC
        PORT MAP(
            CLK => Clk,
            RESET => Reset,
            IRQ_SERV => IRQ_SERV_signal,
            IRQ0 => IRQ0,
            IRQ1 => IRQ1,
            IRQ => IRQ_sigal,
            VICPC => vicpc_signal
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