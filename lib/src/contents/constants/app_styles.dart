import 'package:flutter/material.dart';

import 'app_colors.dart';

/// This contains the Styles [Text] used in the app
///
/// This becomes very useful when I want add theming
class AppStyles {
  static const heading4 = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w900,
    color: AppColors.onSurface,
  );

  static const heading6 = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.w700,
  );

  static const bodyText1 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
  );
}
