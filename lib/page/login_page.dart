import 'dart:io';

import 'package:bookand/config/theme/custom_text_style.dart';
import 'package:bookand/page/terms_page.dart';
import 'package:bookand/provider/user_me_provider.dart';
import 'package:bookand/widget/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../widget/social_login_button.dart';
import '../data/model/social_token.dart';
import '../util/logger.dart';
import 'main_tab.dart';

class LoginPage extends ConsumerWidget with CustomDialog {
  static String get routeName => 'login';

  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(userMeProvider.notifier);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
          child: IgnorePointer(
        ignoring: state.isLoading,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset('assets/images/ic_logo.svg', width: 61, height: 70),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 110),
                child: Text(
                  AppLocalizations.of(context)!.appName,
                  style: const TextStyle().logoText(),
                ),
              ),
              Platform.isIOS
                  ? Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: SocialLoginButton(
                          onTap: () {},
                          image:
                              SvgPicture.asset('assets/images/ic_apple.svg', width: 24, height: 24),
                          text: Text(AppLocalizations.of(context)!.appleSocial,
                              style: const TextStyle().appleLoginText())))
                  : const SizedBox(),
              SocialLoginButton(
                  onTap: () {
                    state.googleLogin().then((value) {
                      if (state.isSigned) {
                        context.replaceNamed(MainTab.routeName);
                      } else {
                        context.goNamed(TermsPage.routeName, extra: value as SocialToken);
                      }
                    }).catchError((e) {
                      logger.e(e);
                      if (e is SocialTokenError) {
                        showOneBtnDialog(context: context, content: e.message);
                      }
                    });
                  },
                  image: SvgPicture.asset('assets/images/ic_google.svg', width: 24, height: 24),
                  text: Text(AppLocalizations.of(context)!.googleSocial,
                      style: const TextStyle().googleLoginText()))
            ],
          ),
        ),
      )),
    );
  }
}