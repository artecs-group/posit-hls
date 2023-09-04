--------------------------------------------------------------------------------
--                          InputIEEE_11_52_to_11_52
-- VHDL generated for Virtex6 @ 700MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Florent de Dinechin (2008)
--------------------------------------------------------------------------------
-- Pipeline depth: 0 cycles
-- Clock period (ns): 1.42857
-- Target frequency (MHz): 700
-- Input signals: X
-- Output signals: R

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity InputIEEE_11_52_to_11_52 is
    port (clk : in std_logic;
          X : in  std_logic_vector(63 downto 0);
          R : out  std_logic_vector(11+52+2 downto 0)   );
end entity;

architecture arch of InputIEEE_11_52_to_11_52 is
signal expX :  std_logic_vector(10 downto 0);
signal fracX :  std_logic_vector(51 downto 0);
signal sX :  std_logic;
signal expZero :  std_logic;
signal expInfty :  std_logic;
signal fracZero :  std_logic;
signal reprSubNormal :  std_logic;
signal sfracX :  std_logic_vector(51 downto 0);
signal fracR :  std_logic_vector(51 downto 0);
signal expR :  std_logic_vector(10 downto 0);
signal infinity :  std_logic;
signal zero :  std_logic;
signal NaN :  std_logic;
signal exnR :  std_logic_vector(1 downto 0);
begin
   expX  <= X(62 downto 52);
   fracX  <= X(51 downto 0);
   sX  <= X(63);
   expZero  <= '1' when expX = (10 downto 0 => '0') else '0';
   expInfty  <= '1' when expX = (10 downto 0 => '1') else '0';
   fracZero <= '1' when fracX = (51 downto 0 => '0') else '0';
   reprSubNormal <= fracX(51);
   -- since we have one more exponent value than IEEE (field 0...0, value emin-1),
   -- we can represent subnormal numbers whose mantissa field begins with a 1
   sfracX <= fracX(50 downto 0) & '0' when (expZero='1' and reprSubNormal='1')    else fracX;
   fracR <= sfracX;
   -- copy exponent. This will be OK even for subnormals, zero and infty since in such cases the exn bits will prevail
   expR <= expX;
   infinity <= expInfty and fracZero;
   zero <= expZero and not reprSubNormal;
   NaN <= expInfty and not fracZero;
   exnR <= 
           "00" when zero='1' 
      else "10" when infinity='1' 
      else "11" when NaN='1' 
      else "01" ;  -- normal number
   R <= exnR & sX & expR & fracR; 
end architecture;

--------------------------------------------------------------------------------
--                                FPSqrt_11_52
-- VHDL generated for Virtex6 @ 700MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: 
--------------------------------------------------------------------------------
-- Pipeline depth: 54 cycles
-- Clock period (ns): 1.42857
-- Target frequency (MHz): 700
-- Input signals: X
-- Output signals: R

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity FPSqrt_11_52 is
    port (clk : in std_logic;
          X : in  std_logic_vector(11+52+2 downto 0);
          R : out  std_logic_vector(11+52+2 downto 0)   );
end entity;

architecture arch of FPSqrt_11_52 is
signal fracX :  std_logic_vector(51 downto 0);
signal eRn0 :  std_logic_vector(10 downto 0);
signal xsX :  std_logic_vector(2 downto 0);
signal eRn1, eRn1_d1, eRn1_d2, eRn1_d3, eRn1_d4, eRn1_d5, eRn1_d6, eRn1_d7, eRn1_d8, eRn1_d9, eRn1_d10, eRn1_d11, eRn1_d12, eRn1_d13, eRn1_d14, eRn1_d15, eRn1_d16, eRn1_d17, eRn1_d18, eRn1_d19, eRn1_d20, eRn1_d21, eRn1_d22, eRn1_d23, eRn1_d24, eRn1_d25, eRn1_d26, eRn1_d27, eRn1_d28, eRn1_d29, eRn1_d30, eRn1_d31, eRn1_d32, eRn1_d33, eRn1_d34, eRn1_d35, eRn1_d36, eRn1_d37, eRn1_d38, eRn1_d39, eRn1_d40, eRn1_d41, eRn1_d42, eRn1_d43, eRn1_d44, eRn1_d45, eRn1_d46, eRn1_d47, eRn1_d48, eRn1_d49, eRn1_d50, eRn1_d51, eRn1_d52, eRn1_d53, eRn1_d54 :  std_logic_vector(10 downto 0);
signal fracXnorm :  std_logic_vector(55 downto 0);
signal S0 :  std_logic_vector(1 downto 0);
signal T1 :  std_logic_vector(55 downto 0);
signal d1, d1_d1 :  std_logic;
signal T1s :  std_logic_vector(56 downto 0);
signal T1s_h, T1s_h_d1 :  std_logic_vector(5 downto 0);
signal T1s_l, T1s_l_d1 :  std_logic_vector(50 downto 0);
signal U1, U1_d1 :  std_logic_vector(5 downto 0);
signal T3_h :  std_logic_vector(5 downto 0);
signal T2 :  std_logic_vector(55 downto 0);
signal S1, S1_d1 :  std_logic_vector(2 downto 0);
signal d2, d2_d1 :  std_logic;
signal T2s :  std_logic_vector(56 downto 0);
signal T2s_h, T2s_h_d1 :  std_logic_vector(6 downto 0);
signal T2s_l, T2s_l_d1 :  std_logic_vector(49 downto 0);
signal U2, U2_d1 :  std_logic_vector(6 downto 0);
signal T4_h :  std_logic_vector(6 downto 0);
signal T3 :  std_logic_vector(55 downto 0);
signal S2, S2_d1 :  std_logic_vector(3 downto 0);
signal d3 :  std_logic;
signal T3s :  std_logic_vector(56 downto 0);
signal T3s_h :  std_logic_vector(7 downto 0);
signal T3s_l :  std_logic_vector(48 downto 0);
signal U3 :  std_logic_vector(7 downto 0);
signal T5_h :  std_logic_vector(7 downto 0);
signal T4 :  std_logic_vector(55 downto 0);
signal S3 :  std_logic_vector(4 downto 0);
signal d4, d4_d1 :  std_logic;
signal T4s :  std_logic_vector(56 downto 0);
signal T4s_h, T4s_h_d1 :  std_logic_vector(8 downto 0);
signal T4s_l, T4s_l_d1 :  std_logic_vector(47 downto 0);
signal U4, U4_d1 :  std_logic_vector(8 downto 0);
signal T6_h :  std_logic_vector(8 downto 0);
signal T5 :  std_logic_vector(55 downto 0);
signal S4, S4_d1 :  std_logic_vector(5 downto 0);
signal d5, d5_d1 :  std_logic;
signal T5s :  std_logic_vector(56 downto 0);
signal T5s_h, T5s_h_d1 :  std_logic_vector(9 downto 0);
signal T5s_l, T5s_l_d1 :  std_logic_vector(46 downto 0);
signal U5, U5_d1 :  std_logic_vector(9 downto 0);
signal T7_h :  std_logic_vector(9 downto 0);
signal T6 :  std_logic_vector(55 downto 0);
signal S5, S5_d1 :  std_logic_vector(6 downto 0);
signal d6, d6_d1 :  std_logic;
signal T6s :  std_logic_vector(56 downto 0);
signal T6s_h, T6s_h_d1 :  std_logic_vector(10 downto 0);
signal T6s_l, T6s_l_d1 :  std_logic_vector(45 downto 0);
signal U6, U6_d1 :  std_logic_vector(10 downto 0);
signal T8_h :  std_logic_vector(10 downto 0);
signal T7 :  std_logic_vector(55 downto 0);
signal S6, S6_d1 :  std_logic_vector(7 downto 0);
signal d7 :  std_logic;
signal T7s :  std_logic_vector(56 downto 0);
signal T7s_h :  std_logic_vector(11 downto 0);
signal T7s_l :  std_logic_vector(44 downto 0);
signal U7 :  std_logic_vector(11 downto 0);
signal T9_h :  std_logic_vector(11 downto 0);
signal T8 :  std_logic_vector(55 downto 0);
signal S7 :  std_logic_vector(8 downto 0);
signal d8, d8_d1 :  std_logic;
signal T8s :  std_logic_vector(56 downto 0);
signal T8s_h, T8s_h_d1 :  std_logic_vector(12 downto 0);
signal T8s_l, T8s_l_d1 :  std_logic_vector(43 downto 0);
signal U8, U8_d1 :  std_logic_vector(12 downto 0);
signal T10_h :  std_logic_vector(12 downto 0);
signal T9 :  std_logic_vector(55 downto 0);
signal S8, S8_d1 :  std_logic_vector(9 downto 0);
signal d9, d9_d1 :  std_logic;
signal T9s :  std_logic_vector(56 downto 0);
signal T9s_h, T9s_h_d1 :  std_logic_vector(13 downto 0);
signal T9s_l, T9s_l_d1 :  std_logic_vector(42 downto 0);
signal U9, U9_d1 :  std_logic_vector(13 downto 0);
signal T11_h :  std_logic_vector(13 downto 0);
signal T10 :  std_logic_vector(55 downto 0);
signal S9, S9_d1 :  std_logic_vector(10 downto 0);
signal d10, d10_d1 :  std_logic;
signal T10s :  std_logic_vector(56 downto 0);
signal T10s_h, T10s_h_d1 :  std_logic_vector(14 downto 0);
signal T10s_l, T10s_l_d1 :  std_logic_vector(41 downto 0);
signal U10, U10_d1 :  std_logic_vector(14 downto 0);
signal T12_h :  std_logic_vector(14 downto 0);
signal T11 :  std_logic_vector(55 downto 0);
signal S10, S10_d1 :  std_logic_vector(11 downto 0);
signal d11 :  std_logic;
signal T11s :  std_logic_vector(56 downto 0);
signal T11s_h :  std_logic_vector(15 downto 0);
signal T11s_l :  std_logic_vector(40 downto 0);
signal U11 :  std_logic_vector(15 downto 0);
signal T13_h :  std_logic_vector(15 downto 0);
signal T12 :  std_logic_vector(55 downto 0);
signal S11 :  std_logic_vector(12 downto 0);
signal d12, d12_d1 :  std_logic;
signal T12s :  std_logic_vector(56 downto 0);
signal T12s_h, T12s_h_d1 :  std_logic_vector(16 downto 0);
signal T12s_l, T12s_l_d1 :  std_logic_vector(39 downto 0);
signal U12, U12_d1 :  std_logic_vector(16 downto 0);
signal T14_h :  std_logic_vector(16 downto 0);
signal T13 :  std_logic_vector(55 downto 0);
signal S12, S12_d1 :  std_logic_vector(13 downto 0);
signal d13, d13_d1 :  std_logic;
signal T13s :  std_logic_vector(56 downto 0);
signal T13s_h, T13s_h_d1 :  std_logic_vector(17 downto 0);
signal T13s_l, T13s_l_d1 :  std_logic_vector(38 downto 0);
signal U13, U13_d1 :  std_logic_vector(17 downto 0);
signal T15_h :  std_logic_vector(17 downto 0);
signal T14 :  std_logic_vector(55 downto 0);
signal S13, S13_d1 :  std_logic_vector(14 downto 0);
signal d14, d14_d1 :  std_logic;
signal T14s :  std_logic_vector(56 downto 0);
signal T14s_h, T14s_h_d1 :  std_logic_vector(18 downto 0);
signal T14s_l, T14s_l_d1 :  std_logic_vector(37 downto 0);
signal U14, U14_d1 :  std_logic_vector(18 downto 0);
signal T16_h :  std_logic_vector(18 downto 0);
signal T15 :  std_logic_vector(55 downto 0);
signal S14, S14_d1 :  std_logic_vector(15 downto 0);
signal d15, d15_d1 :  std_logic;
signal T15s :  std_logic_vector(56 downto 0);
signal T15s_h, T15s_h_d1 :  std_logic_vector(19 downto 0);
signal T15s_l, T15s_l_d1 :  std_logic_vector(36 downto 0);
signal U15, U15_d1 :  std_logic_vector(19 downto 0);
signal T17_h :  std_logic_vector(19 downto 0);
signal T16 :  std_logic_vector(55 downto 0);
signal S15, S15_d1 :  std_logic_vector(16 downto 0);
signal d16, d16_d1 :  std_logic;
signal T16s :  std_logic_vector(56 downto 0);
signal T16s_h, T16s_h_d1 :  std_logic_vector(20 downto 0);
signal T16s_l, T16s_l_d1 :  std_logic_vector(35 downto 0);
signal U16, U16_d1 :  std_logic_vector(20 downto 0);
signal T18_h :  std_logic_vector(20 downto 0);
signal T17 :  std_logic_vector(55 downto 0);
signal S16, S16_d1 :  std_logic_vector(17 downto 0);
signal d17, d17_d1 :  std_logic;
signal T17s :  std_logic_vector(56 downto 0);
signal T17s_h, T17s_h_d1 :  std_logic_vector(21 downto 0);
signal T17s_l, T17s_l_d1 :  std_logic_vector(34 downto 0);
signal U17, U17_d1 :  std_logic_vector(21 downto 0);
signal T19_h :  std_logic_vector(21 downto 0);
signal T18 :  std_logic_vector(55 downto 0);
signal S17, S17_d1 :  std_logic_vector(18 downto 0);
signal d18, d18_d1 :  std_logic;
signal T18s :  std_logic_vector(56 downto 0);
signal T18s_h, T18s_h_d1 :  std_logic_vector(22 downto 0);
signal T18s_l, T18s_l_d1 :  std_logic_vector(33 downto 0);
signal U18, U18_d1 :  std_logic_vector(22 downto 0);
signal T20_h :  std_logic_vector(22 downto 0);
signal T19 :  std_logic_vector(55 downto 0);
signal S18, S18_d1 :  std_logic_vector(19 downto 0);
signal d19 :  std_logic;
signal T19s :  std_logic_vector(56 downto 0);
signal T19s_h :  std_logic_vector(23 downto 0);
signal T19s_l :  std_logic_vector(32 downto 0);
signal U19 :  std_logic_vector(23 downto 0);
signal T21_h :  std_logic_vector(23 downto 0);
signal T20 :  std_logic_vector(55 downto 0);
signal S19 :  std_logic_vector(20 downto 0);
signal d20, d20_d1 :  std_logic;
signal T20s :  std_logic_vector(56 downto 0);
signal T20s_h, T20s_h_d1 :  std_logic_vector(24 downto 0);
signal T20s_l, T20s_l_d1 :  std_logic_vector(31 downto 0);
signal U20, U20_d1 :  std_logic_vector(24 downto 0);
signal T22_h :  std_logic_vector(24 downto 0);
signal T21 :  std_logic_vector(55 downto 0);
signal S20, S20_d1 :  std_logic_vector(21 downto 0);
signal d21, d21_d1 :  std_logic;
signal T21s :  std_logic_vector(56 downto 0);
signal T21s_h, T21s_h_d1 :  std_logic_vector(25 downto 0);
signal T21s_l, T21s_l_d1 :  std_logic_vector(30 downto 0);
signal U21, U21_d1 :  std_logic_vector(25 downto 0);
signal T23_h :  std_logic_vector(25 downto 0);
signal T22 :  std_logic_vector(55 downto 0);
signal S21, S21_d1 :  std_logic_vector(22 downto 0);
signal d22, d22_d1 :  std_logic;
signal T22s :  std_logic_vector(56 downto 0);
signal T22s_h, T22s_h_d1 :  std_logic_vector(26 downto 0);
signal T22s_l, T22s_l_d1 :  std_logic_vector(29 downto 0);
signal U22, U22_d1 :  std_logic_vector(26 downto 0);
signal T24_h :  std_logic_vector(26 downto 0);
signal T23 :  std_logic_vector(55 downto 0);
signal S22, S22_d1 :  std_logic_vector(23 downto 0);
signal d23, d23_d1 :  std_logic;
signal T23s :  std_logic_vector(56 downto 0);
signal T23s_h, T23s_h_d1 :  std_logic_vector(27 downto 0);
signal T23s_l, T23s_l_d1 :  std_logic_vector(28 downto 0);
signal U23, U23_d1 :  std_logic_vector(27 downto 0);
signal T25_h :  std_logic_vector(27 downto 0);
signal T24 :  std_logic_vector(55 downto 0);
signal S23, S23_d1 :  std_logic_vector(24 downto 0);
signal d24, d24_d1 :  std_logic;
signal T24s :  std_logic_vector(56 downto 0);
signal T24s_h, T24s_h_d1 :  std_logic_vector(28 downto 0);
signal T24s_l, T24s_l_d1 :  std_logic_vector(27 downto 0);
signal U24, U24_d1 :  std_logic_vector(28 downto 0);
signal T26_h :  std_logic_vector(28 downto 0);
signal T25 :  std_logic_vector(55 downto 0);
signal S24, S24_d1 :  std_logic_vector(25 downto 0);
signal d25, d25_d1 :  std_logic;
signal T25s :  std_logic_vector(56 downto 0);
signal T25s_h, T25s_h_d1 :  std_logic_vector(29 downto 0);
signal T25s_l, T25s_l_d1 :  std_logic_vector(26 downto 0);
signal U25, U25_d1 :  std_logic_vector(29 downto 0);
signal T27_h :  std_logic_vector(29 downto 0);
signal T26 :  std_logic_vector(55 downto 0);
signal S25, S25_d1 :  std_logic_vector(26 downto 0);
signal d26, d26_d1 :  std_logic;
signal T26s :  std_logic_vector(56 downto 0);
signal T26s_h, T26s_h_d1 :  std_logic_vector(30 downto 0);
signal T26s_l, T26s_l_d1 :  std_logic_vector(25 downto 0);
signal U26, U26_d1 :  std_logic_vector(30 downto 0);
signal T28_h :  std_logic_vector(30 downto 0);
signal T27 :  std_logic_vector(55 downto 0);
signal S26, S26_d1 :  std_logic_vector(27 downto 0);
signal d27, d27_d1 :  std_logic;
signal T27s :  std_logic_vector(56 downto 0);
signal T27s_h, T27s_h_d1 :  std_logic_vector(31 downto 0);
signal T27s_l, T27s_l_d1 :  std_logic_vector(24 downto 0);
signal U27, U27_d1 :  std_logic_vector(31 downto 0);
signal T29_h :  std_logic_vector(31 downto 0);
signal T28 :  std_logic_vector(55 downto 0);
signal S27, S27_d1 :  std_logic_vector(28 downto 0);
signal d28, d28_d1 :  std_logic;
signal T28s :  std_logic_vector(56 downto 0);
signal T28s_h, T28s_h_d1 :  std_logic_vector(32 downto 0);
signal T28s_l, T28s_l_d1 :  std_logic_vector(23 downto 0);
signal U28, U28_d1 :  std_logic_vector(32 downto 0);
signal T30_h :  std_logic_vector(32 downto 0);
signal T29 :  std_logic_vector(55 downto 0);
signal S28, S28_d1 :  std_logic_vector(29 downto 0);
signal d29, d29_d1 :  std_logic;
signal T29s :  std_logic_vector(56 downto 0);
signal T29s_h, T29s_h_d1 :  std_logic_vector(33 downto 0);
signal T29s_l, T29s_l_d1 :  std_logic_vector(22 downto 0);
signal U29, U29_d1 :  std_logic_vector(33 downto 0);
signal T31_h :  std_logic_vector(33 downto 0);
signal T30 :  std_logic_vector(55 downto 0);
signal S29, S29_d1 :  std_logic_vector(30 downto 0);
signal d30, d30_d1 :  std_logic;
signal T30s :  std_logic_vector(56 downto 0);
signal T30s_h, T30s_h_d1 :  std_logic_vector(34 downto 0);
signal T30s_l, T30s_l_d1 :  std_logic_vector(21 downto 0);
signal U30, U30_d1 :  std_logic_vector(34 downto 0);
signal T32_h :  std_logic_vector(34 downto 0);
signal T31 :  std_logic_vector(55 downto 0);
signal S30, S30_d1 :  std_logic_vector(31 downto 0);
signal d31, d31_d1 :  std_logic;
signal T31s :  std_logic_vector(56 downto 0);
signal T31s_h, T31s_h_d1 :  std_logic_vector(35 downto 0);
signal T31s_l, T31s_l_d1 :  std_logic_vector(20 downto 0);
signal U31, U31_d1 :  std_logic_vector(35 downto 0);
signal T33_h :  std_logic_vector(35 downto 0);
signal T32 :  std_logic_vector(55 downto 0);
signal S31, S31_d1 :  std_logic_vector(32 downto 0);
signal d32, d32_d1, d32_d2 :  std_logic;
signal T32s :  std_logic_vector(56 downto 0);
signal T32s_h, T32s_h_d1, T32s_h_d2 :  std_logic_vector(36 downto 0);
signal T32s_l, T32s_l_d1, T32s_l_d2 :  std_logic_vector(19 downto 0);
signal U32, U32_d1, U32_d2 :  std_logic_vector(36 downto 0);
signal T34_h :  std_logic_vector(36 downto 0);
signal T33 :  std_logic_vector(55 downto 0);
signal S32, S32_d1, S32_d2 :  std_logic_vector(33 downto 0);
signal d33, d33_d1 :  std_logic;
signal T33s :  std_logic_vector(56 downto 0);
signal T33s_h, T33s_h_d1 :  std_logic_vector(37 downto 0);
signal T33s_l, T33s_l_d1 :  std_logic_vector(18 downto 0);
signal U33, U33_d1 :  std_logic_vector(37 downto 0);
signal T35_h :  std_logic_vector(37 downto 0);
signal T34 :  std_logic_vector(55 downto 0);
signal S33, S33_d1 :  std_logic_vector(34 downto 0);
signal d34, d34_d1 :  std_logic;
signal T34s :  std_logic_vector(56 downto 0);
signal T34s_h, T34s_h_d1 :  std_logic_vector(38 downto 0);
signal T34s_l, T34s_l_d1 :  std_logic_vector(17 downto 0);
signal U34, U34_d1 :  std_logic_vector(38 downto 0);
signal T36_h :  std_logic_vector(38 downto 0);
signal T35 :  std_logic_vector(55 downto 0);
signal S34, S34_d1 :  std_logic_vector(35 downto 0);
signal d35, d35_d1 :  std_logic;
signal T35s :  std_logic_vector(56 downto 0);
signal T35s_h, T35s_h_d1 :  std_logic_vector(39 downto 0);
signal T35s_l, T35s_l_d1 :  std_logic_vector(16 downto 0);
signal U35, U35_d1 :  std_logic_vector(39 downto 0);
signal T37_h :  std_logic_vector(39 downto 0);
signal T36 :  std_logic_vector(55 downto 0);
signal S35, S35_d1 :  std_logic_vector(36 downto 0);
signal d36, d36_d1 :  std_logic;
signal T36s :  std_logic_vector(56 downto 0);
signal T36s_h, T36s_h_d1 :  std_logic_vector(40 downto 0);
signal T36s_l, T36s_l_d1 :  std_logic_vector(15 downto 0);
signal U36, U36_d1 :  std_logic_vector(40 downto 0);
signal T38_h :  std_logic_vector(40 downto 0);
signal T37 :  std_logic_vector(55 downto 0);
signal S36, S36_d1 :  std_logic_vector(37 downto 0);
signal d37, d37_d1 :  std_logic;
signal T37s :  std_logic_vector(56 downto 0);
signal T37s_h, T37s_h_d1 :  std_logic_vector(41 downto 0);
signal T37s_l, T37s_l_d1 :  std_logic_vector(14 downto 0);
signal U37, U37_d1 :  std_logic_vector(41 downto 0);
signal T39_h :  std_logic_vector(41 downto 0);
signal T38 :  std_logic_vector(55 downto 0);
signal S37, S37_d1 :  std_logic_vector(38 downto 0);
signal d38, d38_d1 :  std_logic;
signal T38s :  std_logic_vector(56 downto 0);
signal T38s_h, T38s_h_d1 :  std_logic_vector(42 downto 0);
signal T38s_l, T38s_l_d1 :  std_logic_vector(13 downto 0);
signal U38, U38_d1 :  std_logic_vector(42 downto 0);
signal T40_h :  std_logic_vector(42 downto 0);
signal T39 :  std_logic_vector(55 downto 0);
signal S38, S38_d1 :  std_logic_vector(39 downto 0);
signal d39, d39_d1, d39_d2 :  std_logic;
signal T39s :  std_logic_vector(56 downto 0);
signal T39s_h, T39s_h_d1, T39s_h_d2 :  std_logic_vector(43 downto 0);
signal T39s_l, T39s_l_d1, T39s_l_d2 :  std_logic_vector(12 downto 0);
signal U39, U39_d1, U39_d2 :  std_logic_vector(43 downto 0);
signal T41_h :  std_logic_vector(43 downto 0);
signal T40 :  std_logic_vector(55 downto 0);
signal S39, S39_d1, S39_d2 :  std_logic_vector(40 downto 0);
signal d40, d40_d1 :  std_logic;
signal T40s :  std_logic_vector(56 downto 0);
signal T40s_h, T40s_h_d1 :  std_logic_vector(44 downto 0);
signal T40s_l, T40s_l_d1 :  std_logic_vector(11 downto 0);
signal U40, U40_d1 :  std_logic_vector(44 downto 0);
signal T42_h :  std_logic_vector(44 downto 0);
signal T41 :  std_logic_vector(55 downto 0);
signal S40, S40_d1 :  std_logic_vector(41 downto 0);
signal d41, d41_d1 :  std_logic;
signal T41s :  std_logic_vector(56 downto 0);
signal T41s_h, T41s_h_d1 :  std_logic_vector(45 downto 0);
signal T41s_l, T41s_l_d1 :  std_logic_vector(10 downto 0);
signal U41, U41_d1 :  std_logic_vector(45 downto 0);
signal T43_h :  std_logic_vector(45 downto 0);
signal T42 :  std_logic_vector(55 downto 0);
signal S41, S41_d1 :  std_logic_vector(42 downto 0);
signal d42, d42_d1 :  std_logic;
signal T42s :  std_logic_vector(56 downto 0);
signal T42s_h, T42s_h_d1 :  std_logic_vector(46 downto 0);
signal T42s_l, T42s_l_d1 :  std_logic_vector(9 downto 0);
signal U42, U42_d1 :  std_logic_vector(46 downto 0);
signal T44_h :  std_logic_vector(46 downto 0);
signal T43 :  std_logic_vector(55 downto 0);
signal S42, S42_d1 :  std_logic_vector(43 downto 0);
signal d43, d43_d1 :  std_logic;
signal T43s :  std_logic_vector(56 downto 0);
signal T43s_h, T43s_h_d1 :  std_logic_vector(47 downto 0);
signal T43s_l, T43s_l_d1 :  std_logic_vector(8 downto 0);
signal U43, U43_d1 :  std_logic_vector(47 downto 0);
signal T45_h :  std_logic_vector(47 downto 0);
signal T44 :  std_logic_vector(55 downto 0);
signal S43, S43_d1 :  std_logic_vector(44 downto 0);
signal d44, d44_d1, d44_d2 :  std_logic;
signal T44s :  std_logic_vector(56 downto 0);
signal T44s_h, T44s_h_d1, T44s_h_d2 :  std_logic_vector(48 downto 0);
signal T44s_l, T44s_l_d1, T44s_l_d2 :  std_logic_vector(7 downto 0);
signal U44, U44_d1, U44_d2 :  std_logic_vector(48 downto 0);
signal T46_h :  std_logic_vector(48 downto 0);
signal T45 :  std_logic_vector(55 downto 0);
signal S44, S44_d1, S44_d2 :  std_logic_vector(45 downto 0);
signal d45, d45_d1 :  std_logic;
signal T45s :  std_logic_vector(56 downto 0);
signal T45s_h, T45s_h_d1 :  std_logic_vector(49 downto 0);
signal T45s_l, T45s_l_d1 :  std_logic_vector(6 downto 0);
signal U45, U45_d1 :  std_logic_vector(49 downto 0);
signal T47_h :  std_logic_vector(49 downto 0);
signal T46 :  std_logic_vector(55 downto 0);
signal S45, S45_d1 :  std_logic_vector(46 downto 0);
signal d46, d46_d1 :  std_logic;
signal T46s :  std_logic_vector(56 downto 0);
signal T46s_h, T46s_h_d1 :  std_logic_vector(50 downto 0);
signal T46s_l, T46s_l_d1 :  std_logic_vector(5 downto 0);
signal U46, U46_d1 :  std_logic_vector(50 downto 0);
signal T48_h :  std_logic_vector(50 downto 0);
signal T47 :  std_logic_vector(55 downto 0);
signal S46, S46_d1 :  std_logic_vector(47 downto 0);
signal d47, d47_d1 :  std_logic;
signal T47s :  std_logic_vector(56 downto 0);
signal T47s_h, T47s_h_d1 :  std_logic_vector(51 downto 0);
signal T47s_l, T47s_l_d1 :  std_logic_vector(4 downto 0);
signal U47, U47_d1 :  std_logic_vector(51 downto 0);
signal T49_h :  std_logic_vector(51 downto 0);
signal T48 :  std_logic_vector(55 downto 0);
signal S47, S47_d1 :  std_logic_vector(48 downto 0);
signal d48, d48_d1, d48_d2 :  std_logic;
signal T48s :  std_logic_vector(56 downto 0);
signal T48s_h, T48s_h_d1, T48s_h_d2 :  std_logic_vector(52 downto 0);
signal T48s_l, T48s_l_d1, T48s_l_d2 :  std_logic_vector(3 downto 0);
signal U48, U48_d1, U48_d2 :  std_logic_vector(52 downto 0);
signal T50_h :  std_logic_vector(52 downto 0);
signal T49 :  std_logic_vector(55 downto 0);
signal S48, S48_d1, S48_d2 :  std_logic_vector(49 downto 0);
signal d49, d49_d1 :  std_logic;
signal T49s :  std_logic_vector(56 downto 0);
signal T49s_h, T49s_h_d1 :  std_logic_vector(53 downto 0);
signal T49s_l, T49s_l_d1 :  std_logic_vector(2 downto 0);
signal U49, U49_d1 :  std_logic_vector(53 downto 0);
signal T51_h :  std_logic_vector(53 downto 0);
signal T50 :  std_logic_vector(55 downto 0);
signal S49, S49_d1 :  std_logic_vector(50 downto 0);
signal d50, d50_d1 :  std_logic;
signal T50s :  std_logic_vector(56 downto 0);
signal T50s_h, T50s_h_d1 :  std_logic_vector(54 downto 0);
signal T50s_l, T50s_l_d1 :  std_logic_vector(1 downto 0);
signal U50, U50_d1 :  std_logic_vector(54 downto 0);
signal T52_h :  std_logic_vector(54 downto 0);
signal T51 :  std_logic_vector(55 downto 0);
signal S50, S50_d1 :  std_logic_vector(51 downto 0);
signal d51, d51_d1, d51_d2 :  std_logic;
signal T51s :  std_logic_vector(56 downto 0);
signal T51s_h, T51s_h_d1, T51s_h_d2 :  std_logic_vector(55 downto 0);
signal T51s_l, T51s_l_d1, T51s_l_d2 :  std_logic_vector(0 downto 0);
signal U51, U51_d1, U51_d2 :  std_logic_vector(55 downto 0);
signal T53_h :  std_logic_vector(55 downto 0);
signal T52 :  std_logic_vector(55 downto 0);
signal S51, S51_d1, S51_d2 :  std_logic_vector(52 downto 0);
signal d52, d52_d1 :  std_logic;
signal T52s :  std_logic_vector(56 downto 0);
signal T52s_h, T52s_h_d1 :  std_logic_vector(56 downto 0);
signal U52, U52_d1 :  std_logic_vector(56 downto 0);
signal T54_h :  std_logic_vector(56 downto 0);
signal T53 :  std_logic_vector(55 downto 0);
signal S52, S52_d1 :  std_logic_vector(53 downto 0);
signal d54 :  std_logic;
signal mR :  std_logic_vector(54 downto 0);
signal fR, fR_d1 :  std_logic_vector(51 downto 0);
signal round, round_d1 :  std_logic;
signal fRrnd :  std_logic_vector(51 downto 0);
signal Rn2 :  std_logic_vector(62 downto 0);
signal xsR, xsR_d1, xsR_d2, xsR_d3, xsR_d4, xsR_d5, xsR_d6, xsR_d7, xsR_d8, xsR_d9, xsR_d10, xsR_d11, xsR_d12, xsR_d13, xsR_d14, xsR_d15, xsR_d16, xsR_d17, xsR_d18, xsR_d19, xsR_d20, xsR_d21, xsR_d22, xsR_d23, xsR_d24, xsR_d25, xsR_d26, xsR_d27, xsR_d28, xsR_d29, xsR_d30, xsR_d31, xsR_d32, xsR_d33, xsR_d34, xsR_d35, xsR_d36, xsR_d37, xsR_d38, xsR_d39, xsR_d40, xsR_d41, xsR_d42, xsR_d43, xsR_d44, xsR_d45, xsR_d46, xsR_d47, xsR_d48, xsR_d49, xsR_d50, xsR_d51, xsR_d52, xsR_d53, xsR_d54 :  std_logic_vector(2 downto 0);
begin
   process(clk)
      begin
         if clk'event and clk = '1' then
            eRn1_d1 <=  eRn1;
            eRn1_d2 <=  eRn1_d1;
            eRn1_d3 <=  eRn1_d2;
            eRn1_d4 <=  eRn1_d3;
            eRn1_d5 <=  eRn1_d4;
            eRn1_d6 <=  eRn1_d5;
            eRn1_d7 <=  eRn1_d6;
            eRn1_d8 <=  eRn1_d7;
            eRn1_d9 <=  eRn1_d8;
            eRn1_d10 <=  eRn1_d9;
            eRn1_d11 <=  eRn1_d10;
            eRn1_d12 <=  eRn1_d11;
            eRn1_d13 <=  eRn1_d12;
            eRn1_d14 <=  eRn1_d13;
            eRn1_d15 <=  eRn1_d14;
            eRn1_d16 <=  eRn1_d15;
            eRn1_d17 <=  eRn1_d16;
            eRn1_d18 <=  eRn1_d17;
            eRn1_d19 <=  eRn1_d18;
            eRn1_d20 <=  eRn1_d19;
            eRn1_d21 <=  eRn1_d20;
            eRn1_d22 <=  eRn1_d21;
            eRn1_d23 <=  eRn1_d22;
            eRn1_d24 <=  eRn1_d23;
            eRn1_d25 <=  eRn1_d24;
            eRn1_d26 <=  eRn1_d25;
            eRn1_d27 <=  eRn1_d26;
            eRn1_d28 <=  eRn1_d27;
            eRn1_d29 <=  eRn1_d28;
            eRn1_d30 <=  eRn1_d29;
            eRn1_d31 <=  eRn1_d30;
            eRn1_d32 <=  eRn1_d31;
            eRn1_d33 <=  eRn1_d32;
            eRn1_d34 <=  eRn1_d33;
            eRn1_d35 <=  eRn1_d34;
            eRn1_d36 <=  eRn1_d35;
            eRn1_d37 <=  eRn1_d36;
            eRn1_d38 <=  eRn1_d37;
            eRn1_d39 <=  eRn1_d38;
            eRn1_d40 <=  eRn1_d39;
            eRn1_d41 <=  eRn1_d40;
            eRn1_d42 <=  eRn1_d41;
            eRn1_d43 <=  eRn1_d42;
            eRn1_d44 <=  eRn1_d43;
            eRn1_d45 <=  eRn1_d44;
            eRn1_d46 <=  eRn1_d45;
            eRn1_d47 <=  eRn1_d46;
            eRn1_d48 <=  eRn1_d47;
            eRn1_d49 <=  eRn1_d48;
            eRn1_d50 <=  eRn1_d49;
            eRn1_d51 <=  eRn1_d50;
            eRn1_d52 <=  eRn1_d51;
            eRn1_d53 <=  eRn1_d52;
            eRn1_d54 <=  eRn1_d53;
            d1_d1 <=  d1;
            T1s_h_d1 <=  T1s_h;
            T1s_l_d1 <=  T1s_l;
            U1_d1 <=  U1;
            S1_d1 <=  S1;
            d2_d1 <=  d2;
            T2s_h_d1 <=  T2s_h;
            T2s_l_d1 <=  T2s_l;
            U2_d1 <=  U2;
            S2_d1 <=  S2;
            d4_d1 <=  d4;
            T4s_h_d1 <=  T4s_h;
            T4s_l_d1 <=  T4s_l;
            U4_d1 <=  U4;
            S4_d1 <=  S4;
            d5_d1 <=  d5;
            T5s_h_d1 <=  T5s_h;
            T5s_l_d1 <=  T5s_l;
            U5_d1 <=  U5;
            S5_d1 <=  S5;
            d6_d1 <=  d6;
            T6s_h_d1 <=  T6s_h;
            T6s_l_d1 <=  T6s_l;
            U6_d1 <=  U6;
            S6_d1 <=  S6;
            d8_d1 <=  d8;
            T8s_h_d1 <=  T8s_h;
            T8s_l_d1 <=  T8s_l;
            U8_d1 <=  U8;
            S8_d1 <=  S8;
            d9_d1 <=  d9;
            T9s_h_d1 <=  T9s_h;
            T9s_l_d1 <=  T9s_l;
            U9_d1 <=  U9;
            S9_d1 <=  S9;
            d10_d1 <=  d10;
            T10s_h_d1 <=  T10s_h;
            T10s_l_d1 <=  T10s_l;
            U10_d1 <=  U10;
            S10_d1 <=  S10;
            d12_d1 <=  d12;
            T12s_h_d1 <=  T12s_h;
            T12s_l_d1 <=  T12s_l;
            U12_d1 <=  U12;
            S12_d1 <=  S12;
            d13_d1 <=  d13;
            T13s_h_d1 <=  T13s_h;
            T13s_l_d1 <=  T13s_l;
            U13_d1 <=  U13;
            S13_d1 <=  S13;
            d14_d1 <=  d14;
            T14s_h_d1 <=  T14s_h;
            T14s_l_d1 <=  T14s_l;
            U14_d1 <=  U14;
            S14_d1 <=  S14;
            d15_d1 <=  d15;
            T15s_h_d1 <=  T15s_h;
            T15s_l_d1 <=  T15s_l;
            U15_d1 <=  U15;
            S15_d1 <=  S15;
            d16_d1 <=  d16;
            T16s_h_d1 <=  T16s_h;
            T16s_l_d1 <=  T16s_l;
            U16_d1 <=  U16;
            S16_d1 <=  S16;
            d17_d1 <=  d17;
            T17s_h_d1 <=  T17s_h;
            T17s_l_d1 <=  T17s_l;
            U17_d1 <=  U17;
            S17_d1 <=  S17;
            d18_d1 <=  d18;
            T18s_h_d1 <=  T18s_h;
            T18s_l_d1 <=  T18s_l;
            U18_d1 <=  U18;
            S18_d1 <=  S18;
            d20_d1 <=  d20;
            T20s_h_d1 <=  T20s_h;
            T20s_l_d1 <=  T20s_l;
            U20_d1 <=  U20;
            S20_d1 <=  S20;
            d21_d1 <=  d21;
            T21s_h_d1 <=  T21s_h;
            T21s_l_d1 <=  T21s_l;
            U21_d1 <=  U21;
            S21_d1 <=  S21;
            d22_d1 <=  d22;
            T22s_h_d1 <=  T22s_h;
            T22s_l_d1 <=  T22s_l;
            U22_d1 <=  U22;
            S22_d1 <=  S22;
            d23_d1 <=  d23;
            T23s_h_d1 <=  T23s_h;
            T23s_l_d1 <=  T23s_l;
            U23_d1 <=  U23;
            S23_d1 <=  S23;
            d24_d1 <=  d24;
            T24s_h_d1 <=  T24s_h;
            T24s_l_d1 <=  T24s_l;
            U24_d1 <=  U24;
            S24_d1 <=  S24;
            d25_d1 <=  d25;
            T25s_h_d1 <=  T25s_h;
            T25s_l_d1 <=  T25s_l;
            U25_d1 <=  U25;
            S25_d1 <=  S25;
            d26_d1 <=  d26;
            T26s_h_d1 <=  T26s_h;
            T26s_l_d1 <=  T26s_l;
            U26_d1 <=  U26;
            S26_d1 <=  S26;
            d27_d1 <=  d27;
            T27s_h_d1 <=  T27s_h;
            T27s_l_d1 <=  T27s_l;
            U27_d1 <=  U27;
            S27_d1 <=  S27;
            d28_d1 <=  d28;
            T28s_h_d1 <=  T28s_h;
            T28s_l_d1 <=  T28s_l;
            U28_d1 <=  U28;
            S28_d1 <=  S28;
            d29_d1 <=  d29;
            T29s_h_d1 <=  T29s_h;
            T29s_l_d1 <=  T29s_l;
            U29_d1 <=  U29;
            S29_d1 <=  S29;
            d30_d1 <=  d30;
            T30s_h_d1 <=  T30s_h;
            T30s_l_d1 <=  T30s_l;
            U30_d1 <=  U30;
            S30_d1 <=  S30;
            d31_d1 <=  d31;
            T31s_h_d1 <=  T31s_h;
            T31s_l_d1 <=  T31s_l;
            U31_d1 <=  U31;
            S31_d1 <=  S31;
            d32_d1 <=  d32;
            d32_d2 <=  d32_d1;
            T32s_h_d1 <=  T32s_h;
            T32s_h_d2 <=  T32s_h_d1;
            T32s_l_d1 <=  T32s_l;
            T32s_l_d2 <=  T32s_l_d1;
            U32_d1 <=  U32;
            U32_d2 <=  U32_d1;
            S32_d1 <=  S32;
            S32_d2 <=  S32_d1;
            d33_d1 <=  d33;
            T33s_h_d1 <=  T33s_h;
            T33s_l_d1 <=  T33s_l;
            U33_d1 <=  U33;
            S33_d1 <=  S33;
            d34_d1 <=  d34;
            T34s_h_d1 <=  T34s_h;
            T34s_l_d1 <=  T34s_l;
            U34_d1 <=  U34;
            S34_d1 <=  S34;
            d35_d1 <=  d35;
            T35s_h_d1 <=  T35s_h;
            T35s_l_d1 <=  T35s_l;
            U35_d1 <=  U35;
            S35_d1 <=  S35;
            d36_d1 <=  d36;
            T36s_h_d1 <=  T36s_h;
            T36s_l_d1 <=  T36s_l;
            U36_d1 <=  U36;
            S36_d1 <=  S36;
            d37_d1 <=  d37;
            T37s_h_d1 <=  T37s_h;
            T37s_l_d1 <=  T37s_l;
            U37_d1 <=  U37;
            S37_d1 <=  S37;
            d38_d1 <=  d38;
            T38s_h_d1 <=  T38s_h;
            T38s_l_d1 <=  T38s_l;
            U38_d1 <=  U38;
            S38_d1 <=  S38;
            d39_d1 <=  d39;
            d39_d2 <=  d39_d1;
            T39s_h_d1 <=  T39s_h;
            T39s_h_d2 <=  T39s_h_d1;
            T39s_l_d1 <=  T39s_l;
            T39s_l_d2 <=  T39s_l_d1;
            U39_d1 <=  U39;
            U39_d2 <=  U39_d1;
            S39_d1 <=  S39;
            S39_d2 <=  S39_d1;
            d40_d1 <=  d40;
            T40s_h_d1 <=  T40s_h;
            T40s_l_d1 <=  T40s_l;
            U40_d1 <=  U40;
            S40_d1 <=  S40;
            d41_d1 <=  d41;
            T41s_h_d1 <=  T41s_h;
            T41s_l_d1 <=  T41s_l;
            U41_d1 <=  U41;
            S41_d1 <=  S41;
            d42_d1 <=  d42;
            T42s_h_d1 <=  T42s_h;
            T42s_l_d1 <=  T42s_l;
            U42_d1 <=  U42;
            S42_d1 <=  S42;
            d43_d1 <=  d43;
            T43s_h_d1 <=  T43s_h;
            T43s_l_d1 <=  T43s_l;
            U43_d1 <=  U43;
            S43_d1 <=  S43;
            d44_d1 <=  d44;
            d44_d2 <=  d44_d1;
            T44s_h_d1 <=  T44s_h;
            T44s_h_d2 <=  T44s_h_d1;
            T44s_l_d1 <=  T44s_l;
            T44s_l_d2 <=  T44s_l_d1;
            U44_d1 <=  U44;
            U44_d2 <=  U44_d1;
            S44_d1 <=  S44;
            S44_d2 <=  S44_d1;
            d45_d1 <=  d45;
            T45s_h_d1 <=  T45s_h;
            T45s_l_d1 <=  T45s_l;
            U45_d1 <=  U45;
            S45_d1 <=  S45;
            d46_d1 <=  d46;
            T46s_h_d1 <=  T46s_h;
            T46s_l_d1 <=  T46s_l;
            U46_d1 <=  U46;
            S46_d1 <=  S46;
            d47_d1 <=  d47;
            T47s_h_d1 <=  T47s_h;
            T47s_l_d1 <=  T47s_l;
            U47_d1 <=  U47;
            S47_d1 <=  S47;
            d48_d1 <=  d48;
            d48_d2 <=  d48_d1;
            T48s_h_d1 <=  T48s_h;
            T48s_h_d2 <=  T48s_h_d1;
            T48s_l_d1 <=  T48s_l;
            T48s_l_d2 <=  T48s_l_d1;
            U48_d1 <=  U48;
            U48_d2 <=  U48_d1;
            S48_d1 <=  S48;
            S48_d2 <=  S48_d1;
            d49_d1 <=  d49;
            T49s_h_d1 <=  T49s_h;
            T49s_l_d1 <=  T49s_l;
            U49_d1 <=  U49;
            S49_d1 <=  S49;
            d50_d1 <=  d50;
            T50s_h_d1 <=  T50s_h;
            T50s_l_d1 <=  T50s_l;
            U50_d1 <=  U50;
            S50_d1 <=  S50;
            d51_d1 <=  d51;
            d51_d2 <=  d51_d1;
            T51s_h_d1 <=  T51s_h;
            T51s_h_d2 <=  T51s_h_d1;
            T51s_l_d1 <=  T51s_l;
            T51s_l_d2 <=  T51s_l_d1;
            U51_d1 <=  U51;
            U51_d2 <=  U51_d1;
            S51_d1 <=  S51;
            S51_d2 <=  S51_d1;
            d52_d1 <=  d52;
            T52s_h_d1 <=  T52s_h;
            U52_d1 <=  U52;
            S52_d1 <=  S52;
            fR_d1 <=  fR;
            round_d1 <=  round;
            xsR_d1 <=  xsR;
            xsR_d2 <=  xsR_d1;
            xsR_d3 <=  xsR_d2;
            xsR_d4 <=  xsR_d3;
            xsR_d5 <=  xsR_d4;
            xsR_d6 <=  xsR_d5;
            xsR_d7 <=  xsR_d6;
            xsR_d8 <=  xsR_d7;
            xsR_d9 <=  xsR_d8;
            xsR_d10 <=  xsR_d9;
            xsR_d11 <=  xsR_d10;
            xsR_d12 <=  xsR_d11;
            xsR_d13 <=  xsR_d12;
            xsR_d14 <=  xsR_d13;
            xsR_d15 <=  xsR_d14;
            xsR_d16 <=  xsR_d15;
            xsR_d17 <=  xsR_d16;
            xsR_d18 <=  xsR_d17;
            xsR_d19 <=  xsR_d18;
            xsR_d20 <=  xsR_d19;
            xsR_d21 <=  xsR_d20;
            xsR_d22 <=  xsR_d21;
            xsR_d23 <=  xsR_d22;
            xsR_d24 <=  xsR_d23;
            xsR_d25 <=  xsR_d24;
            xsR_d26 <=  xsR_d25;
            xsR_d27 <=  xsR_d26;
            xsR_d28 <=  xsR_d27;
            xsR_d29 <=  xsR_d28;
            xsR_d30 <=  xsR_d29;
            xsR_d31 <=  xsR_d30;
            xsR_d32 <=  xsR_d31;
            xsR_d33 <=  xsR_d32;
            xsR_d34 <=  xsR_d33;
            xsR_d35 <=  xsR_d34;
            xsR_d36 <=  xsR_d35;
            xsR_d37 <=  xsR_d36;
            xsR_d38 <=  xsR_d37;
            xsR_d39 <=  xsR_d38;
            xsR_d40 <=  xsR_d39;
            xsR_d41 <=  xsR_d40;
            xsR_d42 <=  xsR_d41;
            xsR_d43 <=  xsR_d42;
            xsR_d44 <=  xsR_d43;
            xsR_d45 <=  xsR_d44;
            xsR_d46 <=  xsR_d45;
            xsR_d47 <=  xsR_d46;
            xsR_d48 <=  xsR_d47;
            xsR_d49 <=  xsR_d48;
            xsR_d50 <=  xsR_d49;
            xsR_d51 <=  xsR_d50;
            xsR_d52 <=  xsR_d51;
            xsR_d53 <=  xsR_d52;
            xsR_d54 <=  xsR_d53;
         end if;
      end process;
   fracX <= X(51 downto 0); -- fraction
   eRn0 <= "0" & X(62 downto 53); -- exponent
   xsX <= X(65 downto 63); -- exception and sign
   eRn1 <= eRn0 + ("00" & (8 downto 0 => '1')) + X(52);
   fracXnorm <= "1" & fracX & "000" when X(52) = '0' else
         "01" & fracX&"00"; -- pre-normalization
   S0 <= "01";
   T1 <= ("0111" + fracXnorm(55 downto 52)) & fracXnorm(51 downto 0);
   -- now implementing the recurrence 
   --  this is a binary non-restoring algorithm, see ASA book
   -- Step 2
   d1 <= not T1(55); --  bit of weight -1
   T1s <= T1 & "0";
   T1s_h <= T1s(56 downto 51);
   T1s_l <= T1s(50 downto 0);
   U1 <=  "0" & S0 & d1 & (not d1) & "1"; 
   T3_h <=   T1s_h_d1 - U1_d1 when d1_d1='1'
        else T1s_h_d1 + U1_d1;
   T2 <= T3_h(4 downto 0) & T1s_l_d1;
   S1 <= S0 & d1; -- here -1 becomes 0 and 1 becomes 1
   -- Step 3
   d2 <= not T2(55); --  bit of weight -2
   T2s <= T2 & "0";
   T2s_h <= T2s(56 downto 50);
   T2s_l <= T2s(49 downto 0);
   U2 <=  "0" & S1_d1 & d2 & (not d2) & "1"; 
   T4_h <=   T2s_h_d1 - U2_d1 when d2_d1='1'
        else T2s_h_d1 + U2_d1;
   T3 <= T4_h(5 downto 0) & T2s_l_d1;
   S2 <= S1_d1 & d2; -- here -1 becomes 0 and 1 becomes 1
   -- Step 4
   d3 <= not T3(55); --  bit of weight -3
   T3s <= T3 & "0";
   T3s_h <= T3s(56 downto 49);
   T3s_l <= T3s(48 downto 0);
   U3 <=  "0" & S2_d1 & d3 & (not d3) & "1"; 
   T5_h <=   T3s_h - U3 when d3='1'
        else T3s_h + U3;
   T4 <= T5_h(6 downto 0) & T3s_l;
   S3 <= S2_d1 & d3; -- here -1 becomes 0 and 1 becomes 1
   -- Step 5
   d4 <= not T4(55); --  bit of weight -4
   T4s <= T4 & "0";
   T4s_h <= T4s(56 downto 48);
   T4s_l <= T4s(47 downto 0);
   U4 <=  "0" & S3 & d4 & (not d4) & "1"; 
   T6_h <=   T4s_h_d1 - U4_d1 when d4_d1='1'
        else T4s_h_d1 + U4_d1;
   T5 <= T6_h(7 downto 0) & T4s_l_d1;
   S4 <= S3 & d4; -- here -1 becomes 0 and 1 becomes 1
   -- Step 6
   d5 <= not T5(55); --  bit of weight -5
   T5s <= T5 & "0";
   T5s_h <= T5s(56 downto 47);
   T5s_l <= T5s(46 downto 0);
   U5 <=  "0" & S4_d1 & d5 & (not d5) & "1"; 
   T7_h <=   T5s_h_d1 - U5_d1 when d5_d1='1'
        else T5s_h_d1 + U5_d1;
   T6 <= T7_h(8 downto 0) & T5s_l_d1;
   S5 <= S4_d1 & d5; -- here -1 becomes 0 and 1 becomes 1
   -- Step 7
   d6 <= not T6(55); --  bit of weight -6
   T6s <= T6 & "0";
   T6s_h <= T6s(56 downto 46);
   T6s_l <= T6s(45 downto 0);
   U6 <=  "0" & S5_d1 & d6 & (not d6) & "1"; 
   T8_h <=   T6s_h_d1 - U6_d1 when d6_d1='1'
        else T6s_h_d1 + U6_d1;
   T7 <= T8_h(9 downto 0) & T6s_l_d1;
   S6 <= S5_d1 & d6; -- here -1 becomes 0 and 1 becomes 1
   -- Step 8
   d7 <= not T7(55); --  bit of weight -7
   T7s <= T7 & "0";
   T7s_h <= T7s(56 downto 45);
   T7s_l <= T7s(44 downto 0);
   U7 <=  "0" & S6_d1 & d7 & (not d7) & "1"; 
   T9_h <=   T7s_h - U7 when d7='1'
        else T7s_h + U7;
   T8 <= T9_h(10 downto 0) & T7s_l;
   S7 <= S6_d1 & d7; -- here -1 becomes 0 and 1 becomes 1
   -- Step 9
   d8 <= not T8(55); --  bit of weight -8
   T8s <= T8 & "0";
   T8s_h <= T8s(56 downto 44);
   T8s_l <= T8s(43 downto 0);
   U8 <=  "0" & S7 & d8 & (not d8) & "1"; 
   T10_h <=   T8s_h_d1 - U8_d1 when d8_d1='1'
        else T8s_h_d1 + U8_d1;
   T9 <= T10_h(11 downto 0) & T8s_l_d1;
   S8 <= S7 & d8; -- here -1 becomes 0 and 1 becomes 1
   -- Step 10
   d9 <= not T9(55); --  bit of weight -9
   T9s <= T9 & "0";
   T9s_h <= T9s(56 downto 43);
   T9s_l <= T9s(42 downto 0);
   U9 <=  "0" & S8_d1 & d9 & (not d9) & "1"; 
   T11_h <=   T9s_h_d1 - U9_d1 when d9_d1='1'
        else T9s_h_d1 + U9_d1;
   T10 <= T11_h(12 downto 0) & T9s_l_d1;
   S9 <= S8_d1 & d9; -- here -1 becomes 0 and 1 becomes 1
   -- Step 11
   d10 <= not T10(55); --  bit of weight -10
   T10s <= T10 & "0";
   T10s_h <= T10s(56 downto 42);
   T10s_l <= T10s(41 downto 0);
   U10 <=  "0" & S9_d1 & d10 & (not d10) & "1"; 
   T12_h <=   T10s_h_d1 - U10_d1 when d10_d1='1'
        else T10s_h_d1 + U10_d1;
   T11 <= T12_h(13 downto 0) & T10s_l_d1;
   S10 <= S9_d1 & d10; -- here -1 becomes 0 and 1 becomes 1
   -- Step 12
   d11 <= not T11(55); --  bit of weight -11
   T11s <= T11 & "0";
   T11s_h <= T11s(56 downto 41);
   T11s_l <= T11s(40 downto 0);
   U11 <=  "0" & S10_d1 & d11 & (not d11) & "1"; 
   T13_h <=   T11s_h - U11 when d11='1'
        else T11s_h + U11;
   T12 <= T13_h(14 downto 0) & T11s_l;
   S11 <= S10_d1 & d11; -- here -1 becomes 0 and 1 becomes 1
   -- Step 13
   d12 <= not T12(55); --  bit of weight -12
   T12s <= T12 & "0";
   T12s_h <= T12s(56 downto 40);
   T12s_l <= T12s(39 downto 0);
   U12 <=  "0" & S11 & d12 & (not d12) & "1"; 
   T14_h <=   T12s_h_d1 - U12_d1 when d12_d1='1'
        else T12s_h_d1 + U12_d1;
   T13 <= T14_h(15 downto 0) & T12s_l_d1;
   S12 <= S11 & d12; -- here -1 becomes 0 and 1 becomes 1
   -- Step 14
   d13 <= not T13(55); --  bit of weight -13
   T13s <= T13 & "0";
   T13s_h <= T13s(56 downto 39);
   T13s_l <= T13s(38 downto 0);
   U13 <=  "0" & S12_d1 & d13 & (not d13) & "1"; 
   T15_h <=   T13s_h_d1 - U13_d1 when d13_d1='1'
        else T13s_h_d1 + U13_d1;
   T14 <= T15_h(16 downto 0) & T13s_l_d1;
   S13 <= S12_d1 & d13; -- here -1 becomes 0 and 1 becomes 1
   -- Step 15
   d14 <= not T14(55); --  bit of weight -14
   T14s <= T14 & "0";
   T14s_h <= T14s(56 downto 38);
   T14s_l <= T14s(37 downto 0);
   U14 <=  "0" & S13_d1 & d14 & (not d14) & "1"; 
   T16_h <=   T14s_h_d1 - U14_d1 when d14_d1='1'
        else T14s_h_d1 + U14_d1;
   T15 <= T16_h(17 downto 0) & T14s_l_d1;
   S14 <= S13_d1 & d14; -- here -1 becomes 0 and 1 becomes 1
   -- Step 16
   d15 <= not T15(55); --  bit of weight -15
   T15s <= T15 & "0";
   T15s_h <= T15s(56 downto 37);
   T15s_l <= T15s(36 downto 0);
   U15 <=  "0" & S14_d1 & d15 & (not d15) & "1"; 
   T17_h <=   T15s_h_d1 - U15_d1 when d15_d1='1'
        else T15s_h_d1 + U15_d1;
   T16 <= T17_h(18 downto 0) & T15s_l_d1;
   S15 <= S14_d1 & d15; -- here -1 becomes 0 and 1 becomes 1
   -- Step 17
   d16 <= not T16(55); --  bit of weight -16
   T16s <= T16 & "0";
   T16s_h <= T16s(56 downto 36);
   T16s_l <= T16s(35 downto 0);
   U16 <=  "0" & S15_d1 & d16 & (not d16) & "1"; 
   T18_h <=   T16s_h_d1 - U16_d1 when d16_d1='1'
        else T16s_h_d1 + U16_d1;
   T17 <= T18_h(19 downto 0) & T16s_l_d1;
   S16 <= S15_d1 & d16; -- here -1 becomes 0 and 1 becomes 1
   -- Step 18
   d17 <= not T17(55); --  bit of weight -17
   T17s <= T17 & "0";
   T17s_h <= T17s(56 downto 35);
   T17s_l <= T17s(34 downto 0);
   U17 <=  "0" & S16_d1 & d17 & (not d17) & "1"; 
   T19_h <=   T17s_h_d1 - U17_d1 when d17_d1='1'
        else T17s_h_d1 + U17_d1;
   T18 <= T19_h(20 downto 0) & T17s_l_d1;
   S17 <= S16_d1 & d17; -- here -1 becomes 0 and 1 becomes 1
   -- Step 19
   d18 <= not T18(55); --  bit of weight -18
   T18s <= T18 & "0";
   T18s_h <= T18s(56 downto 34);
   T18s_l <= T18s(33 downto 0);
   U18 <=  "0" & S17_d1 & d18 & (not d18) & "1"; 
   T20_h <=   T18s_h_d1 - U18_d1 when d18_d1='1'
        else T18s_h_d1 + U18_d1;
   T19 <= T20_h(21 downto 0) & T18s_l_d1;
   S18 <= S17_d1 & d18; -- here -1 becomes 0 and 1 becomes 1
   -- Step 20
   d19 <= not T19(55); --  bit of weight -19
   T19s <= T19 & "0";
   T19s_h <= T19s(56 downto 33);
   T19s_l <= T19s(32 downto 0);
   U19 <=  "0" & S18_d1 & d19 & (not d19) & "1"; 
   T21_h <=   T19s_h - U19 when d19='1'
        else T19s_h + U19;
   T20 <= T21_h(22 downto 0) & T19s_l;
   S19 <= S18_d1 & d19; -- here -1 becomes 0 and 1 becomes 1
   -- Step 21
   d20 <= not T20(55); --  bit of weight -20
   T20s <= T20 & "0";
   T20s_h <= T20s(56 downto 32);
   T20s_l <= T20s(31 downto 0);
   U20 <=  "0" & S19 & d20 & (not d20) & "1"; 
   T22_h <=   T20s_h_d1 - U20_d1 when d20_d1='1'
        else T20s_h_d1 + U20_d1;
   T21 <= T22_h(23 downto 0) & T20s_l_d1;
   S20 <= S19 & d20; -- here -1 becomes 0 and 1 becomes 1
   -- Step 22
   d21 <= not T21(55); --  bit of weight -21
   T21s <= T21 & "0";
   T21s_h <= T21s(56 downto 31);
   T21s_l <= T21s(30 downto 0);
   U21 <=  "0" & S20_d1 & d21 & (not d21) & "1"; 
   T23_h <=   T21s_h_d1 - U21_d1 when d21_d1='1'
        else T21s_h_d1 + U21_d1;
   T22 <= T23_h(24 downto 0) & T21s_l_d1;
   S21 <= S20_d1 & d21; -- here -1 becomes 0 and 1 becomes 1
   -- Step 23
   d22 <= not T22(55); --  bit of weight -22
   T22s <= T22 & "0";
   T22s_h <= T22s(56 downto 30);
   T22s_l <= T22s(29 downto 0);
   U22 <=  "0" & S21_d1 & d22 & (not d22) & "1"; 
   T24_h <=   T22s_h_d1 - U22_d1 when d22_d1='1'
        else T22s_h_d1 + U22_d1;
   T23 <= T24_h(25 downto 0) & T22s_l_d1;
   S22 <= S21_d1 & d22; -- here -1 becomes 0 and 1 becomes 1
   -- Step 24
   d23 <= not T23(55); --  bit of weight -23
   T23s <= T23 & "0";
   T23s_h <= T23s(56 downto 29);
   T23s_l <= T23s(28 downto 0);
   U23 <=  "0" & S22_d1 & d23 & (not d23) & "1"; 
   T25_h <=   T23s_h_d1 - U23_d1 when d23_d1='1'
        else T23s_h_d1 + U23_d1;
   T24 <= T25_h(26 downto 0) & T23s_l_d1;
   S23 <= S22_d1 & d23; -- here -1 becomes 0 and 1 becomes 1
   -- Step 25
   d24 <= not T24(55); --  bit of weight -24
   T24s <= T24 & "0";
   T24s_h <= T24s(56 downto 28);
   T24s_l <= T24s(27 downto 0);
   U24 <=  "0" & S23_d1 & d24 & (not d24) & "1"; 
   T26_h <=   T24s_h_d1 - U24_d1 when d24_d1='1'
        else T24s_h_d1 + U24_d1;
   T25 <= T26_h(27 downto 0) & T24s_l_d1;
   S24 <= S23_d1 & d24; -- here -1 becomes 0 and 1 becomes 1
   -- Step 26
   d25 <= not T25(55); --  bit of weight -25
   T25s <= T25 & "0";
   T25s_h <= T25s(56 downto 27);
   T25s_l <= T25s(26 downto 0);
   U25 <=  "0" & S24_d1 & d25 & (not d25) & "1"; 
   T27_h <=   T25s_h_d1 - U25_d1 when d25_d1='1'
        else T25s_h_d1 + U25_d1;
   T26 <= T27_h(28 downto 0) & T25s_l_d1;
   S25 <= S24_d1 & d25; -- here -1 becomes 0 and 1 becomes 1
   -- Step 27
   d26 <= not T26(55); --  bit of weight -26
   T26s <= T26 & "0";
   T26s_h <= T26s(56 downto 26);
   T26s_l <= T26s(25 downto 0);
   U26 <=  "0" & S25_d1 & d26 & (not d26) & "1"; 
   T28_h <=   T26s_h_d1 - U26_d1 when d26_d1='1'
        else T26s_h_d1 + U26_d1;
   T27 <= T28_h(29 downto 0) & T26s_l_d1;
   S26 <= S25_d1 & d26; -- here -1 becomes 0 and 1 becomes 1
   -- Step 28
   d27 <= not T27(55); --  bit of weight -27
   T27s <= T27 & "0";
   T27s_h <= T27s(56 downto 25);
   T27s_l <= T27s(24 downto 0);
   U27 <=  "0" & S26_d1 & d27 & (not d27) & "1"; 
   T29_h <=   T27s_h_d1 - U27_d1 when d27_d1='1'
        else T27s_h_d1 + U27_d1;
   T28 <= T29_h(30 downto 0) & T27s_l_d1;
   S27 <= S26_d1 & d27; -- here -1 becomes 0 and 1 becomes 1
   -- Step 29
   d28 <= not T28(55); --  bit of weight -28
   T28s <= T28 & "0";
   T28s_h <= T28s(56 downto 24);
   T28s_l <= T28s(23 downto 0);
   U28 <=  "0" & S27_d1 & d28 & (not d28) & "1"; 
   T30_h <=   T28s_h_d1 - U28_d1 when d28_d1='1'
        else T28s_h_d1 + U28_d1;
   T29 <= T30_h(31 downto 0) & T28s_l_d1;
   S28 <= S27_d1 & d28; -- here -1 becomes 0 and 1 becomes 1
   -- Step 30
   d29 <= not T29(55); --  bit of weight -29
   T29s <= T29 & "0";
   T29s_h <= T29s(56 downto 23);
   T29s_l <= T29s(22 downto 0);
   U29 <=  "0" & S28_d1 & d29 & (not d29) & "1"; 
   T31_h <=   T29s_h_d1 - U29_d1 when d29_d1='1'
        else T29s_h_d1 + U29_d1;
   T30 <= T31_h(32 downto 0) & T29s_l_d1;
   S29 <= S28_d1 & d29; -- here -1 becomes 0 and 1 becomes 1
   -- Step 31
   d30 <= not T30(55); --  bit of weight -30
   T30s <= T30 & "0";
   T30s_h <= T30s(56 downto 22);
   T30s_l <= T30s(21 downto 0);
   U30 <=  "0" & S29_d1 & d30 & (not d30) & "1"; 
   T32_h <=   T30s_h_d1 - U30_d1 when d30_d1='1'
        else T30s_h_d1 + U30_d1;
   T31 <= T32_h(33 downto 0) & T30s_l_d1;
   S30 <= S29_d1 & d30; -- here -1 becomes 0 and 1 becomes 1
   -- Step 32
   d31 <= not T31(55); --  bit of weight -31
   T31s <= T31 & "0";
   T31s_h <= T31s(56 downto 21);
   T31s_l <= T31s(20 downto 0);
   U31 <=  "0" & S30_d1 & d31 & (not d31) & "1"; 
   T33_h <=   T31s_h_d1 - U31_d1 when d31_d1='1'
        else T31s_h_d1 + U31_d1;
   T32 <= T33_h(34 downto 0) & T31s_l_d1;
   S31 <= S30_d1 & d31; -- here -1 becomes 0 and 1 becomes 1
   -- Step 33
   d32 <= not T32(55); --  bit of weight -32
   T32s <= T32 & "0";
   T32s_h <= T32s(56 downto 20);
   T32s_l <= T32s(19 downto 0);
   U32 <=  "0" & S31_d1 & d32 & (not d32) & "1"; 
   T34_h <=   T32s_h_d2 - U32_d2 when d32_d2='1'
        else T32s_h_d2 + U32_d2;
   T33 <= T34_h(35 downto 0) & T32s_l_d2;
   S32 <= S31_d1 & d32; -- here -1 becomes 0 and 1 becomes 1
   -- Step 34
   d33 <= not T33(55); --  bit of weight -33
   T33s <= T33 & "0";
   T33s_h <= T33s(56 downto 19);
   T33s_l <= T33s(18 downto 0);
   U33 <=  "0" & S32_d2 & d33 & (not d33) & "1"; 
   T35_h <=   T33s_h_d1 - U33_d1 when d33_d1='1'
        else T33s_h_d1 + U33_d1;
   T34 <= T35_h(36 downto 0) & T33s_l_d1;
   S33 <= S32_d2 & d33; -- here -1 becomes 0 and 1 becomes 1
   -- Step 35
   d34 <= not T34(55); --  bit of weight -34
   T34s <= T34 & "0";
   T34s_h <= T34s(56 downto 18);
   T34s_l <= T34s(17 downto 0);
   U34 <=  "0" & S33_d1 & d34 & (not d34) & "1"; 
   T36_h <=   T34s_h_d1 - U34_d1 when d34_d1='1'
        else T34s_h_d1 + U34_d1;
   T35 <= T36_h(37 downto 0) & T34s_l_d1;
   S34 <= S33_d1 & d34; -- here -1 becomes 0 and 1 becomes 1
   -- Step 36
   d35 <= not T35(55); --  bit of weight -35
   T35s <= T35 & "0";
   T35s_h <= T35s(56 downto 17);
   T35s_l <= T35s(16 downto 0);
   U35 <=  "0" & S34_d1 & d35 & (not d35) & "1"; 
   T37_h <=   T35s_h_d1 - U35_d1 when d35_d1='1'
        else T35s_h_d1 + U35_d1;
   T36 <= T37_h(38 downto 0) & T35s_l_d1;
   S35 <= S34_d1 & d35; -- here -1 becomes 0 and 1 becomes 1
   -- Step 37
   d36 <= not T36(55); --  bit of weight -36
   T36s <= T36 & "0";
   T36s_h <= T36s(56 downto 16);
   T36s_l <= T36s(15 downto 0);
   U36 <=  "0" & S35_d1 & d36 & (not d36) & "1"; 
   T38_h <=   T36s_h_d1 - U36_d1 when d36_d1='1'
        else T36s_h_d1 + U36_d1;
   T37 <= T38_h(39 downto 0) & T36s_l_d1;
   S36 <= S35_d1 & d36; -- here -1 becomes 0 and 1 becomes 1
   -- Step 38
   d37 <= not T37(55); --  bit of weight -37
   T37s <= T37 & "0";
   T37s_h <= T37s(56 downto 15);
   T37s_l <= T37s(14 downto 0);
   U37 <=  "0" & S36_d1 & d37 & (not d37) & "1"; 
   T39_h <=   T37s_h_d1 - U37_d1 when d37_d1='1'
        else T37s_h_d1 + U37_d1;
   T38 <= T39_h(40 downto 0) & T37s_l_d1;
   S37 <= S36_d1 & d37; -- here -1 becomes 0 and 1 becomes 1
   -- Step 39
   d38 <= not T38(55); --  bit of weight -38
   T38s <= T38 & "0";
   T38s_h <= T38s(56 downto 14);
   T38s_l <= T38s(13 downto 0);
   U38 <=  "0" & S37_d1 & d38 & (not d38) & "1"; 
   T40_h <=   T38s_h_d1 - U38_d1 when d38_d1='1'
        else T38s_h_d1 + U38_d1;
   T39 <= T40_h(41 downto 0) & T38s_l_d1;
   S38 <= S37_d1 & d38; -- here -1 becomes 0 and 1 becomes 1
   -- Step 40
   d39 <= not T39(55); --  bit of weight -39
   T39s <= T39 & "0";
   T39s_h <= T39s(56 downto 13);
   T39s_l <= T39s(12 downto 0);
   U39 <=  "0" & S38_d1 & d39 & (not d39) & "1"; 
   T41_h <=   T39s_h_d2 - U39_d2 when d39_d2='1'
        else T39s_h_d2 + U39_d2;
   T40 <= T41_h(42 downto 0) & T39s_l_d2;
   S39 <= S38_d1 & d39; -- here -1 becomes 0 and 1 becomes 1
   -- Step 41
   d40 <= not T40(55); --  bit of weight -40
   T40s <= T40 & "0";
   T40s_h <= T40s(56 downto 12);
   T40s_l <= T40s(11 downto 0);
   U40 <=  "0" & S39_d2 & d40 & (not d40) & "1"; 
   T42_h <=   T40s_h_d1 - U40_d1 when d40_d1='1'
        else T40s_h_d1 + U40_d1;
   T41 <= T42_h(43 downto 0) & T40s_l_d1;
   S40 <= S39_d2 & d40; -- here -1 becomes 0 and 1 becomes 1
   -- Step 42
   d41 <= not T41(55); --  bit of weight -41
   T41s <= T41 & "0";
   T41s_h <= T41s(56 downto 11);
   T41s_l <= T41s(10 downto 0);
   U41 <=  "0" & S40_d1 & d41 & (not d41) & "1"; 
   T43_h <=   T41s_h_d1 - U41_d1 when d41_d1='1'
        else T41s_h_d1 + U41_d1;
   T42 <= T43_h(44 downto 0) & T41s_l_d1;
   S41 <= S40_d1 & d41; -- here -1 becomes 0 and 1 becomes 1
   -- Step 43
   d42 <= not T42(55); --  bit of weight -42
   T42s <= T42 & "0";
   T42s_h <= T42s(56 downto 10);
   T42s_l <= T42s(9 downto 0);
   U42 <=  "0" & S41_d1 & d42 & (not d42) & "1"; 
   T44_h <=   T42s_h_d1 - U42_d1 when d42_d1='1'
        else T42s_h_d1 + U42_d1;
   T43 <= T44_h(45 downto 0) & T42s_l_d1;
   S42 <= S41_d1 & d42; -- here -1 becomes 0 and 1 becomes 1
   -- Step 44
   d43 <= not T43(55); --  bit of weight -43
   T43s <= T43 & "0";
   T43s_h <= T43s(56 downto 9);
   T43s_l <= T43s(8 downto 0);
   U43 <=  "0" & S42_d1 & d43 & (not d43) & "1"; 
   T45_h <=   T43s_h_d1 - U43_d1 when d43_d1='1'
        else T43s_h_d1 + U43_d1;
   T44 <= T45_h(46 downto 0) & T43s_l_d1;
   S43 <= S42_d1 & d43; -- here -1 becomes 0 and 1 becomes 1
   -- Step 45
   d44 <= not T44(55); --  bit of weight -44
   T44s <= T44 & "0";
   T44s_h <= T44s(56 downto 8);
   T44s_l <= T44s(7 downto 0);
   U44 <=  "0" & S43_d1 & d44 & (not d44) & "1"; 
   T46_h <=   T44s_h_d2 - U44_d2 when d44_d2='1'
        else T44s_h_d2 + U44_d2;
   T45 <= T46_h(47 downto 0) & T44s_l_d2;
   S44 <= S43_d1 & d44; -- here -1 becomes 0 and 1 becomes 1
   -- Step 46
   d45 <= not T45(55); --  bit of weight -45
   T45s <= T45 & "0";
   T45s_h <= T45s(56 downto 7);
   T45s_l <= T45s(6 downto 0);
   U45 <=  "0" & S44_d2 & d45 & (not d45) & "1"; 
   T47_h <=   T45s_h_d1 - U45_d1 when d45_d1='1'
        else T45s_h_d1 + U45_d1;
   T46 <= T47_h(48 downto 0) & T45s_l_d1;
   S45 <= S44_d2 & d45; -- here -1 becomes 0 and 1 becomes 1
   -- Step 47
   d46 <= not T46(55); --  bit of weight -46
   T46s <= T46 & "0";
   T46s_h <= T46s(56 downto 6);
   T46s_l <= T46s(5 downto 0);
   U46 <=  "0" & S45_d1 & d46 & (not d46) & "1"; 
   T48_h <=   T46s_h_d1 - U46_d1 when d46_d1='1'
        else T46s_h_d1 + U46_d1;
   T47 <= T48_h(49 downto 0) & T46s_l_d1;
   S46 <= S45_d1 & d46; -- here -1 becomes 0 and 1 becomes 1
   -- Step 48
   d47 <= not T47(55); --  bit of weight -47
   T47s <= T47 & "0";
   T47s_h <= T47s(56 downto 5);
   T47s_l <= T47s(4 downto 0);
   U47 <=  "0" & S46_d1 & d47 & (not d47) & "1"; 
   T49_h <=   T47s_h_d1 - U47_d1 when d47_d1='1'
        else T47s_h_d1 + U47_d1;
   T48 <= T49_h(50 downto 0) & T47s_l_d1;
   S47 <= S46_d1 & d47; -- here -1 becomes 0 and 1 becomes 1
   -- Step 49
   d48 <= not T48(55); --  bit of weight -48
   T48s <= T48 & "0";
   T48s_h <= T48s(56 downto 4);
   T48s_l <= T48s(3 downto 0);
   U48 <=  "0" & S47_d1 & d48 & (not d48) & "1"; 
   T50_h <=   T48s_h_d2 - U48_d2 when d48_d2='1'
        else T48s_h_d2 + U48_d2;
   T49 <= T50_h(51 downto 0) & T48s_l_d2;
   S48 <= S47_d1 & d48; -- here -1 becomes 0 and 1 becomes 1
   -- Step 50
   d49 <= not T49(55); --  bit of weight -49
   T49s <= T49 & "0";
   T49s_h <= T49s(56 downto 3);
   T49s_l <= T49s(2 downto 0);
   U49 <=  "0" & S48_d2 & d49 & (not d49) & "1"; 
   T51_h <=   T49s_h_d1 - U49_d1 when d49_d1='1'
        else T49s_h_d1 + U49_d1;
   T50 <= T51_h(52 downto 0) & T49s_l_d1;
   S49 <= S48_d2 & d49; -- here -1 becomes 0 and 1 becomes 1
   -- Step 51
   d50 <= not T50(55); --  bit of weight -50
   T50s <= T50 & "0";
   T50s_h <= T50s(56 downto 2);
   T50s_l <= T50s(1 downto 0);
   U50 <=  "0" & S49_d1 & d50 & (not d50) & "1"; 
   T52_h <=   T50s_h_d1 - U50_d1 when d50_d1='1'
        else T50s_h_d1 + U50_d1;
   T51 <= T52_h(53 downto 0) & T50s_l_d1;
   S50 <= S49_d1 & d50; -- here -1 becomes 0 and 1 becomes 1
   -- Step 52
   d51 <= not T51(55); --  bit of weight -51
   T51s <= T51 & "0";
   T51s_h <= T51s(56 downto 1);
   T51s_l <= T51s(0 downto 0);
   U51 <=  "0" & S50_d1 & d51 & (not d51) & "1"; 
   T53_h <=   T51s_h_d2 - U51_d2 when d51_d2='1'
        else T51s_h_d2 + U51_d2;
   T52 <= T53_h(54 downto 0) & T51s_l_d2;
   S51 <= S50_d1 & d51; -- here -1 becomes 0 and 1 becomes 1
   -- Step 53
   d52 <= not T52(55); --  bit of weight -52
   T52s <= T52 & "0";
   T52s_h <= T52s(56 downto 0);
   U52 <=  "0" & S51_d2 & d52 & (not d52) & "1"; 
   T54_h <=   T52s_h_d1 - U52_d1 when d52_d1='1'
        else T52s_h_d1 + U52_d1;
   T53 <= T54_h(55 downto 0);
   S52 <= S51_d2 & d52; -- here -1 becomes 0 and 1 becomes 1
   d54 <= not T53(55) ; -- the sign of the remainder will become the round bit
   mR <= S52_d1 & d54; -- result significand
   fR <= mR(52 downto 1);-- removing leading 1
   round <= mR(0); -- round bit
   fRrnd <= fR_d1 + ((51 downto 1 => '0') & round_d1); -- rounding sqrt never changes exponents 
   Rn2 <= eRn1_d54 & fRrnd;
   -- sign and exception processing
   with xsX  select 
      xsR <= "010"  when "010",  -- normal case
             "100"  when "100",  -- +infty
             "000"  when "000",  -- +0
             "001"  when "001",  -- the infamous sqrt(-0)=-0
             "110"  when others; -- return NaN
   R <= xsR_d54 & Rn2; 
end architecture;

--------------------------------------------------------------------------------
--                         OutputIEEE_11_52_to_11_52
-- VHDL generated for Virtex6 @ 700MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: F. Ferrandi  (2009-2012)
--------------------------------------------------------------------------------
-- Pipeline depth: 0 cycles
-- Clock period (ns): 1.42857
-- Target frequency (MHz): 700
-- Input signals: X
-- Output signals: R

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity OutputIEEE_11_52_to_11_52 is
    port (clk : in std_logic;
          X : in  std_logic_vector(11+52+2 downto 0);
          R : out  std_logic_vector(63 downto 0)   );
end entity;

architecture arch of OutputIEEE_11_52_to_11_52 is
signal fracX :  std_logic_vector(51 downto 0);
signal exnX :  std_logic_vector(1 downto 0);
signal expX :  std_logic_vector(10 downto 0);
signal sX :  std_logic;
signal expZero :  std_logic;
signal fracR :  std_logic_vector(51 downto 0);
signal expR :  std_logic_vector(10 downto 0);
begin
   fracX  <= X(51 downto 0);
   exnX  <= X(65 downto 64);
   expX  <= X(62 downto 52);
   sX  <= X(63) when (exnX = "01" or exnX = "10" or exnX = "00") else '0';
   expZero  <= '1' when expX = (10 downto 0 => '0') else '0';
   -- since we have one more exponent value than IEEE (field 0...0, value emin-1),
   -- we can represent subnormal numbers whose mantissa field begins with a 1
   fracR <= 
      "0000000000000000000000000000000000000000000000000000" when (exnX = "00") else
      '1' & fracX(51 downto 1) & "" when (expZero = '1' and exnX = "01") else
      fracX  & "" when (exnX = "01") else 
      "000000000000000000000000000000000000000000000000000" & exnX(0);
   expR <=  
      (10 downto 0 => '0') when (exnX = "00") else
      expX when (exnX = "01") else 
      (10 downto 0 => '1');
   R <= sX & expR & fracR; 
end architecture;

--------------------------------------------------------------------------------
--                                my_sqrt_700
--                           (FPSqrt_wrapper_11_52)
-- VHDL generated for Virtex6 @ 700MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: 
--------------------------------------------------------------------------------
-- Pipeline depth: 54 cycles
-- Clock period (ns): 1.42857
-- Target frequency (MHz): 700
-- Input signals: X reset
-- Output signals: R

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity my_sqrt_700 is
    port (clk : in std_logic;
          reset : in  std_logic;
          X : in  std_logic_vector(63 downto 0);
          R : out  std_logic_vector(63 downto 0)   );
end entity;

architecture arch of my_sqrt_700 is
   component InputIEEE_11_52_to_11_52 is
      port ( clk : in std_logic;
             X : in  std_logic_vector(63 downto 0);
             R : out  std_logic_vector(11+52+2 downto 0)   );
   end component;

   component FPSqrt_11_52 is
      port ( clk : in std_logic;
             X : in  std_logic_vector(11+52+2 downto 0);
             R : out  std_logic_vector(11+52+2 downto 0)   );
   end component;

   component OutputIEEE_11_52_to_11_52 is
      port ( clk : in std_logic;
             X : in  std_logic_vector(11+52+2 downto 0);
             R : out  std_logic_vector(63 downto 0)   );
   end component;

signal wireIn :  std_logic_vector(11+52+2 downto 0);
signal wireOut :  std_logic_vector(11+52+2 downto 0);
begin
   in_wrap: InputIEEE_11_52_to_11_52
      port map ( clk  => clk,
                 X => X,
                 R => wireIn);
   wrapped_fp_sqrt: FPSqrt_11_52
      port map ( clk  => clk,
                 X => wireIn,
                 R => wireOut);
   out_wrap: OutputIEEE_11_52_to_11_52
      port map ( clk  => clk,
                 X => wireOut,
                 R => R);
end architecture;
