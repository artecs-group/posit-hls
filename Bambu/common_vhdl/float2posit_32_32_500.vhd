--------------------------------------------------------------------------------
--                  RightShifterSticky32_by_max_32_F500_uid4
-- VHDL generated for Virtex6 @ 500MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Bogdan Pasca (2008-2011), Florent de Dinechin (2008-2019)
--------------------------------------------------------------------------------
-- Pipeline depth: 5 cycles
-- Clock period (ns): 2
-- Target frequency (MHz): 500
-- Input signals: X S padBit
-- Output signals: R Sticky

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity RightShifterSticky32_by_max_32_F500_uid4 is
    port (clock : in std_logic;
          X : in  std_logic_vector(31 downto 0);
          S : in  std_logic_vector(5 downto 0);
          padBit : in  std_logic;
          R : out  std_logic_vector(31 downto 0);
          Sticky : out  std_logic   );
end entity;

architecture arch of RightShifterSticky32_by_max_32_F500_uid4 is
signal ps, ps_d1, ps_d2, ps_d3, ps_d4, ps_d5 :  std_logic_vector(5 downto 0);
signal Xpadded :  std_logic_vector(31 downto 0);
signal level6, level6_d1 :  std_logic_vector(31 downto 0);
signal stk5, stk5_d1 :  std_logic;
signal level5, level5_d1, level5_d2 :  std_logic_vector(31 downto 0);
signal stk4, stk4_d1 :  std_logic;
signal level4, level4_d1, level4_d2, level4_d3 :  std_logic_vector(31 downto 0);
signal stk3, stk3_d1 :  std_logic;
signal level3, level3_d1, level3_d2, level3_d3, level3_d4 :  std_logic_vector(31 downto 0);
signal stk2 :  std_logic;
signal level2, level2_d1, level2_d2, level2_d3 :  std_logic_vector(31 downto 0);
signal stk1, stk1_d1 :  std_logic;
signal level1, level1_d1, level1_d2, level1_d3, level1_d4 :  std_logic_vector(31 downto 0);
signal stk0 :  std_logic;
signal level0 :  std_logic_vector(31 downto 0);
signal padBit_d1 :  std_logic;
begin
   process(clock)
      begin
         if clock'event and clock = '1' then
            ps_d1 <=  ps;
            ps_d2 <=  ps_d1;
            ps_d3 <=  ps_d2;
            ps_d4 <=  ps_d3;
            ps_d5 <=  ps_d4;
            level6_d1 <=  level6;
            stk5_d1 <=  stk5;
            level5_d1 <=  level5;
            level5_d2 <=  level5_d1;
            stk4_d1 <=  stk4;
            level4_d1 <=  level4;
            level4_d2 <=  level4_d1;
            level4_d3 <=  level4_d2;
            stk3_d1 <=  stk3;
            level3_d1 <=  level3;
            level3_d2 <=  level3_d1;
            level3_d3 <=  level3_d2;
            level3_d4 <=  level3_d3;
            level2_d1 <=  level2;
            level2_d2 <=  level2_d1;
            level2_d3 <=  level2_d2;
            stk1_d1 <=  stk1;
            level1_d1 <=  level1;
            level1_d2 <=  level1_d1;
            level1_d3 <=  level1_d2;
            level1_d4 <=  level1_d3;
            padBit_d1 <=  padBit;
         end if;
      end process;
   ps<= S;
   Xpadded <= X;
   level6<= Xpadded;
   stk5 <= '1' when (level6_d1(31 downto 0)/="00000000000000000000000000000000" and ps_d1(5)='1')   else '0';
   level5 <=  level6 when  ps(5)='0'    else (31 downto 0 => padBit) ;
   stk4 <= '1' when (level5_d2(15 downto 0)/="0000000000000000" and ps_d2(4)='1') or stk5_d1 ='1'   else '0';
   level4 <=  level5 when  ps(4)='0'    else (15 downto 0 => padBit) & level5(31 downto 16);
   stk3 <= '1' when (level4_d3(7 downto 0)/="00000000" and ps_d3(3)='1') or stk4_d1 ='1'   else '0';
   level3 <=  level4 when  ps(3)='0'    else (7 downto 0 => padBit) & level4(31 downto 8);
   stk2 <= '1' when (level3_d4(3 downto 0)/="0000" and ps_d4(2)='1') or stk3_d1 ='1'   else '0';
   level2 <=  level3_d1 when  ps_d1(2)='0'    else (3 downto 0 => padBit_d1) & level3_d1(31 downto 4);
   stk1 <= '1' when (level2_d3(1 downto 0)/="00" and ps_d4(1)='1') or stk2 ='1'   else '0';
   level1 <=  level2 when  ps_d1(1)='0'    else (1 downto 0 => padBit_d1) & level2(31 downto 2);
   stk0 <= '1' when (level1_d4(0 downto 0)/="0" and ps_d5(0)='1') or stk1_d1 ='1'   else '0';
   level0 <=  level1 when  ps_d1(0)='0'    else (0 downto 0 => padBit_d1) & level1(31 downto 1);
   R <= level0;
   Sticky <= stk0;
end architecture;

--------------------------------------------------------------------------------
--                              float2posit_32_32_500
--                     (Float8_23_to_Posit32_2_F500_uid2)
-- VHDL generated for Virtex6 @ 500MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Raul Murillo, 2021
--------------------------------------------------------------------------------
-- Pipeline depth: 7 cycles
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

entity float2posit_32_32_500 is
    port (clock : in std_logic;
          reset : in std_logic;
          I : in  std_logic_vector(31 downto 0);
          O : out  std_logic_vector(31 downto 0)   );
end entity;

architecture arch of float2posit_32_32_500 is
   component RightShifterSticky32_by_max_32_F500_uid4 is
      port ( clock : in std_logic;
             X : in  std_logic_vector(31 downto 0);
             S : in  std_logic_vector(5 downto 0);
             padBit : in  std_logic;
             R : out  std_logic_vector(31 downto 0);
             Sticky : out  std_logic   );
   end component;

signal sign, sign_d1, sign_d2, sign_d3, sign_d4, sign_d5, sign_d6 :  std_logic;
signal biased_exp :  std_logic_vector(7 downto 0);
signal fraction :  std_logic_vector(27 downto 0);
signal is_zero, is_zero_d1, is_zero_d2, is_zero_d3, is_zero_d4, is_zero_d5, is_zero_d6, is_zero_d7 :  std_logic;
signal is_NaN, is_NaN_d1, is_NaN_d2, is_NaN_d3, is_NaN_d4, is_NaN_d5, is_NaN_d6, is_NaN_d7 :  std_logic;
signal exponent :  std_logic_vector(8 downto 0);
signal partial_exponent_us :  std_logic_vector(1 downto 0);
signal bin_regime :  std_logic_vector(5 downto 0);
signal first_regime :  std_logic;
signal regime :  std_logic_vector(5 downto 0);
signal pad_bit :  std_logic;
signal start_regime :  std_logic_vector(1 downto 0);
signal input_shifter :  std_logic_vector(31 downto 0);
signal extended_posit :  std_logic_vector(31 downto 0);
signal pre_sticky :  std_logic;
signal truncated_posit, truncated_posit_d1, truncated_posit_d2, truncated_posit_d3, truncated_posit_d4, truncated_posit_d5 :  std_logic_vector(30 downto 0);
signal lsb, lsb_d1, lsb_d2, lsb_d3, lsb_d4 :  std_logic;
signal guard, guard_d1, guard_d2, guard_d3, guard_d4 :  std_logic;
signal sticky :  std_logic;
signal round_bit, round_bit_d1 :  std_logic;
signal rounded_reg_exp_frac :  std_logic_vector(30 downto 0);
signal rounded_posit, rounded_posit_d1 :  std_logic_vector(31 downto 0);
signal rounded_posit_zero :  std_logic_vector(31 downto 0);
begin
   process(clock)
      begin
         if clock'event and clock = '1' then
            sign_d1 <=  sign;
            sign_d2 <=  sign_d1;
            sign_d3 <=  sign_d2;
            sign_d4 <=  sign_d3;
            sign_d5 <=  sign_d4;
            sign_d6 <=  sign_d5;
            is_zero_d1 <=  is_zero;
            is_zero_d2 <=  is_zero_d1;
            is_zero_d3 <=  is_zero_d2;
            is_zero_d4 <=  is_zero_d3;
            is_zero_d5 <=  is_zero_d4;
            is_zero_d6 <=  is_zero_d5;
            is_zero_d7 <=  is_zero_d6;
            is_NaN_d1 <=  is_NaN;
            is_NaN_d2 <=  is_NaN_d1;
            is_NaN_d3 <=  is_NaN_d2;
            is_NaN_d4 <=  is_NaN_d3;
            is_NaN_d5 <=  is_NaN_d4;
            is_NaN_d6 <=  is_NaN_d5;
            is_NaN_d7 <=  is_NaN_d6;
            truncated_posit_d1 <=  truncated_posit;
            truncated_posit_d2 <=  truncated_posit_d1;
            truncated_posit_d3 <=  truncated_posit_d2;
            truncated_posit_d4 <=  truncated_posit_d3;
            truncated_posit_d5 <=  truncated_posit_d4;
            lsb_d1 <=  lsb;
            lsb_d2 <=  lsb_d1;
            lsb_d3 <=  lsb_d2;
            lsb_d4 <=  lsb_d3;
            guard_d1 <=  guard;
            guard_d2 <=  guard_d1;
            guard_d3 <=  guard_d2;
            guard_d4 <=  guard_d3;
            round_bit_d1 <=  round_bit;
            rounded_posit_d1 <=  rounded_posit;
         end if;
      end process;
--------------------------- Start of vhdl generation ---------------------------
----------------------- Split sign, exponent & fraction -----------------------
   sign <= I(31);
   biased_exp <= I(30 downto 23);
   fraction <= I(22 downto 0) & "00000";
   -- Special cases
   is_zero<= '1' when (biased_exp = "00000000") else '0';
   is_NaN<= '1' when (biased_exp = "11111111") else '0';
   -- Compute unbiased exponent
   exponent <= ("0" & biased_exp) - 127;
   partial_exponent_us <= exponent(1 downto 0);
---------------------------- Generate regime field ----------------------------
   bin_regime <= exponent(7 downto 2);
   first_regime <= exponent(8);
   with first_regime  select  regime <= 
      bin_regime when '0', 
      not bin_regime when '1', 
      "------" when others;
   pad_bit <= not(first_regime);
   start_regime <= not(first_regime) & first_regime;
   input_shifter <= start_regime & partial_exponent_us & fraction;
   rshift: RightShifterSticky32_by_max_32_F500_uid4
      port map ( clock  => clock,
                 S => regime,
                 X => input_shifter,
                 padBit => pad_bit,
                 R => extended_posit,
                 Sticky => pre_sticky);
----------------------------- Round shifted result -----------------------------
   truncated_posit <= extended_posit(31 downto 1);
   lsb <= extended_posit(1);
   guard <= extended_posit(0);
   sticky <= pre_sticky;
   round_bit <= guard_d4 and (sticky or lsb_d4);
   rounded_reg_exp_frac <= truncated_posit_d5 + round_bit_d1;
   with sign_d6  select  rounded_posit <= 
      sign_d6 & rounded_reg_exp_frac when '0',
      sign_d6 & not(rounded_reg_exp_frac) + 1 when '1',
      "--------------------------------" when others;
   rounded_posit_zero <= rounded_posit_d1 when (is_zero_d7 or is_NaN_d7) = '0' else (is_NaN_d7 & "0000000000000000000000000000000");
   O <= rounded_posit_zero;
---------------------------- End of vhdl generation ----------------------------
end architecture;

