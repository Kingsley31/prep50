import 'package:flutter/material.dart';


Map<int, Color> _greyColor = {
  50: Color(0xffF7F7F7).withOpacity(0.1),
  100: Color(0xffF7F7F7).withOpacity(0.2),
  200: Color(0xffF7F7F7).withOpacity(0.3),
  300: Color(0xffF7F7F7).withOpacity(0.4),
  400: Color(0xffF7F7F7).withOpacity(0.5),
  500: Color(0xffF7F7F7).withOpacity(0.6),
  600: Color(0xffF7F7F7).withOpacity(0.7),
  700: Color(0xffF7F7F7).withOpacity(0.8),
  800: Color(0xffF7F7F7).withOpacity(0.9),
  900: Color(0xffF7F7F7).withOpacity(1),
};
final MaterialColor kpGrey = MaterialColor(0xffF7F7F7, _greyColor);

Map<int, Color> _primaryColor = {
  50: Color(0xffFFFFFF).withOpacity(0.1),
  100: Color(0xffFFFFFF).withOpacity(0.2),
  200: Color(0xffFFF4F0).withOpacity(0.3),
  300: Color(0xffFFE8E0).withOpacity(0.4),
  400: Color(0xffFF4201).withOpacity(0.5),
  500: Color(0xffFF4201).withOpacity(0.6),
  600: Color(0xffFF4201).withOpacity(0.7),
  700: Color(0xffFF4201).withOpacity(0.8),
  800: Color(0xffFF4201).withOpacity(0.9),
  900: Color(0xffFF4201).withOpacity(1),
};

final MaterialColor kPrimaryColor = MaterialColor(0xffFF4201, _primaryColor);

Map<int, Color> _accentColor = {
  50: Color(0xffF7F7F7).withOpacity(0.1),
  100: Color(0xffF7F7F7).withOpacity(0.2),
  200: Color(0xffE0E0E0).withOpacity(0.3),
  300: Color(0xffADADAD).withOpacity(0.4),
  400: Color(0xff666666).withOpacity(0.5),
  500: Color(0xff212121).withOpacity(0.6),
  600: Color(0xff212121).withOpacity(0.7),
  700: Color(0xff212121).withOpacity(0.8),
  800: Color(0xff212121).withOpacity(0.9),
  900: Color(0xff212121).withOpacity(1),
};

final MaterialColor kAccentColor = MaterialColor(0xff212121, _accentColor);

Map<int, Color> _successColor = {
  50: Color(0xff03BA50).withOpacity(0.1),
  100: Color(0xff03BA50).withOpacity(0.2),
  200: Color(0xff03BA50).withOpacity(0.3),
  300: Color(0xff03BA50).withOpacity(0.4),
  400: Color(0xff03BA50).withOpacity(0.5),
  500: Color(0xff03BA50).withOpacity(0.6),
  600: Color(0xff03BA50).withOpacity(0.7),
  700: Color(0xff03BA50).withOpacity(0.8),
  800: Color(0xff03BA50).withOpacity(0.9),
  900: Color(0xff03BA50).withOpacity(1),
};

final MaterialColor kSuccessColor = MaterialColor(0xff03BA50, _successColor);

Map<int, Color> _successLight = {
  50: Color(0xffF0FFF6).withOpacity(0.1),
  100: Color(0xffF0FFF6).withOpacity(0.2),
  200: Color(0xffF0FFF6).withOpacity(0.3),
  300: Color(0xffF0FFF6).withOpacity(0.4),
  400: Color(0xffF0FFF6).withOpacity(0.5),
  500: Color(0xffF0FFF6).withOpacity(0.6),
  600: Color(0xffF0FFF6).withOpacity(0.7),
  700: Color(0xffF0FFF6).withOpacity(0.8),
  800: Color(0xffF0FFF6).withOpacity(0.9),
  900: Color(0xffF0FFF6).withOpacity(1),
};

// final MaterialColor kBlackColor = MaterialColor(0xff03BA50, _successColor);

// Map<int, Color> _kBlackColor = {
//   50: Color(0xffFF4201).withOpacity(0.1),
//   100: Color(0xffFF4201).withOpacity(0.2),
//   200: Color(0xffF0FFF6).withOpacity(0.3),
//   300: Color(0xffF0FFF6).withOpacity(0.4),
//   400: Color(0xffF0FFF6).withOpacity(0.5),
//   500: Color(0xffF0FFF6).withOpacity(0.6),
//   600: Color(0xffF0FFF6).withOpacity(0.7),
//   700: Color(0xffF0FFF6).withOpacity(0.8),
//   800: Color(0xffF0FFF6).withOpacity(0.9),
//   900: Color(0xffF0FFF6).withOpacity(1),
// };

final Color kBlackColor = Color(0xff212121);
final Color kMidBlackColor = Color(0xff666666);
final Color kMidGreyColor = Color(0xffADADAD);
final Color kLightGreyShadeColour = Color(0xffE0E0E0);
final Color kLighterGreyShadeColour = Color(0xffF7F7F7);

final MaterialColor kSuccessLight = MaterialColor(0xffF0FFF6, _successLight);

Map<int, Color> _infoColor = {
  50: Color(0xff0248FB).withOpacity(0.1),
  100: Color(0xff0248FB).withOpacity(0.2),
  200: Color(0xff0248FB).withOpacity(0.3),
  300: Color(0xff0248FB).withOpacity(0.4),
  400: Color(0xff0248FB).withOpacity(0.5),
  500: Color(0xff0248FB).withOpacity(0.6),
  600: Color(0xff0248FB).withOpacity(0.7),
  700: Color(0xff0248FB).withOpacity(0.8),
  800: Color(0xff0248FB).withOpacity(0.9),
  900: Color(0xff0248FB).withOpacity(1),
};

final MaterialColor kInfoColor = MaterialColor(0xff0248FB, _infoColor);

Map<int, Color> _infoLightColor = {
  50: Color(0xffF0F4FF).withOpacity(0.1),
  100: Color(0xffF0F4FF).withOpacity(0.2),
  200: Color(0xffF0F4FF).withOpacity(0.3),
  300: Color(0xffF0F4FF).withOpacity(0.4),
  400: Color(0xffF0F4FF).withOpacity(0.5),
  500: Color(0xffF0F4FF).withOpacity(0.6),
  600: Color(0xffF0F4FF).withOpacity(0.7),
  700: Color(0xffF0F4FF).withOpacity(0.8),
  800: Color(0xffF0F4FF).withOpacity(0.9),
  900: Color(0xffF0F4FF).withOpacity(1),
};

final MaterialColor kInfoLightColor =
    MaterialColor(0xffF0F4FF, _infoLightColor);

Map<int, Color> _pendingColor = {
  50: Color(0xffF6CB00).withOpacity(0.1),
  100: Color(0xffF6CB00).withOpacity(0.2),
  200: Color(0xffF6CB00).withOpacity(0.3),
  300: Color(0xffF6CB00).withOpacity(0.4),
  400: Color(0xffF6CB00).withOpacity(0.5),
  500: Color(0xffF6CB00).withOpacity(0.6),
  600: Color(0xffF6CB00).withOpacity(0.7),
  700: Color(0xffF6CB00).withOpacity(0.8),
  800: Color(0xffF6CB00).withOpacity(0.9),
  900: Color(0xffF6CB00).withOpacity(1),
};

final MaterialColor kPendingColor = MaterialColor(0xffF6CB00, _pendingColor);

Map<int, Color> _pendingLightColor = {
  50: Color(0xffFFFCF0).withOpacity(0.1),
  100: Color(0xffFFFCF0).withOpacity(0.2),
  200: Color(0xffFFFCF0).withOpacity(0.3),
  300: Color(0xffFFFCF0).withOpacity(0.4),
  400: Color(0xffFFFCF0).withOpacity(0.5),
  500: Color(0xffFFFCF0).withOpacity(0.6),
  600: Color(0xffFFFCF0).withOpacity(0.7),
  700: Color(0xffFFFCF0).withOpacity(0.8),
  800: Color(0xffFFFCF0).withOpacity(0.9),
  900: Color(0xffFFFCF0).withOpacity(1),
};

final MaterialColor kPendingLightColor =
    MaterialColor(0xffFFFCF0, _pendingLightColor);

Map<int, Color> _errorColor = {
  50: Color(0xffFE0101).withOpacity(0.1),
  100: Color(0xffFE0101).withOpacity(0.2),
  200: Color(0xffFE0101).withOpacity(0.3),
  300: Color(0xffFE0101).withOpacity(0.4),
  400: Color(0xffFE0101).withOpacity(0.5),
  500: Color(0xffFE0101).withOpacity(0.6),
  600: Color(0xffFE0101).withOpacity(0.7),
  700: Color(0xffFE0101).withOpacity(0.8),
  800: Color(0xffFE0101).withOpacity(0.9),
  900: Color(0xffFE0101).withOpacity(1),
};

final MaterialColor kErrorColor = MaterialColor(0xffFE0101, _errorColor);

Map<int, Color> _errorLightColor = {
  50: Color(0xffFFF0F0).withOpacity(0.1),
  100: Color(0xffFFF0F0).withOpacity(0.2),
  200: Color(0xffFFF0F0).withOpacity(0.3),
  300: Color(0xffFFF0F0).withOpacity(0.4),
  400: Color(0xffFFF0F0).withOpacity(0.5),
  500: Color(0xffFFF0F0).withOpacity(0.6),
  600: Color(0xffFFF0F0).withOpacity(0.7),
  700: Color(0xffFFF0F0).withOpacity(0.8),
  800: Color(0xffFFF0F0).withOpacity(0.9),
  900: Color(0xffFFF0F0).withOpacity(1),
};

final MaterialColor kErrorLightColor =
    MaterialColor(0xffFFF0F0, _errorLightColor);
