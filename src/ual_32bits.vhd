LIBRARY ieee;
USE IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY UAL_32bits IS
    PORT (
        OP : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        A, B : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        S : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        N, Z, C, V : OUT STD_LOGIC
    );
END UAL_32bits;

ARCHITECTURE behavior OF UAL_32bits IS
    SIGNAL result : STD_LOGIC_VECTOR(31 DOWNTO 0);
BEGIN
    PROCESS (OP, A, B)
    BEGIN
        CASE OP IS
            WHEN "000" => -- ADD : Y = A + B
                result <= STD_LOGIC_VECTOR(signed(A) + signed(B));
            WHEN "001" => -- B : Y = B
                result <= B;
            WHEN "010" => -- SUB : Y = A - B
                result <= STD_LOGIC_VECTOR(signed(A) - signed(B));
            WHEN "011" => -- A : Y = A
                result <= A;
            WHEN "100" => -- OR : Y = A OR B
                result <= A OR B;
            WHEN "101" => -- AND : Y = A AND B
                result <= A AND B;
            WHEN "110" => -- XOR : Y = A XOR B
                result <= A XOR B;
            WHEN "111" => -- NOT : Y = NOT A
                result <= NOT A;
            WHEN OTHERS => -- Handle all other cases
                result <= (OTHERS => '0');
        END CASE;
    END PROCESS;
    S <= result;

    N <= result(31); -- Most significant bit indicates negative
    Z <= '1' WHEN result = (31 DOWNTO 0 => '0') ELSE
        '0'; -- Direct zero check
    C <= '1' WHEN (A /= "00000000000000000000000000000000" -- Carry check
        AND B /= "00000000000000000000000000000000" AND result = "00000000000000000000000000000000") ELSE
        '0';
    V <= '1' WHEN ((OP = "000") AND (A(31) = B(31) AND result(31) /= A(31))) OR
        ((OP = "010") AND (A(31) /= B(31) AND result(31) /= A(31))) ELSE
        '0'; -- Overflow check
END ARCHITECTURE behavior;