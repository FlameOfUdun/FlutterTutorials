import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'pages/state_notifier_provider_example_page.dart';


void main() {
  runApp(const _Application());
}

class _Application extends StatelessWidget {
  const _Application({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        title: 'Riverpod Tutorial',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const StateNotifierProviderExamplePage(),
      ),
    );
  }
}

