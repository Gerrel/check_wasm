import 'package:web/web.dart' as web;

/// Returns the current URL of the web page.
///
/// This function is only available in web environments and returns the complete URL
/// including protocol, hostname, path, and query parameters.
String getCurrentUrl() {
  return web.window.location.href;
}
