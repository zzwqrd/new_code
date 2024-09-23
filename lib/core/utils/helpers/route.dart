import 'package:flash/flash_helper.dart';
import 'package:flutter/material.dart';

import '../../routes/app_routes.dart';

Future<dynamic> push(String named,
    {dynamic arguments, NavigatorAnimation? type}) {
  return Navigator.of(navigator.currentContext!)
      .push(SlideRight(named: named, arguments: arguments, type: type));
}

Future<dynamic> replacement(String named,
    {dynamic arguments, NavigatorAnimation? type}) {
  return Navigator.of(navigator.currentContext!).pushReplacement(
    SlideRight(named: named, arguments: arguments, type: type),
  );
}

Future<dynamic> pushAndRemoveUntil(String child,
    {dynamic arguments, NavigatorAnimation? type}) {
  return Navigator.of(navigator.currentContext!).pushAndRemoveUntil(
      SlideRight(named: child, arguments: arguments, type: type),
      (route) => false);
}

class SlideRight extends PageRouteBuilder {
  final String named;
  final dynamic arguments;
  final NavigatorAnimation? type;
  SlideRight({required this.named, this.arguments, this.type})
      : super(
          settings: RouteSettings(arguments: arguments, name: named),
          pageBuilder: (context, animation, secondaryAnimation) {
            return AppRoutes.init.appRoutes[named]!(context);
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            switch (type) {
              case NavigatorAnimation.position:
                {
                  return SlideTransition(
                    position:
                        Tween(begin: const Offset(0.0, 1.0), end: Offset.zero)
                            .animate(animation),
                    child: child,
                  );
                }
              case NavigatorAnimation.scale:
                {
                  return ScaleTransition(
                    alignment: Alignment.center,
                    scale: Tween<double>(begin: 0.1, end: 1).animate(
                      CurvedAnimation(
                          parent: animation, curve: Curves.decelerate),
                    ),
                    child: child,
                  );
                }
              default:
                {
                  return FadeTransition(
                    opacity: animation,
                    child: child,
                  );
                }
            }
          },
        );
}

enum NavigatorAnimation { opacity, scale, position }

enum MessageType { success, failed, warning }

void showMessage(String msg, {MessageType messageType = MessageType.failed}) {
  if (msg.isNotEmpty) {
    Toast.show(
      navigator.currentContext!,
      Text(msg),
      //     backgroundColor:
      //     messageType==MessageType.warning?Colors.amber
      // :messageType==MessageType.success?AppTheme.mainColor
      // :AppTheme.mainRedColor
    );
  }
}

final GlobalKey<NavigatorState> navigator = GlobalKey<NavigatorState>();
