import 'package:flutter/foundation.dart';

void logger(Object? object) {
  if (kDebugMode) {
    print(object);
  }
}