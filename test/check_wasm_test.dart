import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:check_wasm/check_wasm.dart';

import 'fake_platform_info.dart';

void main() {
  testWidgets('enabled', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    final childKey = const Key('child');
    await tester.pumpWidget(
      MaterialApp(
        home: CheckWasm(
          platformInfo: const FakePlatformInfo(true),
          child: Container(key: childKey),
        ),
      ),
    );

    expect(find.byKey(const Key('check_wasm_scaffold')), findsOneWidget);
    expect(find.byKey(childKey), findsOneWidget);
  });

  testWidgets('disabled', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    final childKey = const Key('child');
    await tester.pumpWidget(
      MaterialApp(
        home: CheckWasm(
          enabled: false,
          platformInfo: const FakePlatformInfo(true),
          child: Container(key: childKey),
        ),
      ),
    );

    expect(find.byKey(const Key('check_wasm_scaffold')), findsNothing);
    expect(find.byKey(childKey), findsOneWidget);
  });

  testWidgets('no web enabled', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    final childKey = const Key('child');
    await tester.pumpWidget(
      MaterialApp(
        home: CheckWasm(
          platformInfo: const FakePlatformInfo(false),
          child: Container(key: childKey),
        ),
      ),
    );

    expect(find.byKey(const Key('check_wasm_scaffold')), findsNothing);
    expect(find.byKey(childKey), findsOneWidget);
  });

  testWidgets('no web disabled', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    final childKey = const Key('child');
    await tester.pumpWidget(
      MaterialApp(
        home: CheckWasm(
          enabled: false,
          platformInfo: const FakePlatformInfo(false),
          child: Container(key: childKey),
        ),
      ),
    );

    expect(find.byKey(const Key('check_wasm_scaffold')), findsNothing);
    expect(find.byKey(childKey), findsOneWidget);
  });
}
