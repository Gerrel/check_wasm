import 'package:check_wasm/platform_info.dart';
import 'package:flutter/material.dart';
import 'package:check_wasm/check_wasm_stub.dart'
    if (dart.library.js) 'check_wasm_web.dart';
import 'package:http/http.dart' as http;

class CheckWasm extends StatefulWidget {
  const CheckWasm({
    required this.child,
    this.enabled = true,
    this.platformInfo = const DefaultPlatformInfo(),
    super.key,
  });

  final Widget child;
  final bool enabled;
  final PlatformInfo platformInfo;

  @override
  State<StatefulWidget> createState() => CheckWasmState();
}

class CheckWasmState extends State<CheckWasm> {
  var _showWasmMessage = false;
  var _showMtMessage = false;

  late final Future<bool> _hasMultipleThreadsSupport;
  final hasWasm = const bool.fromEnvironment('dart.tool.dart2wasm');

  @override
  void initState() {
    super.initState();
    if (widget.platformInfo.isWeb && widget.enabled) {
      _hasMultipleThreadsSupport = _check();
    } else {
      _hasMultipleThreadsSupport = Future.value(false);
    }
  }

  Future<bool> _check() async {
    if (!hasWasm) {
      return false;
    }
    final url = getCurrentUrl();
    final headers = await _getHeaders(url);
    return _hasMultipleThreadsSupportHeaders(headers);
  }

  Future<Map<String, String>> _getHeaders(String url) async {
    final response = await http.get(Uri.parse(url));
    return response.headers;
  }

  bool _hasMultipleThreadsSupportHeaders(Map<String, String> headers) {
    final embedder = headers['cross-origin-embedder-policy'];
    final opener = headers['cross-origin-opener-policy'];
    return (embedder == 'credentialless' || embedder == 'require-corp') &&
        opener == 'same-origin';
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.platformInfo.isWeb || !widget.enabled) {
      return widget.child;
    }
    return Scaffold(
      key: const Key('check_wasm_scaffold'),
      body: FutureBuilder(
        future: _hasMultipleThreadsSupport,
        builder: (context, snapshot) {
          var hasMt = snapshot.data;

          var hasMtColor = Colors.grey;
          if (hasMt != null) {
            hasMtColor = hasMt ? Colors.green : Colors.red;
          } else {
            hasMt = false;
          }

          return Stack(
            children: [
              widget.child,
              if (_showWasmMessage)
                Align(
                  alignment: AlignmentGeometry.bottomRight,
                  child: Container(
                    padding: const EdgeInsets.only(
                      right: 8,
                      bottom: 2,
                      left: 4,
                    ),
                    width: 400,
                    height: 200,
                    color: hasWasm ? Colors.green : Colors.red,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          hasWasm ? 'WASM' : 'NO WASM',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const Text(
                          'To run a Flutter app that has been compiled to Wasm, you need a browser that supports WasmGC. (Google Chrome)',
                        ),
                        const Text(
                          '''Chromium and V8 support WasmGC since version 119. Chrome on iOS uses WebKit, which doesn't yet support WasmGC. Firefox announced stable support for WasmGC in Firefox 120, but currently doesn't work due to a known limitation''',
                        ),
                      ],
                    ),
                  ),
                ),
              if (_showMtMessage)
                Align(
                  alignment: AlignmentGeometry.bottomRight,
                  child: Container(
                    padding: const EdgeInsets.only(
                      right: 8,
                      bottom: 2,
                      left: 4,
                    ),
                    width: 400,
                    height: 200,
                    color: hasMtColor,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          hasMt ? 'MT' : 'NO MT',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),

                        const Text(
                          '''Flutter web applications compiled with WebAssembly won't run with multiple-threads unless the server is configured to send specific HTTP headers.''',
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Cross-Origin-Embedder-Policy: credentialless or require-corp',
                        ),
                        const Text('Cross-Origin-Opener-Policy: same-origin'),
                      ],
                    ),
                  ),
                ),
              Align(
                alignment: AlignmentGeometry.bottomRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    MouseRegion(
                      onEnter: (_) {
                        setState(() {
                          _showMtMessage = true;
                        });
                      },
                      onExit: (_) {
                        setState(() {
                          _showMtMessage = false;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.only(
                          right: 8,
                          bottom: 2,
                          left: 4,
                        ),
                        color: hasMtColor,
                        child: Text(
                          hasMt ? 'MT' : 'NO MT',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const IntrinsicHeight(child: VerticalDivider()),
                    MouseRegion(
                      onEnter: (_) {
                        setState(() {
                          _showWasmMessage = true;
                        });
                      },
                      onExit: (_) {
                        setState(() {
                          _showWasmMessage = false;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.only(
                          right: 8,
                          bottom: 2,
                          left: 4,
                        ),
                        color: hasWasm ? Colors.green : Colors.red,
                        child: Text(
                          hasWasm ? 'WASM' : 'NO WASM',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
