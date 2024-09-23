import 'package:flutter/material.dart';
import 'package:new_code/core/utils/helpers/theme.dart';

class TextDivider extends StatelessWidget {
  final String text;
  final dynamic style;
  const TextDivider({
    super.key,
    required this.text,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: [
          Expanded(child: Divider(color: StylesApp.instance.colorDivider)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              text,
              style: style ?? StylesApp.instance.styleMyBoldText,
            ),
          ),
          Expanded(child: Divider(color: StylesApp.instance.colorDivider)),
        ],
      ),
    );
  }
}
