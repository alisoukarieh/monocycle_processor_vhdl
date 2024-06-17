-- SevenSeg.vhd
-- ------------------------------
--   squelette de l'encodeur sept segment
-- ------------------------------

--
-- Notes :
--  * We don't ask for an hexadecimal decoder, only 0..9
--  * outputs are active high if Pol='1'
--    else active low (Pol='0')
--  * Order is : Segout(1)=Seg_A, ... Segout(7)=Seg_G
--
--  * Display Layout :
--
--       A=Seg(1)
--      -----
--    F|     |B=Seg(2)
--     |  G  |
--      -----
--     |     |C=Seg(3)
--    E|     |
--      -----
--        D=Seg(4)
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

-- ------------------------------
ENTITY SEVEN_SEG IS
    -- ------------------------------
    PORT (
        Data : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        Pol : IN STD_LOGIC;
        Segout : OUT STD_LOGIC_VECTOR(0 TO 6));
END ENTITY SEVEN_SEG;

-- -----------------------------------------------
ARCHITECTURE COMB OF SEVEN_SEG IS
    -- ------------------------------------------------
    SIGNAL Segout_s : STD_LOGIC_VECTOR(0 TO 6);
BEGIN
    PROCESS (Data, Pol)
    BEGIN
        CASE Data IS
            WHEN x"0" => Segout_s <= "1111110";
            WHEN x"1" => Segout_s <= "0110000";
            WHEN x"2" => Segout_s <= "1101101";
            WHEN x"3" => Segout_s <= "1111001";
            WHEN x"4" => Segout_s <= "0110011";
            WHEN x"5" => Segout_s <= "1011011";
            WHEN x"6" => Segout_s <= "1011111";
            WHEN x"7" => Segout_s <= "1110000";
            WHEN x"8" => Segout_s <= "1111111";
            WHEN x"9" => Segout_s <= "1111011";
            WHEN x"A" => Segout_s <= "1110111";
            WHEN x"B" => Segout_s <= "0011111";
            WHEN x"C" => Segout_s <= "1001110";
            WHEN x"D" => Segout_s <= "0111101";
            WHEN x"E" => Segout_s <= "1001111";
            WHEN x"F" => Segout_s <= "1000111";
            WHEN OTHERS => Segout_s <= "1111111";
        END CASE;
        IF Pol = '1' THEN
            Segout <= Segout_s;
        ELSE
            Segout <= NOT Segout_s;
        END IF;
    END PROCESS;
END ARCHITECTURE COMB;