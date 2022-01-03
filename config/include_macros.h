/*
*
* Copyright (c) 2021 scrthq
* SPDX-License-Identifier: MIT
*
*/

#include <dt-bindings/zmk/keys.h>
#include <dt-bindings/zmk/bt.h>

#if (__has_include("local_macros.dtsi"))
    #include "local_macros.dtsi"
#else
    #define mac_rtyu <&kp R>, <&kp T>, <&kp Y>, <&kp U>
    #define mac_gh <&kp G>, <&kp H>
    #define test_zeroes <&kp T>
    #define mac_tl <&kp T>, <&kp L>
    #define chonk <&kp T>
    #define mpin <&kp T>
#endif

#define MEH LS(LA(LCTL))
