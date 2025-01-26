// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i5;
import 'package:okookie/features/control_panel/add_item_screen.dart' as _i1;
import 'package:okookie/features/control_panel/main_control_screen.dart' as _i4;
import 'package:okookie/features/landing_screen.dart' as _i2;
import 'package:okookie/features/login/login_screen.dart' as _i3;

/// generated route for
/// [_i1.AddItemScreen]
class AddItemRoute extends _i5.PageRouteInfo<void> {
  const AddItemRoute({List<_i5.PageRouteInfo>? children})
      : super(
          AddItemRoute.name,
          initialChildren: children,
        );

  static const String name = 'AddItemRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i1.AddItemScreen();
    },
  );
}

/// generated route for
/// [_i2.LandingScreen]
class LandingRoute extends _i5.PageRouteInfo<void> {
  const LandingRoute({List<_i5.PageRouteInfo>? children})
      : super(
          LandingRoute.name,
          initialChildren: children,
        );

  static const String name = 'LandingRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i2.LandingScreen();
    },
  );
}

/// generated route for
/// [_i3.LoginScreen]
class LoginRoute extends _i5.PageRouteInfo<void> {
  const LoginRoute({List<_i5.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i3.LoginScreen();
    },
  );
}

/// generated route for
/// [_i4.MainControlScreen]
class MainControlRoute extends _i5.PageRouteInfo<void> {
  const MainControlRoute({List<_i5.PageRouteInfo>? children})
      : super(
          MainControlRoute.name,
          initialChildren: children,
        );

  static const String name = 'MainControlRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i4.MainControlScreen();
    },
  );
}
