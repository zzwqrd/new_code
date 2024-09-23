import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'base_button.dart';
import 'theme.dart';

Padding customBtn({
  double? width,
  EdgeInsetsGeometry? padding,
  double? height,
  String? title,
  Color? titleColor,
  Color? btnColor,
  Color? borderColor,
  String? fontFamily,
  double? fontSize,
  bool? isWhiteBackground = false, // New parameter
  bool? hasBlueBorder = false, // New parameter
  dynamic onTap,
}) {
  return Padding(
    padding: padding ?? EdgeInsets.symmetric(horizontal: 50.0.w),
    child: InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius:
              BorderRadius.circular(height != null ? (height / 2) : 30.h),
          border: hasBlueBorder!
              ? Border.all(color: StylesApp.instance.mainColor)
              : Border.all(color: borderColor ?? Colors.white),
          color: isWhiteBackground! ? Colors.white : btnColor ?? Colors.white,
        ),
        width: width,
        height: height ?? 60.h,
        child: Center(
          child: Text(
            title!,
            style: TextStyle(
              color: titleColor,
              fontFamily: fontFamily,
              fontSize: fontSize ?? 20,
            ),
          ),
        ),
      ),
    ),
  );
}

class CustomElevatedButton extends BaseButton {
  const CustomElevatedButton({
    Key? key,
    this.decoration,
    this.leftIcon,
    this.rightIcon,
    EdgeInsets? margin,
    VoidCallback? onPressed,
    ButtonStyle? buttonStyle,
    Alignment? alignment,
    TextStyle? buttonTextStyle,
    bool? isDisabled,
    double? height,
    double? width,
    required String text,
    this.isWhiteBackground = false, // New parameter
    this.hasBlueBorder = false, // New parameter
  }) : super(
          text: text,
          onPressed: onPressed,
          buttonStyle: buttonStyle,
          isDisabled: isDisabled,
          buttonTextStyle: buttonTextStyle,
          height: height,
          width: width,
          alignment: alignment,
          margin: margin,
        );

  final BoxDecoration? decoration;
  final Widget? leftIcon;
  final Widget? rightIcon;
  final bool isWhiteBackground; // New field
  final bool hasBlueBorder; // New field

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: buildElevatedButtonWidget,
          )
        : buildElevatedButtonWidget;
  }

  Widget get buildElevatedButtonWidget => Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.h),
        child: Container(
          height: height ?? 55.h,
          width: width ?? double.maxFinite,
          margin: margin,
          decoration: decoration,
          child: ElevatedButton(
            style: buttonStyle ??
                ButtonStyle(
                  backgroundColor: WidgetStateProperty.all<Color>(
                      isWhiteBackground
                          ? Colors.white
                          : StylesApp.instance.mainColor),
                  foregroundColor: WidgetStateProperty.all<Color>(
                      StylesApp.instance.mainColor),
                  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      side: hasBlueBorder
                          ? BorderSide(color: StylesApp.instance.mainColor)
                          : BorderSide.none,
                    ),
                  ),
                ),
            onPressed: isDisabled ?? false ? null : onPressed ?? () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                leftIcon ?? const SizedBox.shrink(),
                Text(
                  text,
                  style: buttonTextStyle ?? StylesApp.instance.appStyle,
                ),
                rightIcon ?? const SizedBox.shrink(),
              ],
            ),
          ),
        ),
      );
}

// // ignore_for_file: use_key_in_widget_constructors
//
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// import 'base_button.dart';
// import 'theme.dart';
//
// Padding customBtn({
//   double? width,
//   EdgeInsetsGeometry? padding,
//   double? height,
//   String? title,
//   Color? titleColor,
//   Color? btnColor,
//   Color? borderColor,
//   String? fontFamily,
//   double? fontSize,
//   dynamic onTap,
// }) {
//   return Padding(
//     padding: padding ?? EdgeInsets.symmetric(horizontal: 50.0.w),
//     child: InkWell(
//       onTap: onTap,
//       child: Container(
//         decoration: BoxDecoration(
//           borderRadius:
//               BorderRadius.circular(height != null ? (height / 2) : 30.h),
//           border: Border.all(color: borderColor ?? Colors.white),
//           color: btnColor ?? Colors.white,
//         ),
//         width: width,
//         height: height ?? 60.h,
//         child: Center(
//           child: Text(
//             title!,
//             style: TextStyle(
//               color: titleColor,
//               fontFamily: fontFamily,
//               fontSize: fontSize ?? 20,
//             ),
//           ),
//         ),
//       ),
//     ),
//   );
// }
//
// class CustomElevatedButton extends BaseButton {
//   const CustomElevatedButton({
//     Key? key,
//     this.decoration,
//     this.leftIcon,
//     this.rightIcon,
//     EdgeInsets? margin,
//     VoidCallback? onPressed,
//     ButtonStyle? buttonStyle,
//     Alignment? alignment,
//     TextStyle? buttonTextStyle,
//     bool? isDisabled,
//     double? height,
//     double? width,
//     required String text,
//   }) : super(
//           text: text,
//           onPressed: onPressed,
//           buttonStyle: buttonStyle,
//           isDisabled: isDisabled,
//           buttonTextStyle: buttonTextStyle,
//           height: height,
//           width: width,
//           alignment: alignment,
//           margin: margin,
//         );
//
//   final BoxDecoration? decoration;
//
//   final Widget? leftIcon;
//
//   final Widget? rightIcon;
//
//   @override
//   Widget build(BuildContext context) {
//     return alignment != null
//         ? Align(
//             alignment: alignment ?? Alignment.center,
//             child: buildElevatedButtonWidget,
//           )
//         : buildElevatedButtonWidget;
//   }
//
//   Widget get buildElevatedButtonWidget => Padding(
//         padding: EdgeInsets.symmetric(horizontal: 15.h),
//         child: Container(
//           height: height ?? 55.h,
//           width: width ?? double.maxFinite,
//           margin: margin,
//           decoration: decoration,
//           child: ElevatedButton(
//             style: buttonStyle ??
//                 ButtonStyle(
//                   backgroundColor: WidgetStateProperty.all<Color>(
//                       StylesApp.instance.mainColor),
//                   foregroundColor: WidgetStateProperty.all<Color>(
//                       StylesApp.instance.mainColor),
//                   shape: WidgetStateProperty.all<RoundedRectangleBorder>(
//                     RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8.0),
//                     ),
//                   ),
//                 ),
//             onPressed: isDisabled ?? false ? null : onPressed ?? () {},
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 leftIcon ?? const SizedBox.shrink(),
//                 Text(
//                   text,
//                   style: buttonTextStyle ?? StylesApp.instance.appStyle,
//                 ),
//                 rightIcon ?? const SizedBox.shrink(),
//               ],
//             ),
//           ),
//         ),
//       );
// }
