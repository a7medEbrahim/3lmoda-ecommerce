import 'package:flutter/foundation.dart';

class Functions {
  static myPrintX(object) async {
    if (!kReleaseMode) print(object);
  }
}
