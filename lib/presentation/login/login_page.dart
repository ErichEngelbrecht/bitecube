import 'package:auto_route/auto_route.dart';
import 'package:bitecube/app/view/router.gr.dart';
import 'package:bitecube/application/account/account_bloc.dart';
import 'package:bitecube/l10n/l10n.dart';
import 'package:bitecube/ui_kit/buttons/bitecube_button.dart';
import 'package:bitecube/ui_kit/scaffold/bitecube_scaffold.dart';
import 'package:bitecube/ui_kit/snack_bar/bitecube_snack_bar.dart';
import 'package:bitecube/ui_kit/text_fields/bitecube_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null && context.mounted) {
        BitecubeSnackBar(context, context.l10n.logged_in).show();
        context.router.replaceAll(
          [const HomePageRoute()],
          updateExistingRoutes: false,
        );
      }
    });

    var email = '';
    var password = '';

    return BitecubeScaffold(
      title: context.l10n.loginAppBarTitle,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BitecubeTextField(
              onChanged: (text) => email = text,
              label: context.l10n.email,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: BitecubeTextField(
                onChanged: (text) => password = text,
                label: context.l10n.password,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BitecubeButton(
                    child: Text(context.l10n.loginAppBarTitle),
                    onPressed: () => context.read<AccountBloc>().add(
                          AccountEvent.onLogIn(
                            email: email,
                            password: password,
                          ),
                        ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: BitecubeButton(
                      child: Text(context.l10n.register),
                      onPressed: () => context.router.push(
                        const SignUpPageRoute(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
