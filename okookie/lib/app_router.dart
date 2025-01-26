import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:okookie/app_router.gr.dart';
import 'package:okookie/auth_guard.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen|Page,Route')
class AppRouter extends RootStackRouter {
  WidgetRef ref;

  AppRouter(this.ref) : super();
  @override
  RouteType get defaultRouteType => const RouteType.cupertino();

  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: LandingRoute.page, path: '/home'),
        AutoRoute(page: LoginRoute.page, initial: true, path: '/login'),
        AutoRoute(page: MainControlRoute.page, path: '/main'),
      ];
  @override
  @override
  late final List<AutoRouteGuard> guards = [
    AuthGuard(ref)
    // add more guards here
  ];
}
