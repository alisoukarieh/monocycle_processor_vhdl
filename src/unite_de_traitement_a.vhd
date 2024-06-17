LIBRARY ieee;
USE IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY UniteDeTraitement_a IS
    PORT (
        Clk, Reset, WE : IN STD_LOGIC;
        OP : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        Rw, Ra, Rb : IN STD_LOGIC_VECTOR(3 DOWNTO 0)
    );
END UniteDeTraitement_a;

ARCHITECTURE struct OF UniteDeTraitement_a IS
    SIGNAL busA, busB, busW : STD_LOGIC_VECTOR(31 DOWNTO 0);

BEGIN

    UAL : ENTITY work.UAL_32bits
        PORT MAP(
            OP => OP,
            A => busA,
            b => busB,
            S => busW,
            N => OPEN,
            Z => OPEN,
            C => OPEN,
            V => OPEN
        );

    Registres : ENTITY work.RegisterBank
        PORT MAP(
            CLK => Clk,
            Reset => Reset,
            W => busW,
            RA => Ra,
            RB => Rb,
            RW => Rw,
            WE => WE,
            A => busA,
            B => busB
        );

END struct;