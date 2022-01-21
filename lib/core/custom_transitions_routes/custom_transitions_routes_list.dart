import 'package:flutter/material.dart';
import 'package:my_shop/core/custom_transitions_routes/custom_route.dart';

class CustomTransitionsRouteList {
  final pageTransitionsTheme = PageTransitionsTheme(
    builders: {
      TargetPlatform.android: CustomPageTransitionsBuilder(),
      TargetPlatform.iOS: CustomPageTransitionsBuilder()
    },
  );
}
