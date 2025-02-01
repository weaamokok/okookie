// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i6;
import 'package:okookie/features/control_panel/add_item_screen.dart' as _i1;
import 'package:okookie/features/control_panel/home_screen.dart' as _i2;
import 'package:okookie/features/control_panel/main_control_screen.dart' as _i5;
import 'package:okookie/features/landing_screen.dart' as _i3;
import 'package:okookie/features/login/login_screen.dart' as _i4;

/// generated route for
/// [_i1.AddItemScreen]
class AddItemRoute extends _i6.PageRouteInfo<void> {
  const AddItemRoute({List<_i6.PageRouteInfo>? children})
      : super(
          AddItemRoute.name,
          initialChildren: children,
        );

  static const String name = 'AddItemRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      return  _i1.AddItemScreen();
    },
  );
}

/// generated route for
/// [_i2.HomeScreen]
class HomeRoute extends _i6.PageRouteInfo<void> {
  const HomeRoute({List<_i6.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      return const _i2.HomeScreen();
    },
  );
}

/// generated route for
/// [_i3.LandingScreen]
class LandingRoute extends _i6.PageRouteInfo<void> {
  const LandingRoute({List<_i6.PageRouteInfo>? children})
      : super(
          LandingRoute.name,
          initialChildren: children,
        );

  static const String name = 'LandingRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      return const _i3.LandingScreen();
    },
  );
}

/// generated route for
/// [_i4.LoginScreen]
class LoginRoute extends _i6.PageRouteInfo<void> {
  const LoginRoute({List<_i6.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      return const _i4.LoginScreen();
    },
  );
}

/// generated route for
/// [_i5.MainControlScreen]
class MainControlRoute extends _i6.PageRouteInfo<void> {
  const MainControlRoute({List<_i6.PageRouteInfo>? children})
      : super(
          MainControlRoute.name,
          initialChildren: children,
        );

  static const String name = 'MainControlRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      return const _i5.MainControlScreen();
    },
  );
}
