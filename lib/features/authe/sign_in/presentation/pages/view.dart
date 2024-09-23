import 'package:new_code/core/routes/routes.dart';
import 'package:new_code/core/utils/helpers/extintions.dart';
import 'package:new_code/core/utils/helpers/route.dart';
import 'package:new_code/core/utils/helpers/text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/utils/helpers/CustomButtonAnimation/CustomButtonAnimation.dart';
import '../../../../../core/utils/helpers/CustomButtonAnimation/LoadingButton.dart';
import '../../../../../core/utils/helpers/social_media_widget.dart';
import '../../../../../core/utils/helpers/textDivider.dart';
import '../../../../../core/utils/helpers/text_form_field.dart';
import '../../../../../core/utils/helpers/theme.dart';
import '../../../../../core/utils/helpers/validator.dart';
import '../../../../../generated/assets.dart';
import '../../../../../generated/locale_keys.g.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<CustomButtonState> btnKey = GlobalKey<CustomButtonState>();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return Scaffold(
      body: SizedBox.expand(
        child: Align(
          alignment: Alignment.center,
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                myBoldText(
                  size: 18,
                  color: Colors.black,
                  txt: tr(LocaleKeys.join_us),
                ).onCenter,
                StylesApp.instance.paddingHeight,
                myBoldText(
                  txt: tr(LocaleKeys.sign_in_to_continue),
                ).onCenter,
                StylesApp.instance.paddingHeight,
                MyText(
                  isPadding: true,
                  title: tr(LocaleKeys.Mobile_number),
                  color: "#374151".toColor,
                  size: 11,
                ).centerStart,
                StylesApp.instance.paddingHeight,
                txtField(
                  controller: TextEditingController(),
                  validator: (value) => Validator(value).validatePhone(
                    context,
                    message: tr(LocaleKeys.Mobile_number),
                  ),
                  hintText: tr(LocaleKeys.Mobile_number),
                  textInputType: TextInputType.phone,
                ),
                StylesApp.instance.paddingHeight,
                LoadingButton(
                  btnKey: btnKey,
                  title: tr(LocaleKeys.Login),
                  onTap: () {
                    push(NamedRoutes.i.select_location);
                    // if (formKey.currentState!.validate()) {
                    //   formKey.currentState!.save();
                    // }

                    // btnKey.currentState!.animateForward();
                    // btnKey.currentState!.animateReverse();
                  },
                  color: StylesApp.instance.mainColor,
                  fontSize: 15,
                ),
                StylesApp.instance.paddingHeight,
                TextDivider(text: tr(LocaleKeys.or_sign)),
                StylesApp.instance.paddingHeight,
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SocialMediaWidget(icon: Assets.iconsGoogle),
                    SocialMediaWidget(icon: Assets.iconsTwitter),
                    SocialMediaWidget(icon: Assets.iconsInstagram),
                  ],
                ).onCenter,
                StylesApp.instance.paddingHeight,
                StylesApp.instance.paddingHeight,
                StylesApp.instance.paddingHeight,
                StylesApp.instance.paddingHeight,
                myBoldText(
                  style: StylesApp.instance.styleMyBoldText.copyWith(
                    color: StylesApp.instance.mainColor,
                    decoration: TextDecoration.underline,
                  ),
                  txt: tr(LocaleKeys.skip_login),
                ).bottomCenter,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
