import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'CustomButtonAnimation/WidgetUtils.dart';
import 'theme.dart';

Widget lengthText({
  BuildContext? contaxt,
  dynamic txt,
  int? nu,
}) {
  return Text(
    txt.length > nu ? txt.substring(0, nu) + "...." : txt,
    style: const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w700,
      color: Colors.black,
    ),
  );
}

Widget myBoldText({
  BuildContext? contaxt,
  dynamic txt,
  double? size,
  dynamic style,
  Color? color,
  FontWeight? fontWeight,
  String? fontFamily,
}) {
  return Text(
    txt,
    style: style ??
        StylesApp.instance.styleMyBoldText.copyWith(
          color: color,
          fontSize: size,
        ),
  );
}

class MyText extends StatelessWidget {
  final String title;
  final Color? color;
  final double? size;
  final double? letterSpace;
  final double? wordSpace;
  final String? fontFamily;
  final TextAlign? alien;
  final TextDecoration? decoration;
  final TextOverflow? overflow;
  final FontWeight? fontWeight;
  final bool isPadding;

  const MyText(
      {super.key,
      required this.title,
      this.color,
      this.isPadding = false,
      this.size,
      this.alien,
      this.fontFamily,
      this.decoration,
      this.letterSpace,
      this.wordSpace,
      this.overflow,
      this.fontWeight});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: isPadding
          ? const EdgeInsets.symmetric(horizontal: 15)
          : EdgeInsets.zero,
      child: Text(
        title,
        textAlign: alien ?? TextAlign.start,
        textScaleFactor: WidgetUtils.textScaleFactor ?? 1.2,
        style: TextStyle(
          color: color ?? Colors.white,
          fontSize: size ?? 16,
          letterSpacing: letterSpace,
          wordSpacing: wordSpace,
          decoration: decoration ?? TextDecoration.none,
          fontWeight: fontWeight ??
              (context.locale.languageCode == "ar"
                  ? FontWeight.w500
                  : FontWeight.w200),
          fontFamily: fontFamily ?? WidgetUtils.fontFamily,
        ),
        overflow: overflow,
      ),
    );
  }
}
