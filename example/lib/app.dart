import 'package:check_wasm/check_wasm.dart';
import 'package:flutter/material.dart';
import 'package:check_wasm_example/screens/example_screen.dart';

/// The example app widget
class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: CheckWasm(child: ExampleScreen()),
    );
  }
}
