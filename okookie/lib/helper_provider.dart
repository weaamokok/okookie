import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';

class HelperProvider {
  static final screenTypeProvider =
      ProviderFamily<ScreenType, ({BuildContext? context, Size? size})>(
    (ref, arg) {
      // Get screen width
      final width = arg.size;
      final screenWidth = width != null
          ? width.width
          : arg.context != null
              ? MediaQuery.of(arg.context!).size.width
              : 600;
      print('screenWidth: $screenWidth');
      print('width: $width');
      if (screenWidth < 600) {
        // Small screen (phone)
        return ScreenType.phone;
      } else if (screenWidth < 1024) {
        // Medium screen (tablet)
        return ScreenType.tablet;
      } else {
        // Large screen (laptop/desktop)
        return ScreenType.laptop;
      }
    },
  );
}

enum ScreenType { phone, tablet, laptop }
