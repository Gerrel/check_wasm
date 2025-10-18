import 'package:check_wasm/platform_info.dart';

class FakePlatformInfo implements PlatformInfo {
  const FakePlatformInfo(this.isWeb);
  @override
  final bool isWeb;
}
