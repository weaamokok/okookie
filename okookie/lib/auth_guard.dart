import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:okookie/app_router.gr.dart';
import 'package:okookie/features/login/login_deps.dart';

class AuthGuard extends AutoRouteGuard {
  final WidgetRef ref;

  AuthGuard(this.ref);

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    AuthStatus? user = await ref.watch(LoginDeps.authProvider.notifier).state;

    if (user == AuthStatus.authenticated) {
      resolver.next(true);
    } else {
      router.push(const LoginRoute());
    }
  }
}
