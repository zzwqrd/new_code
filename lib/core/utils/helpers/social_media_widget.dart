import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:new_code/core/utils/helpers/extintions.dart';

class SocialMediaWidget extends StatelessWidget {
  final String icon;
  const SocialMediaWidget({
    super.key,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            border: Border.all(width: 0.5, color: "#DDDBDA".toColor)),
        child: SvgPicture.asset(
          icon,
          width: 25,
          fit: BoxFit.cover,
        ),
      ),
    ).onCenter;
  }
}
