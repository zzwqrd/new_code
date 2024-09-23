import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/utils/helpers/route.dart';
import 'core/utils/helpers/theme.dart';
import 'injection_container.dart';
import 'test_widget.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  HttpOverrides.global = MyHttpOverrides();
  initKiwi();

  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      path: 'assets/langs',
      saveLocale: true,
      startLocale: const Locale('ar'),
      fallbackLocale: const Locale('en'),
      supportedLocales: const [Locale('ar'), Locale('en')],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          title: 'ERP',
          // home: child,
          theme: StylesApp.instance.getLightTheme(context.locale),
          home: FastkartScreen(),
          // initialRoute: AppRoutes.init.initial,
          // routes: AppRoutes.init.appRoutes,
          navigatorKey: navigator,
          debugShowCheckedModeBanner: false,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          localeResolutionCallback: (deviceLocale, supportedLocales) {
            for (var locale in supportedLocales) {
              if (deviceLocale != null &&
                  deviceLocale.languageCode == locale.languageCode) {
                return deviceLocale;
              }
            }
            return supportedLocales.first;
          },
          builder: (context, child) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(
                textScaler: TextScaler.linear(
                    context.locale.languageCode == "ar" ? 0.9.sp : 0.9.sp),
              ),
              child: _Unfocus(child: child!),
            );
          },
        );
      },
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    final HttpClient client = super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
    return client;
  }
}

class _Unfocus extends StatelessWidget {
  final Widget child;

  const _Unfocus({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: child,
    );
  }
}
