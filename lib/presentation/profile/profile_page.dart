import 'package:auto_route/auto_route.dart';
import 'package:bitecube/app/view/router.gr.dart';
import 'package:bitecube/application/account/account_bloc.dart';
import 'package:bitecube/l10n/l10n.dart';
import 'package:bitecube/ui_kit/buttons/bitecube_button.dart';
import 'package:bitecube/ui_kit/scaffold/bitecube_scaffold.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AccountBloc, AccountState>(
      listener: (BuildContext context, state) {
        if (!state.isLoading && FirebaseAuth.instance.currentUser == null) {
          context.router.replaceAll([
            const LoginPageRoute(),
          ]);
        }
      },
      child: BitecubeScaffold(
        title: context.l10n.profileAppBarTitle,
        footerButtons: [
          BitecubeButton(
            child: Text(context.l10n.log_out),
            onPressed: () {
              context.read<AccountBloc>().add(
                    const AccountEvent.onLogOut(),
                  );
            },
          ),
        ],
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${context.l10n.email}:',
                style: const TextStyle(fontSize: 28),
              ),
              Text(
                FirebaseAuth.instance.currentUser?.email ?? '',
                style: const TextStyle(fontSize: 28),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text(
                  '${context.l10n.name}:',
                  style: const TextStyle(fontSize: 28),
                ),
              ),
              Text(
                FirebaseAuth.instance.currentUser?.displayName ?? '',
                style: const TextStyle(fontSize: 28),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
