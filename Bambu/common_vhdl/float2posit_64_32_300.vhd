--------------------------------------------------------------------------------
--                  RightShifterSticky32_by_max_32_F300_uid4
-- VHDL generated for Virtex6 @ 300MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Bogdan Pasca (2008-2011), Florent de Dinechin (2008-2019)
--------------------------------------------------------------------------------
-- Pipeline depth: 2 cycles
-- Clock period (ns): 3.33333
-- Target frequency (MHz): 300
-- Input signals: X S padBit
-- Output signals: R Sticky

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity RightShifterSticky32_by_max_32_F300_uid4 is
    port (clock : in std_logic;
          X : in  std_logic_vector(31 downto 0);
          S : in  std_logic_vector(5 downto 0);
          padBit : in  std_logic;
          R : out  std_logic_vector(31 downto 0);
          Sticky : out  std_logic   );
end entity;

architecture arch of RightShifterSticky32_by_max_32_F300_uid4 is
signal ps, ps_d1, ps_d2 :  std_logic_vector(5 downto 0);
signal Xpadded :  std_logic_vector(31 downto 0);
signal level6 :  std_logic_vector(31 downto 0);
signal stk5 :  std_logic;
signal level5 :  std_logic_vector(31 downto 0);
signal stk4, stk4_d1 :  std_logic;
signal level4, level4_d1 :  std_logic_vector(31 downto 0);
signal stk3 :  std_logic;
signal level3, level3_d1 :  std_logic_vector(31 downto 0);
signal stk2, stk2_d1 :  std_logic;
signal level2, level2_d1, level2_d2 :  std_logic_vector(31 downto 0);
signal stk1 :  std_logic;
signal level1, level1_d1, level1_d2 :  std_logic_vector(31 downto 0);
signal stk0 :  std_logic;
signal level0 :  std_logic_vector(31 downto 0);
begin
   process(clock)
      begin
         if clock'event and clock = '1' then
            ps_d1 <=  ps;
            ps_d2 <=  ps_d1;
            stk4_d1 <=  stk4;
            level4_d1 <=  level4;
            level3_d1 <=  level3;
            stk2_d1 <=  stk2;
            level2_d1 <=  level2;
            level2_d2 <=  level2_d1;
            level1_d1 <=  level1;
            level1_d2 <=  level1_d1;
         end if;
      end process;
   ps<= S;
   Xpadded <= X;
   level6<= Xpadded;
   stk5 <= '1' when (level6(31 downto 0)/="00000000000000000000000000000000" and ps(5)='1')   else '0';
   level5 <=  level6 when  ps(5)='0'    else (31 downto 0 => padBit) ;
   stk4 <= '1' when (level5(15 downto 0)/="0000000000000000" and ps(4)='1') or stk5 ='1'   else '0';
   level4 <=  level5 when  ps(4)='0'    else (15 downto 0 => padBit) & level5(31 downto 16);
   stk3 <= '1' when (level4_d1(7 downto 0)/="00000000" and ps_d1(3)='1') or stk4_d1 ='1'   else '0';
   level3 <=  level4 when  ps(3)='0'    else (7 downto 0 => padBit) & level4(31 downto 8);
   stk2 <= '1' when (level3_d1(3 downto 0)/="0000" and ps_d1(2)='1') or stk3 ='1'   else '0';
   level2 <=  level3 when  ps(2)='0'    else (3 downto 0 => padBit) & level3(31 downto 4);
   stk1 <= '1' when (level2_d2(1 downto 0)/="00" and ps_d2(1)='1') or stk2_d1 ='1'   else '0';
   level1 <=  level2 when  ps(1)='0'    else (1 downto 0 => padBit) & level2(31 downto 2);
   stk0 <= '1' when (level1_d2(0 downto 0)/="0" and ps_d2(0)='1') or stk1 ='1'   else '0';
   level0 <=  level1 when  ps(0)='0'    else (0 downto 0 => padBit) & level1(31 downto 1);
   R <= level0;
   Sticky <= stk0;
end architecture;

--------------------------------------------------------------------------------
--                           float2posit_64_32_300
--                    (Float11_52_to_Posit32_2_F300_uid2)
-- VHDL generated for Virtex6 @ 300MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Raul Murillo, 2021
--------------------------------------------------------------------------------
-- Pipeline depth: 4 cycles
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

entity float2posit_64_32_300 is
    port (clock : in std_logic;
          reset : in std_logic;
          I : in  std_logic_vector(63 downto 0);
          O : out  std_logic_vector(31 downto 0)   );
end entity;

architecture arch of float2posit_64_32_300 is
   component RightShifterSticky32_by_max_32_F300_uid4 is
      port ( clock : in std_logic;
             X : in  std_logic_vector(31 downto 0);
             S : in  std_logic_vector(5 downto 0);
             padBit : in  std_logic;
             R : out  std_logic_vector(31 downto 0);
             Sticky : out  std_logic   );
   end component;

signal sign, sign_d1, sign_d2, sign_d3, sign_d4 :  std_logic;
signal biased_exp :  std_logic_vector(10 downto 0);
signal fraction, fraction_d1 :  std_logic_vector(27 downto 0);
signal trunc_sticky, trunc_sticky_d1, trunc_sticky_d2, trunc_sticky_d3 :  std_logic;
signal is_zero, is_zero_d1, is_zero_d2, is_zero_d3, is_zero_d4 :  std_logic;
signal is_NaN, is_NaN_d1, is_NaN_d2, is_NaN_d3, is_NaN_d4 :  std_logic;
signal unbiased_exp :  std_logic_vector(10 downto 0);
signal notTooBig :  std_logic;
signal notTooSmall :  std_logic;
signal expFit :  std_logic;
signal exponent :  std_logic_vector(8 downto 0);
signal partial_exponent_us, partial_exponent_us_d1 :  std_logic_vector(1 downto 0);
signal bin_regime, bin_regime_d1 :  std_logic_vector(5 downto 0);
signal first_regime, first_regime_d1 :  std_logic;
signal regime :  std_logic_vector(5 downto 0);
signal pad_bit :  std_logic;
signal start_regime :  std_logic_vector(1 downto 0);
signal input_shifter :  std_logic_vector(31 downto 0);
signal extended_posit :  std_logic_vector(31 downto 0);
signal pre_sticky :  std_logic;
signal truncated_posit, truncated_posit_d1, truncated_posit_d2, truncated_posit_d3 :  std_logic_vector(30 downto 0);
signal lsb, lsb_d1, lsb_d2, lsb_d3 :  std_logic;
signal guard, guard_d1, guard_d2, guard_d3 :  std_logic;
signal sticky, sticky_d1 :  std_logic;
signal round_bit :  std_logic;
signal rounded_reg_exp_frac :  std_logic_vector(30 downto 0);
signal rounded_posit :  std_logic_vector(31 downto 0);
signal rounded_posit_zero :  std_logic_vector(31 downto 0);
begin
   process(clock)
      begin
         if clock'event and clock = '1' then
            sign_d1 <=  sign;
            sign_d2 <=  sign_d1;
            sign_d3 <=  sign_d2;
            sign_d4 <=  sign_d3;
            fraction_d1 <=  fraction;
            trunc_sticky_d1 <=  trunc_sticky;
            trunc_sticky_d2 <=  trunc_sticky_d1;
            trunc_sticky_d3 <=  trunc_sticky_d2;
            is_zero_d1 <=  is_zero;
            is_zero_d2 <=  is_zero_d1;
            is_zero_d3 <=  is_zero_d2;
            is_zero_d4 <=  is_zero_d3;
            is_NaN_d1 <=  is_NaN;
            is_NaN_d2 <=  is_NaN_d1;
            is_NaN_d3 <=  is_NaN_d2;
            is_NaN_d4 <=  is_NaN_d3;
            partial_exponent_us_d1 <=  partial_exponent_us;
            bin_regime_d1 <=  bin_regime;
            first_regime_d1 <=  first_regime;
            truncated_posit_d1 <=  truncated_posit;
            truncated_posit_d2 <=  truncated_posit_d1;
            truncated_posit_d3 <=  truncated_posit_d2;
            lsb_d1 <=  lsb;
            lsb_d2 <=  lsb_d1;
            lsb_d3 <=  lsb_d2;
            guard_d1 <=  guard;
            guard_d2 <=  guard_d1;
            guard_d3 <=  guard_d2;
            sticky_d1 <=  sticky;
         end if;
      end process;
--------------------------- Start of vhdl generation ---------------------------
----------------------- Split sign, exponent & fraction -----------------------
   sign <= I(63);
   biased_exp <= I(62 downto 52);
   fraction <= I(51 downto 24);
   trunc_sticky <= '0' when (I(23 downto 0) = "000000000000000000000000") else '1';
   -- Special cases
   is_zero<= '1' when (biased_exp = "00000000000") else '0';
   is_NaN<= '1' when (biased_exp = "11111111111") else '0';
   -- Compute unbiased exponent
   unbiased_exp <= biased_exp - 1023;
   notTooBig <= '1' when (unbiased_exp(10 downto 8) = "000") else '0';
   notTooSmall <= '1' when (unbiased_exp(10 downto 8) = "111") else '0';
   expFit <= notTooBig or notTooSmall;
   with expFit  select  exponent <= 
      unbiased_exp(8 downto 0) when '1',
      unbiased_exp(8) & "11111111" when '0',
      "---------" when others;
   partial_exponent_us <= exponent(1 downto 0);
---------------------------- Generate regime field ----------------------------
   bin_regime <= exponent(7 downto 2);
   first_regime <= exponent(8);
   with first_regime_d1  select  regime <= 
      bin_regime_d1 when '0', 
      not bin_regime_d1 when '1', 
      "------" when others;
   pad_bit <= not(first_regime_d1);
   start_regime <= not(first_regime_d1) & first_regime_d1;
   input_shifter <= start_regime & partial_exponent_us_d1 & fraction_d1;
   rshift: RightShifterSticky32_by_max_32_F300_uid4
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
   sticky <= trunc_sticky_d3 OR pre_sticky;
   round_bit <= guard_d3 and (sticky_d1 or lsb_d3);
   rounded_reg_exp_frac <= truncated_posit_d3 + round_bit;
   with sign_d4  select  rounded_posit <= 
      sign_d4 & rounded_reg_exp_frac when '0',
      sign_d4 & not(rounded_reg_exp_frac) + 1 when '1',
      "--------------------------------" when others;
   rounded_posit_zero <= rounded_posit when (is_zero_d4 or is_NaN_d4) = '0' else (is_NaN_d4 & "0000000000000000000000000000000");
   O <= rounded_posit_zero;
---------------------------- End of vhdl generation ----------------------------
end architecture;

