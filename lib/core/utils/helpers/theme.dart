import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../generated/assets.dart';
import 'extintions.dart';
import 'route.dart';

class StylesApp {
  static final StylesApp instance = StylesApp._internal();

  StylesApp._internal();
  // final appStoreUtl
  final paddingHeight = SizedBox(height: 18.h);
  final paddingWidth = SizedBox(width: 18.h);

  SizedBox sizeHeight(double height) => SizedBox(height: height.h);
  SizedBox sizeWidth(double width) => SizedBox(width: width.w);

  final mainColor = "#3D3BE7".toColor;
  final textColor = "#1E1E1E".toColor;

  final colorWight = Colors.white;
  final grayColor = "#DDDBDA".toColor;

  final backgroundColor = "#bdcbda".toColor;

  final colorButton = "#21272d".toColor;
  final colorDivider = "#DDDBDA".toColor;
  final colorGrayOp = "#666666".toColor;

  final baseShimmerColor = Colors.grey.shade200;
  final highlightShimmerColor = Colors.white;
  final primaryColorLight = Colors.white;
  final primaryColor = "#29398C".toColor;
  final hintColor = "#8E8EA9".toColor;
  final errorColor = "#FF0000".toColor;
  final primaryContainer = "#F9F9F9".toColor;
  final primaryColorDark = Colors.black;
  final borderColor = "#EDEDED".toColor;

  TextTheme get englishTheme => TextTheme(
        displayLarge: TextStyle(
            fontWeight: FontWeight.w900,
            color: primaryColorDark), // Black mostly
        displayMedium: TextStyle(
            fontWeight: FontWeight.w800, color: primaryColorDark), // Extra-bold
        displaySmall: TextStyle(
            fontWeight: FontWeight.w700, color: primaryColorDark), // bold
        titleLarge: TextStyle(
            fontWeight: FontWeight.w600, color: primaryColorDark), // semi bold
        titleMedium:
            TextStyle(fontWeight: FontWeight.w500, color: textColor), // medium
        bodyMedium:
            TextStyle(fontWeight: FontWeight.w400, color: textColor), // regular
        bodySmall:
            TextStyle(fontWeight: FontWeight.w300, color: textColor), // Light
      );

  final double height = 20;

  final TextStyle appStyle = const TextStyle(
    fontSize: 14,
    color: Colors.white,
  );

  final TextStyle orStyle = const TextStyle(
    fontSize: 18,
    color: Colors.black,
  );

  final TextStyle appStyleTow = TextStyle(
    fontSize: 14,
    color: "#691f23".toColor,
  );

  final TextStyle styleMyBoldText = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w900,
    color: "#666666".toColor,
    fontFamily: Assets.fontsCairoRegular,
  );

  ThemeData getLightTheme(Locale locale) {
    return ThemeData(
      platform: TargetPlatform.iOS,
      primaryColor: primaryColor,
      primaryColorLight: primaryColorLight,
      hintColor: hintColor,
      primaryColorDark: primaryColorDark,
      brightness: Brightness.light,
      fontFamily: "ExtraBold",
      colorScheme: ColorScheme.light(
        primary: primaryColor,
        surface: Colors.white,
        error: errorColor,
        primaryContainer: primaryContainer,
        secondary: textColor,
        tertiary: borderColor,
        // tertiaryContainer: tertiaryContainer,
        // secondaryContainer: priceColor,
        // inversePrimary: flashSaleColor,
        inverseSurface: baseShimmerColor,
        onInverseSurface: highlightShimmerColor,
      ),
      iconTheme: IconThemeData(size: 20.h),
      textTheme: englishTheme,
      scaffoldBackgroundColor: StylesApp.instance.colorWight,
      appBarTheme: AppBarTheme(
        toolbarHeight: 50,
        iconTheme: IconThemeData(size: 20.h),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        foregroundColor: Colors.white,
        shadowColor: hintColor,
        elevation: 0.1,
        titleTextStyle: const TextStyle(
            fontSize: 14, color: Colors.black, fontWeight: FontWeight.w600),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        selectedIconTheme: IconThemeData(color: primaryColor, size: 20.h),
        unselectedIconTheme: IconThemeData(color: hintColor, size: 20.h),
        selectedLabelStyle: TextStyle(fontSize: 12, color: primaryColor),
        unselectedLabelStyle: TextStyle(fontSize: 12, color: hintColor),
        elevation: 2,
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: navigator.currentContext?.textTheme.bodySmall
            ?.copyWith(color: Colors.grey.shade300, fontSize: 14),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        errorStyle: TextStyle(
          fontSize: 10,
          height: 1,

          // fontFamily: locale.languageCode == "ar" ? FontFamily.montserratLight : FontFamily.interLight,
          color: errorColor,
          fontStyle: FontStyle.italic,
        ),
        errorMaxLines: 2,
        border: OutlineInputBorder(
            borderSide: BorderSide(color: borderColor),
            borderRadius: BorderRadius.circular(10.h)),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: borderColor),
            borderRadius: BorderRadius.circular(10.h)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: primaryColor),
            borderRadius: BorderRadius.circular(10.h)),
        disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: borderColor),
            borderRadius: BorderRadius.circular(10.h)),
        errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: errorColor),
            borderRadius: BorderRadius.circular(10.h)),
        focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: borderColor),
            borderRadius: BorderRadius.circular(10.h)),
      ),
    );
  }

  ThemeData getDarkTheme(Locale locale) {
    return ThemeData(
      platform: TargetPlatform.iOS,
      primaryColor: Colors.black,
      primaryColorLight: "#303030".toColor,
      hintColor: Colors.black,
      primaryColorDark: primaryColorLight,
      brightness: Brightness.dark,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      colorScheme: ColorScheme.dark(
        primary: Colors.black,
        surface: Colors.black,
        secondary: Colors.black,
        primaryContainer: primaryContainer,
        // tertiary: tertiary,
        // tertiaryContainer: tertiaryContainer,
        // secondaryContainer: priceColor,
        // inversePrimary: flashSaleColor,
        inverseSurface: "#303030".toColor,
        onInverseSurface: "#303030".toColor.withOpacity(.5),
      ),
      iconTheme: IconThemeData(size: 20.h, color: primaryColorLight),
      // textTheme: arabicThemeDark,
      // scaffoldBackgroundColor: scaffoldBackgroundDarkColor,
      appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(size: 20.h),
        color: Colors.black,
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: navigator.currentContext?.textTheme.bodyMedium
            ?.copyWith(color: hintColor, fontSize: 14),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        errorStyle: TextStyle(
          fontSize: 10,
          // fontFamily: locale.languageCode == "ar" ? FontFamily.montserratLight : FontFamily.interLight,
          color: errorColor,
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }
}
