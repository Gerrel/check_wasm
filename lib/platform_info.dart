import 'package:flutter/foundation.dart';

abstract class PlatformInfo {
  bool get isWeb;
}

final class DefaultPlatformInfo implements PlatformInfo {
  const DefaultPlatformInfo();
  @override
  final bool isWeb = kIsWeb;
}
