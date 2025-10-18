import 'package:flutter/material.dart';

/// The example screen which uses KeyboardAutoDismiss
/// and KeyboardService for demonstration.
class ExampleScreen extends StatefulWidget {
  /// Simple widget with input field and button
  /// to dismiss the keyboard.
  const ExampleScreen({
    Key? key,
  }) : super(key: key);

  @override
  ExampleScreenState createState() => ExampleScreenState();
}

/// State for ExampleScreen
class ExampleScreenState extends State<ExampleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Check WASM Example'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Text('Hello World!'),
          ],
        ),
      ),
    );
  }
}
