import 'package:flutter/material.dart';

import '../../../generated/assets.dart';
import 'app_style.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({
    super.key,
    required this.message,
  });

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Image.asset(Assets.iconsEmptyState),
          Text(message, style: headLine1),
        ],
      ),
    );
  }
}
