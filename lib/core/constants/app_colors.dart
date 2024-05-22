// ignore_for_file: use_full_hex_values_for_flutter_colors, constant_identifier_names

import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xffFCFCFC);
const kSecondaryColor = Color(0xff38B6FF);
const kSecondaryColor2 = Color(0xffffffff);
const kTertiaryColor = Color.fromARGB(255, 0, 0, 0);
const kQuaternaryColor = Color(0xffFFFFFF);
const kGreyColor = Color(0xff7F7F7F);
const kGreyColor2 = Color(0xffE1E1E1);
const kGreyColor3 = Color(0xffDCDCE0);
const kGreyColor4 = Color(0xff393939);
const kBlackColor2 = Color(0xff222222);
const kDarkGreyColor = Color(0xff535353);
const kDarkGreyColor2 = Color(0xff3A3A3C);
const kDarkGreyColor3 = Color(0xff2C2C2E);
const kDarkGreyColor4 = Color(0xff272727);
const kDarkGreyColor5 = Color(0xff2F2F2F);
const kInputBorderColor = Color(0xff5C5A5B);
const kBottomNavColor = Color(0xff0A0A0A);
const kBottomNavBorderColor = Color(0xff1C1C1C);
const kUnSelectedColor = Color(0xff505050);
const kErrorColor = Color(0xffFF0000);
const kPurpleColor = Color(0xff5E5498);
const kBlueColor = Color(0xff006FFF);
const kLightPurpleColor = Color(0xffF4F2FF);

const kBlackColor = Color(0xff181818);
const kBlackColor1 = Color(0xff161616);
const KPurpleColor = Color(0xff9662F1);

const kTextColor2 = Color(0xff1B2030);
const kTextColor3 = Color(0xff090B2F);
const kTextColor4 = Color(0xff31383C);
const kTextColor5 = Color(0xff62686B);
const kGrey1Color = Color(0xffF2F3F4);
const kGrey2Color = Color(0xffE6E6E8);
const kGrey4Color = Color(0xffB3B5BA);
const kGrey5Color = Color(0xff9A9CA3);
const kGrey8Color = Color(0xff4E515E);
const kGrey9Color = Color(0xff494949);
const kGrey10Color = Color(0xff1B2030);
const kGrey11Color = Color(0xffBDBDBD);
const kGrey12Color = Color(0xff636363);
const kGrey13Color = Color(0xffE3E3E3);
const kGrey14Color = Color(0xff707070);
const kGrey15Color = Color(0xffF4F4F4);
const kGrey16Color = Color(0xffD9D9D9);
const kGrey17Color = Color(0xff9C9C9C);
const kGrey18Color = Color(0xff414141);
const kGrey19Color = Color(0xff8D8D8D);
const kGrey20Color = Color(0xff787878);
const kGrey21Color = Color(0xff3F3F3F);
const kGrey22Color = Color(0xff979797);
const grey1Color = Color(0xff7F7F7F);
const kBlack2Color = Color(0xff272727);
const kBlack3Color = Color(0xff0D0D0D);
const kBlackTxtField = Color(0xff181818);
const kGreyBorderColor = Color(0xff2C2C2C);
const kGreyBorderColor1 = Color(0xff333333);
const kGreyBorderColor2 = Color(0xff383838);
const kGreyTxtColor = Color(0xff747487);
const kInputBgColor = Color(0xffFAFAFA);
const kHintColor = Color(0xffB3B5BA);
const kInputTextColor = Color(0xff020719);
const kToggleButtonShadow = Color(0xffEFF3F8);
const kBorderColor = Color(0xffF2F3F4);
const kBorder2Color = Color(0xff675A55);
const kSeoulColor = Color(0xffF9F9F9);
const kGreenColor = Color(0xff21CA6F);
const kOnlineColor = Color(0xff6CD86B);
const kRedColor = Color(0xffFF002E);
const kRedColor2 = Color(0xffFF0000);
const kYellowColor = Color(0xffFFC121);
const kRatedColor = Color(0xffFFC000);
const kPlaceHolderColor = Color(0xff939393);
const kCustomButtonColor = Color(0xffD0FD3E);
const kCardBg = Color(0xff242424);
const kcircleavatar = Color(0xff2C2C2E);
const kcustomcontiner = Color(0xff242424);
const kcustomcheckbox = Color(0xff535353);
const kcustombackbutton = Color(0xff3A3A3C);
const kBottomNavSelected = Color(0xffD0FD3E);
const kBottomNavUnselected = Color(0xff505050);

const LinearGradient brownwhite = LinearGradient(
    colors: [
      Color(0xffF6EED0),
      kPrimaryColor, // Start color
      Color(0xffF6EED0),
      // End color
    ],
    stops: [
      0.2,
      0.8,
      1,
    ], // Adjust stops to control color portions
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter);

const LinearGradient blacktrans = LinearGradient(
    colors: [
      Color.fromARGB(47, 9, 0, 0),
      Color.fromARGB(143, 0, 0, 0),
      Color.fromARGB(185, 0, 0, 0),
      // End color
    ],
    stops: [
      0.4,
      0.5,
      0.9,
    ], // Adjust stops to control color portions
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter);
LinearGradient halfgrad(Color color) {
  return LinearGradient(
      colors: [
        color.withOpacity(0.1),
        color,

        // Start color
        // End color
      ],
      stops: [
        0.85,
        0.05
      ], // Adjust stops to control color portions
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter);
}
