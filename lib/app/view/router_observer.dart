import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
// import 'package:riga_analytics/riga_analytics.dart';
// import 'package:riga_core/riga_core.dart';
// import 'package:riga_models/riga_models.dart' show EventParameters;

class RouterObserver extends AutoRouterObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    // coreSl<AnalyticsBloc>().add(
    //   AnalyticsEvent.onLogEvent(
    //     event: GeneralEvents.screenView,
    //     eventParameters: EventParameters.empty().copyWith(
    //       custPageName: route.settings.name ?? '',
    //       previousPageName: previousRoute == null ? '' : previousRoute.settings.name ?? '',
    //     ),
    //   ),
    // );
  }

  @override
  Future<void> didInitTabRoute(
    TabPageRoute route,
    TabPageRoute? previousRoute,
  ) async {
    // coreSl<AnalyticsBloc>().add(
    //   AnalyticsEvent.onLogEvent(
    //     event: GeneralEvents.screenView,
    //     eventParameters: EventParameters.empty().copyWith(
    //       custPageName: route.name,
    //       previousPageName: previousRoute == null ? '' : previousRoute.name,
    //     ),
    //   ),
    // );
  }

  @override
  Future<void> didChangeTabRoute(
    TabPageRoute route,
    TabPageRoute previousRoute,
  ) async {
    // coreSl<AnalyticsBloc>().add(
    //   AnalyticsEvent.onLogEvent(
    //     event: GeneralEvents.screenView,
    //     eventParameters: EventParameters.empty().copyWith(
    //       custPageName: route.name,
    //       previousPageName: previousRoute.name,
    //     ),
    //   ),
    // );
  }
}
