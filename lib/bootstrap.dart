import 'dart:async';
import 'dart:developer';

import 'package:bitecube/application/account/account_bloc.dart';
import 'package:bitecube/application/analytics/analytics_bloc.dart';
import 'package:bitecube/application/store/store_bloc.dart';
import 'package:bitecube/firebase_options.dart';
import 'package:bitecube/repositories/implementations/account/account_repository.dart';
import 'package:bitecube/repositories/implementations/analytics/analytics_repository.dart';
import 'package:bitecube/repositories/implementations/store/store_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBlocObserver extends BlocObserver {
  const AppBlocObserver();

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    log('onChange(${bloc.runtimeType}, $change)');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    log('onError(${bloc.runtimeType}, $error, $stackTrace)');
    super.onError(bloc, error, stackTrace);
  }
}

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Bloc.observer = const AppBlocObserver();

  runApp(
    MaterialApp(
      home: MultiBlocProvider(
        providers: [
          BlocProvider<AccountBloc>(
            create: (BuildContext context) => AccountBloc(AccountRepository()),
          ),
          BlocProvider<StoreBloc>(
            create: (BuildContext context) => StoreBloc(StoreRepository()),
          ),
          BlocProvider<AnalyticsBloc>(
            create: (BuildContext context) =>
                AnalyticsBloc(AnalyticsRepository()),
          ),
        ],
        child: await builder(),
      ),
    ),
  );
}
