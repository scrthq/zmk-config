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

#define WNDOWS 0
#define MACOSX 1
#define WINKEY 2
#define MACKEY 3
#define GAMING 4
#define NUMPAD 5
#define NUMROW 6
#define ADJUST 7
#define CONFIG 8
