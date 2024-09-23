import 'package:new_code/core/routes/routes.dart';
import 'package:new_code/core/utils/helpers/route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/helpers/custom_btn.dart';
import '../../../../core/utils/helpers/text.dart';
import '../../../../core/utils/helpers/textDivider.dart';
import '../../../../core/utils/helpers/theme.dart';
import '../../../../generated/locale_keys.g.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Align(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              CustomElevatedButton(
                onPressed: () {
                  push(NamedRoutes.i.sign_in);
                },
                text: tr(LocaleKeys.Login),
              ),
              StylesApp.instance.paddingHeight,
              TextDivider(text: "أو", style: StylesApp.instance.orStyle),
              StylesApp.instance.paddingHeight,
              myBoldText(txt: tr(LocaleKeys.not_have_an_account)),
              StylesApp.instance.paddingHeight,
              CustomElevatedButton(
                buttonTextStyle: StylesApp.instance.appStyle
                    .copyWith(color: StylesApp.instance.mainColor),
                hasBlueBorder: true,
                isWhiteBackground: true,
                onPressed: () {},
                text: tr(LocaleKeys.Create_a_new_account),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
