LIBRARY ieee;
USE IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY UniteDeTraitement IS
    PORT (
        Clk, Reset, RegWr, WrEn, Com1, Com2, Com3, RegAff : IN STD_LOGIC;
        Rw, Ra, Rm, Rd : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        Imm : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        OP : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        N, Z, C, V : OUT STD_LOGIC;
        Afficheur : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
    );
END UniteDeTraitement;

ARCHITECTURE struct OF UniteDeTraitement IS
    SIGNAL busRb, busMux : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL busA, busB, busW, busImm, ALUout, ALUin, dataOut : STD_LOGIC_VECTOR(31 DOWNTO 0);

BEGIN

    mux : ENTITY work.Multiplexer
        GENERIC MAP(N => 4)
        PORT MAP(
            A => Rm,
            B => Rd,
            COM => Com3,
            S => busMux
        );

    Registres : ENTITY work.RegisterBank
        PORT MAP(
            CLK => Clk,
            Reset => Reset,
            W => busW,
            RA => Ra,
            RB => busMux,
            RW => Rw,
            WE => RegWr,
            A => busA,
            B => busB
        );

    mux1 : ENTITY work.Multiplexer
        PORT MAP(
            A => busB,
            B => busImm,
            COM => Com1,
            S => ALUin
        );

    extender : ENTITY work.SignExtender
        PORT MAP(
            E => Imm,
            S => busImm
        );

    UAL : ENTITY work.UAL_32bits
        PORT MAP(
            OP => OP,
            A => busA,
            b => ALUin,
            S => ALUout,
            N => N,
            Z => Z,
            C => C,
            V => V
        );

    memory : ENTITY work.DataMemory
        PORT MAP(
            CLK => Clk,
            Reset => Reset,
            DataIn => busB,
            DataOut => dataOut,
            Addr => ALUout(5 DOWNTO 0),
            WrEn => WrEn
        );

    mux2 : ENTITY work.Multiplexer
        PORT MAP(
            A => ALUout,
            B => dataOut,
            COM => Com2,
            S => busW
        );

    RegAff_comp : ENTITY work.RegisterPSR
        PORT MAP(
            CLK => Clk,
            RST => Reset,
            WE => RegAff,
            DATAIN => busB,
            DATAOUT => Afficheur
        );

END struct;