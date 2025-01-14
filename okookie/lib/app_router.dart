import 'package:auto_route/auto_route.dart';
import 'package:okookie/app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen|Page,Route')
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => const RouteType.cupertino();
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: LandingRoute.page),
        AutoRoute(page: LoginRoute.page, initial: true),
        AutoRoute(page: MainControlRoute.page),
      ];
}
