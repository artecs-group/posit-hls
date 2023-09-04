--------------------------------------------------------------------------------
--                      Normalizer_ZO_30_30_30_F500_uid4
-- VHDL generated for Virtex6 @ 500MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Florent de Dinechin, (2007-2020)
--------------------------------------------------------------------------------
-- Pipeline depth: 3 cycles
-- Clock period (ns): 2
-- Target frequency (MHz): 500
-- Input signals: X OZb
-- Output signals: Count R

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity Normalizer_ZO_30_30_30_F500_uid4 is
    port (clock : in std_logic;
          X : in  std_logic_vector(29 downto 0);
          OZb : in  std_logic;
          Count : out  std_logic_vector(4 downto 0);
          R : out  std_logic_vector(29 downto 0)   );
end entity;

architecture arch of Normalizer_ZO_30_30_30_F500_uid4 is
signal level5 :  std_logic_vector(29 downto 0);
signal sozb, sozb_d1, sozb_d2, sozb_d3 :  std_logic;
signal count4, count4_d1, count4_d2, count4_d3 :  std_logic;
signal level4, level4_d1 :  std_logic_vector(29 downto 0);
signal count3, count3_d1, count3_d2 :  std_logic;
signal level3, level3_d1 :  std_logic_vector(29 downto 0);
signal count2, count2_d1 :  std_logic;
signal level2, level2_d1 :  std_logic_vector(29 downto 0);
signal count1, count1_d1 :  std_logic;
signal level1 :  std_logic_vector(29 downto 0);
signal count0 :  std_logic;
signal level0 :  std_logic_vector(29 downto 0);
signal sCount :  std_logic_vector(4 downto 0);
begin
   process(clock)
      begin
         if clock'event and clock = '1' then
            sozb_d1 <=  sozb;
            sozb_d2 <=  sozb_d1;
            sozb_d3 <=  sozb_d2;
            count4_d1 <=  count4;
            count4_d2 <=  count4_d1;
            count4_d3 <=  count4_d2;
            level4_d1 <=  level4;
            count3_d1 <=  count3;
            count3_d2 <=  count3_d1;
            level3_d1 <=  level3;
            count2_d1 <=  count2;
            level2_d1 <=  level2;
            count1_d1 <=  count1;
         end if;
      end process;
   level5 <= X ;
   sozb<= OZb;
   count4<= '1' when level5(29 downto 14) = (29 downto 14=>sozb) else '0';
   level4<= level5(29 downto 0) when count4='0' else level5(13 downto 0) & (15 downto 0 => '0');

   count3<= '1' when level4_d1(29 downto 22) = (29 downto 22=>sozb_d1) else '0';
   level3<= level4_d1(29 downto 0) when count3='0' else level4_d1(21 downto 0) & (7 downto 0 => '0');

   count2<= '1' when level3_d1(29 downto 26) = (29 downto 26=>sozb_d2) else '0';
   level2<= level3_d1(29 downto 0) when count2='0' else level3_d1(25 downto 0) & (3 downto 0 => '0');

   count1<= '1' when level2(29 downto 28) = (29 downto 28=>sozb_d2) else '0';
   level1<= level2_d1(29 downto 0) when count1_d1='0' else level2_d1(27 downto 0) & (1 downto 0 => '0');

   count0<= '1' when level1(29 downto 29) = (29 downto 29=>sozb_d3) else '0';
   level0<= level1(29 downto 0) when count0='0' else level1(28 downto 0) & (0 downto 0 => '0');

   R <= level0;
   sCount <= count4_d3 & count3_d2 & count2_d1 & count1_d1 & count0;
   Count <= sCount;
end architecture;

--------------------------------------------------------------------------------
--                              posit2float_32_32_500
--                     (Posit32_2_to_Float8_23_F500_uid2)
-- VHDL generated for Virtex6 @ 500MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Raul Murillo, 2021-2022
--------------------------------------------------------------------------------
-- Pipeline depth: 5 cycles
-- Clock period (ns): 2
-- Target frequency (MHz): 500
-- Input signals: I
-- Output signals: O

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity posit2float_32_32_500 is
    port (clock : in std_logic;
          reset : in std_logic;
          I : in  std_logic_vector(31 downto 0);
          O : out  std_logic_vector(31 downto 0)   );
end entity;

architecture arch of posit2float_32_32_500 is
   component Normalizer_ZO_30_30_30_F500_uid4 is
      port ( clock : in std_logic;
             X : in  std_logic_vector(29 downto 0);
             OZb : in  std_logic;
             Count : out  std_logic_vector(4 downto 0);
             R : out  std_logic_vector(29 downto 0)   );
   end component;

signal sign, sign_d1, sign_d2, sign_d3, sign_d4 :  std_logic;
signal encoding :  std_logic_vector(30 downto 0);
signal isZN, isZN_d1, isZN_d2, isZN_d3, isZN_d4 :  std_logic;
signal isNAR, isNAR_d1, isNAR_d2, isNAR_d3, isNAR_d4 :  std_logic;
signal isZero :  std_logic;
signal absoluteEncoding :  std_logic_vector(30 downto 0);
signal exponentSign, exponentSign_d1, exponentSign_d2, exponentSign_d3 :  std_logic;
signal encodingTail :  std_logic_vector(29 downto 0);
signal lzCount :  std_logic_vector(4 downto 0);
signal shiftedResult, shiftedResult_d1, shiftedResult_d2 :  std_logic_vector(29 downto 0);
signal rangeExp, rangeExp_d1 :  std_logic_vector(5 downto 0);
signal exponentVal, exponentVal_d1 :  std_logic_vector(1 downto 0);
signal exponent :  std_logic_vector(7 downto 0);
signal lsb, lsb_d1 :  std_logic;
signal guard, guard_d1 :  std_logic;
signal sticky :  std_logic;
signal round_bit, round_bit_d1 :  std_logic;
signal mantissa :  std_logic_vector(22 downto 0);
signal finalSignExp, finalSignExp_d1 :  std_logic_vector(8 downto 0);
begin
   process(clock)
      begin
         if clock'event and clock = '1' then
            sign_d1 <=  sign;
            sign_d2 <=  sign_d1;
            sign_d3 <=  sign_d2;
            sign_d4 <=  sign_d3;
            isZN_d1 <=  isZN;
            isZN_d2 <=  isZN_d1;
            isZN_d3 <=  isZN_d2;
            isZN_d4 <=  isZN_d3;
            isNAR_d1 <=  isNAR;
            isNAR_d2 <=  isNAR_d1;
            isNAR_d3 <=  isNAR_d2;
            isNAR_d4 <=  isNAR_d3;
            exponentSign_d1 <=  exponentSign;
            exponentSign_d2 <=  exponentSign_d1;
            exponentSign_d3 <=  exponentSign_d2;
            shiftedResult_d1 <=  shiftedResult;
            shiftedResult_d2 <=  shiftedResult_d1;
            rangeExp_d1 <=  rangeExp;
            exponentVal_d1 <=  exponentVal;
            lsb_d1 <=  lsb;
            guard_d1 <=  guard;
            round_bit_d1 <=  round_bit;
            finalSignExp_d1 <=  finalSignExp;
         end if;
      end process;
--------------------------- Start of vhdl generation ---------------------------
---------------------------- Sign and Special cases ----------------------------
   sign <= I(31);
   encoding <= I(30 downto 0);
   isZN <= '1' when (encoding = "0000000000000000000000000000000") else '0';
   isNAR <= sign AND isZN;
   isZero <= NOT(sign) AND isZN;
------------------------------ Regime extraction ------------------------------
   with sign  select  absoluteEncoding <= 
      encoding when '0',
      not(encoding) + 1 when '1',
      "-------------------------------" when others;
   exponentSign <= absoluteEncoding(30);
   encodingTail <= absoluteEncoding(29 downto 0);
   lzoc: Normalizer_ZO_30_30_30_F500_uid4
      port map ( clock  => clock,
                 OZb => exponentSign,
                 X => encodingTail,
                 Count => lzCount,
                 R => shiftedResult);
   with exponentSign_d3  select  rangeExp <= 
      ('1' & not (lzCount)) when '0',
      ('0' & lzCount) when '1',
      "------" when others;
--------------------------- Generate biased exponent ---------------------------
   -- Extract exponent
   exponentVal <= shiftedResult(28 downto 27);
   exponent <= (rangeExp_d1 & exponentVal_d1) + 127;
------------------------------ Generate mantissa ------------------------------
   lsb <= shiftedResult(4);
   guard <= shiftedResult(3);
   sticky <= '0' when (shiftedResult_d1(2 downto 0) = "000") else '1';
   round_bit <= guard_d1 and (sticky or lsb_d1);
   mantissa <= shiftedResult_d2(26 downto 4) + round_bit_d1;
   -- Final result
   with isZN_d4  select  finalSignExp <= 
      (others => isNAR_d4) when '1',
      (sign_d4 & exponent) when '0',
      "---------" when others;
   O <= finalSignExp_d1 & mantissa;
end architecture;

