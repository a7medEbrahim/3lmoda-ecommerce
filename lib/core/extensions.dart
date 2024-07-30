import 'package:flutter/material.dart';

extension BuildContextExt on BuildContext {
  ColorScheme get colorS {
    return Theme.of(this).colorScheme;
  }

// double get sizeW {
//   return MediaQuery.of(this).size.width;
// }
//
// bool get isMobile {
//   return sizeW <= 650;
// }
//
// bool get isTablet {
//   return sizeW < 1200 && sizeW > 650;
// }
//
// bool get isDesktop {
//   return sizeW >= 1200;
// }
}

extension ColorExt on Color {
  ColorFilter get svgColor {
    return ColorFilter.mode(this, BlendMode.srcIn);
  }
}

extension Ex on double {
  double toPrecision(int n) => double.parse(toStringAsFixed(n));
}
