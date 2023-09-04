--------------------------------------------------------------------------------
--                      Normalizer_ZO_30_30_30_F300_uid4
-- VHDL generated for Virtex6 @ 300MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Florent de Dinechin, (2007-2020)
--------------------------------------------------------------------------------
-- Pipeline depth: 2 cycles
-- Clock period (ns): 3.33333
-- Target frequency (MHz): 300
-- Input signals: X OZb
-- Output signals: Count R

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity Normalizer_ZO_30_30_30_F300_uid4 is
    port (clock : in std_logic;
          X : in  std_logic_vector(29 downto 0);
          OZb : in  std_logic;
          Count : out  std_logic_vector(4 downto 0);
          R : out  std_logic_vector(29 downto 0)   );
end entity;

architecture arch of Normalizer_ZO_30_30_30_F300_uid4 is
signal level5 :  std_logic_vector(29 downto 0);
signal sozb, sozb_d1 :  std_logic;
signal count4, count4_d1 :  std_logic;
signal level4 :  std_logic_vector(29 downto 0);
signal count3, count3_d1 :  std_logic;
signal level3, level3_d1 :  std_logic_vector(29 downto 0);
signal count2 :  std_logic;
signal level2 :  std_logic_vector(29 downto 0);
signal count1 :  std_logic;
signal level1, level1_d1 :  std_logic_vector(29 downto 0);
signal count0, count0_d1 :  std_logic;
signal level0 :  std_logic_vector(29 downto 0);
signal sCount :  std_logic_vector(4 downto 0);
begin
   process(clock)
      begin
         if clock'event and clock = '1' then
            sozb_d1 <=  sozb;
            count4_d1 <=  count4;
            count3_d1 <=  count3;
            level3_d1 <=  level3;
            level1_d1 <=  level1;
            count0_d1 <=  count0;
         end if;
      end process;
   level5 <= X ;
   sozb<= OZb;
   count4<= '1' when level5(29 downto 14) = (29 downto 14=>sozb) else '0';
   level4<= level5(29 downto 0) when count4='0' else level5(13 downto 0) & (15 downto 0 => '0');

   count3<= '1' when level4(29 downto 22) = (29 downto 22=>sozb) else '0';
   level3<= level4(29 downto 0) when count3='0' else level4(21 downto 0) & (7 downto 0 => '0');

   count2<= '1' when level3_d1(29 downto 26) = (29 downto 26=>sozb_d1) else '0';
   level2<= level3_d1(29 downto 0) when count2='0' else level3_d1(25 downto 0) & (3 downto 0 => '0');

   count1<= '1' when level2(29 downto 28) = (29 downto 28=>sozb_d1) else '0';
   level1<= level2(29 downto 0) when count1='0' else level2(27 downto 0) & (1 downto 0 => '0');

   count0<= '1' when level1(29 downto 29) = (29 downto 29=>sozb_d1) else '0';
   level0<= level1_d1(29 downto 0) when count0_d1='0' else level1_d1(28 downto 0) & (0 downto 0 => '0');

   R <= level0;
   sCount <= count4_d1 & count3_d1 & count2 & count1 & count0;
   Count <= sCount;
end architecture;

--------------------------------------------------------------------------------
--                              posit2float_32_32_300
--                     (Posit32_2_to_Float8_23_F300_uid2)
-- VHDL generated for Virtex6 @ 300MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Raul Murillo, 2021-2022
--------------------------------------------------------------------------------
-- Pipeline depth: 2 cycles
-- Clock period (ns): 3.33333
-- Target frequency (MHz): 300
-- Input signals: I
-- Output signals: O

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity posit2float_32_32_300 is
    port (clock : in std_logic;
          reset : in std_logic;
          I : in  std_logic_vector(31 downto 0);
          O : out  std_logic_vector(31 downto 0)   );
end entity;

architecture arch of posit2float_32_32_300 is
   component Normalizer_ZO_30_30_30_F300_uid4 is
      port ( clock : in std_logic;
             X : in  std_logic_vector(29 downto 0);
             OZb : in  std_logic;
             Count : out  std_logic_vector(4 downto 0);
             R : out  std_logic_vector(29 downto 0)   );
   end component;

signal sign, sign_d1, sign_d2 :  std_logic;
signal encoding :  std_logic_vector(30 downto 0);
signal isZN, isZN_d1, isZN_d2 :  std_logic;
signal isNAR, isNAR_d1, isNAR_d2 :  std_logic;
signal isZero :  std_logic;
signal absoluteEncoding :  std_logic_vector(30 downto 0);
signal exponentSign, exponentSign_d1, exponentSign_d2 :  std_logic;
signal encodingTail :  std_logic_vector(29 downto 0);
signal lzCount, lzCount_d1 :  std_logic_vector(4 downto 0);
signal shiftedResult :  std_logic_vector(29 downto 0);
signal rangeExp :  std_logic_vector(5 downto 0);
signal exponentVal :  std_logic_vector(1 downto 0);
signal exponent :  std_logic_vector(7 downto 0);
signal lsb :  std_logic;
signal guard :  std_logic;
signal sticky :  std_logic;
signal round_bit :  std_logic;
signal mantissa :  std_logic_vector(22 downto 0);
signal finalSignExp :  std_logic_vector(8 downto 0);
begin
   process(clock)
      begin
         if clock'event and clock = '1' then
            sign_d1 <=  sign;
            sign_d2 <=  sign_d1;
            isZN_d1 <=  isZN;
            isZN_d2 <=  isZN_d1;
            isNAR_d1 <=  isNAR;
            isNAR_d2 <=  isNAR_d1;
            exponentSign_d1 <=  exponentSign;
            exponentSign_d2 <=  exponentSign_d1;
            lzCount_d1 <=  lzCount;
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
   lzoc: Normalizer_ZO_30_30_30_F300_uid4
      port map ( clock  => clock,
                 OZb => exponentSign,
                 X => encodingTail,
                 Count => lzCount,
                 R => shiftedResult);
   with exponentSign_d2  select  rangeExp <= 
      ('1' & not (lzCount_d1)) when '0',
      ('0' & lzCount_d1) when '1',
      "------" when others;
--------------------------- Generate biased exponent ---------------------------
   -- Extract exponent
   exponentVal <= shiftedResult(28 downto 27);
   exponent <= (rangeExp & exponentVal) + 127;
------------------------------ Generate mantissa ------------------------------
   lsb <= shiftedResult(4);
   guard <= shiftedResult(3);
   sticky <= '0' when (shiftedResult(2 downto 0) = "000") else '1';
   round_bit <= guard and (sticky or lsb);
   mantissa <= shiftedResult(26 downto 4) + round_bit;
   -- Final result
   with isZN_d2  select  finalSignExp <= 
      (others => isNAR_d2) when '1',
      (sign_d2 & exponent) when '0',
      "---------" when others;
   O <= finalSignExp & mantissa;
end architecture;

