// ignore_for_file: inference_failure_on_instance_creation

import 'package:auto_route/auto_route.dart';
import 'package:bitecube/app/view/router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route,Screen')
class AppRouter extends RootStackRouter {
  AppRouter() : super();

  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          path: '/login',
          page: LoginPageRoute.page,
          // TODO: Uncomment 'initial: true' to enable logging in (online mode)
          initial: true,
        ),
        AutoRoute(
          path: '/home',
          page: HomePageRoute.page,
          // TODO: Comment out 'initial: true' to enable logging in (online mode)
          // initial: true,
        ),
        AutoRoute(
          path: '/signUp',
          page: SignUpPageRoute.page,
        ),
        AutoRoute(
          path: '/statistics',
          page: StatisticsPageRoute.page,
        ),
        AutoRoute(
          path: '/profile',
          page: ProfilePageRoute.page,
        ),
      ];
}
