import 'package:flutter/foundation.dart';

/// An interface for providing platform-specific information.
///
/// This interface is used to abstract platform-specific checks, making it easier
/// to test code that depends on platform information.
abstract class PlatformInfo {
  /// Returns true if the application is running in a web browser.
  bool get isWeb;
}

/// The default implementation of [PlatformInfo] that uses Flutter's built-in platform detection.
final class DefaultPlatformInfo implements PlatformInfo {
  /// Creates a constant instance of [DefaultPlatformInfo].
  const DefaultPlatformInfo();
  @override
  final bool isWeb = kIsWeb;
}
