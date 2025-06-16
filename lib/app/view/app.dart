import 'package:auto_route/auto_route.dart';
import 'package:bitecube/app/view/router.dart';
import 'package:bitecube/app/view/router_observer.dart';
import 'package:bitecube/l10n/arb/app_localizations.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({required this.appRouter, super.key});

  final AppRouter appRouter;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      routeInformationParser: appRouter.defaultRouteParser(),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routerDelegate: appRouter.delegate(
        navigatorObservers: () => <NavigatorObserver>[
          RouterObserver(),
          AutoRouteObserver(),
        ],
      ),
    );
  }
}
