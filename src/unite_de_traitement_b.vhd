LIBRARY ieee;
USE IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY UniteDeTraitement_b IS
    PORT (
        Clk, Reset, RegWr, WrEn, Com1, Com2 : IN STD_LOGIC;
        Rw, Ra, Rb : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        Imm : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        OP : IN STD_LOGIC_VECTOR(2 DOWNTO 0)
    );
END UniteDeTraitement_b;

ARCHITECTURE struct OF UniteDeTraitement_b IS
    SIGNAL busA, busB, busW, busImm, ALUout, ALUin, dataOut : STD_LOGIC_VECTOR(31 DOWNTO 0);

BEGIN

    Registres : ENTITY work.RegisterBank
        PORT MAP(
            CLK => Clk,
            Reset => Reset,
            W => busW,
            RA => Ra,
            RB => Rb,
            RW => Rw,
            WE => RegWr,
            A => busA,
            B => busB
        );

    mux : ENTITY work.Multiplexer
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
            N => OPEN,
            Z => OPEN,
            C => OPEN,
            V => OPEN
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

END struct;