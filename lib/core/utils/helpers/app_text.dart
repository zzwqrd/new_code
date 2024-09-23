import 'package:flutter/material.dart';

class MyTextApp extends StatelessWidget {
  final String title;
  final Color? color;
  final double? size;
  final double? letterSpace;
  final double? wordSpace;
  final String? fontFamily;
  final TextAlign? align;
  final TextDecoration? decoration;
  final TextOverflow? overflow;
  final FontWeight? fontWeight;

  final IconData? icon;
  final ImageProvider? image;
  final Color? iconColor;
  final double? iconSize;
  final double? imageSize;

  final VoidCallback? onTap; // إضافة onTap هنا فقط لحالة MyTextApp.nav

  const MyTextApp({
    Key? key,
    required this.title,
    this.color,
    this.size,
    this.align,
    this.fontFamily,
    this.decoration,
    this.letterSpace,
    this.wordSpace,
    this.overflow,
    this.fontWeight,
    this.icon,
    this.image,
    this.iconColor,
    this.iconSize,
    this.imageSize,
    this.onTap,
  }) : super(key: key);

  // Named constructor for bold text
  MyTextApp.bold({
    Key? key,
    required this.title,
    this.color,
    this.size = 18,
    this.align = TextAlign.start,
    this.fontFamily,
    this.decoration = TextDecoration.none,
    this.letterSpace,
    this.wordSpace,
    this.overflow = TextOverflow.ellipsis,
    this.icon,
    this.image,
    this.iconColor,
    this.iconSize,
    this.imageSize,
  })  : fontWeight = FontWeight.bold,
        onTap = null, // no tap functionality for bold text
        super(key: key);

  // Named constructor for small text
  MyTextApp.small({
    Key? key,
    required this.title,
    this.color,
    this.size = 12,
    this.align = TextAlign.start,
    this.fontFamily,
    this.decoration = TextDecoration.none,
    this.letterSpace,
    this.wordSpace,
    this.overflow = TextOverflow.clip,
    this.icon,
    this.image,
    this.iconColor,
    this.iconSize,
    this.imageSize,
  })  : fontWeight = FontWeight.normal,
        onTap = null, // no tap functionality for small text
        super(key: key);

  // Named constructor for headings
  MyTextApp.heading({
    Key? key,
    required this.title,
    this.color = Colors.black,
    this.size = 24,
    this.align = TextAlign.center,
    this.fontFamily,
    this.decoration = TextDecoration.none,
    this.letterSpace = 1.2,
    this.wordSpace,
    this.overflow = TextOverflow.ellipsis,
    this.icon,
    this.image,
    this.iconColor,
    this.iconSize,
    this.imageSize,
  })  : fontWeight = FontWeight.bold,
        onTap = null, // no tap functionality for headings
        super(key: key);

  // Named constructor for navigable text
  MyTextApp.nav({
    Key? key,
    required this.title,
    this.color =
        Colors.blue, // يمكن تعديل اللون الافتراضي ليشير إلى قابلية النقر
    this.size = 16,
    this.align = TextAlign.start,
    this.fontFamily,
    this.decoration =
        TextDecoration.underline, // underline to indicate it's clickable
    this.letterSpace,
    this.wordSpace,
    this.overflow = TextOverflow.ellipsis,
    this.icon,
    this.image,
    this.iconColor,
    this.iconSize,
    this.imageSize,
    required this.onTap, // onTap is required for navigation
  })  : fontWeight = FontWeight.normal,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    // حالة MyTextApp.nav التي تقبل النقر
    return onTap != null
        ? InkWell(
            onTap: onTap,
            child: _buildTextRow(),
          )
        : _buildTextRow(); // لباقي الحالات التي لا تقبل النقر
  }

  // Method to build the row with optional icon or image and text
  Widget _buildTextRow() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null)
          Icon(
            icon,
            color: iconColor ?? Colors.black,
            size: iconSize ?? size ?? 16,
          ),
        if (image != null)
          Image(
            image: image!,
            width: imageSize ?? 24,
            height: imageSize ?? 24,
          ),
        SizedBox(width: (icon != null || image != null) ? 8.0 : 0),
        Text(
          title,
          textAlign: align ?? TextAlign.start,
          style: TextStyle(
            color: color ?? Colors.black,
            fontSize: size,
            letterSpacing: letterSpace,
            wordSpacing: wordSpace,
            decoration: decoration ?? TextDecoration.none,
            fontWeight: fontWeight ?? FontWeight.normal,
            fontFamily: fontFamily ?? 'Roboto',
          ),
          overflow: overflow,
        ),
      ],
    );
  }
}
