import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CountNotifier extends ChangeNotifier {
  int count = 0;

  void increment() {
    count++;
    notifyListeners();
  }

  void decrement() {
    count--;
    notifyListeners();
  }

  void update(int value) {
    count = value;
    notifyListeners();
  }
}

final ChangeNotifierProvider<CountNotifier> _countNotifierProvider = ChangeNotifierProvider((ref) => CountNotifier());

class ChangeNotifierProviderExamplePage extends StatelessWidget {
  const ChangeNotifierProviderExamplePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ChangeNotifierProvider Example'),
      ),
      body: const Center(
        child: FirstWidget(),
      ),
    );
  }
}

class FirstWidget extends ConsumerWidget {
  const FirstWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int count = ref.watch(_countNotifierProvider).count;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Count: $count'),
        const SizedBox(height: 16),
        const SecondWidget(),
      ],
    );
  }
}

class SecondWidget extends ConsumerWidget {
  const SecondWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: ref.read(_countNotifierProvider).increment,
              child: const Text('Increment'),
            ),
            const SizedBox(width: 16),
            ElevatedButton(
              onPressed: ref.read(_countNotifierProvider).decrement,
              child: const Text('Decrement'),
            ),
          ],
        ),
        const SizedBox(height: 16),
        const ThirdWidget(),
      ],
    );
  }
}

class ThirdWidget extends ConsumerStatefulWidget {
  const ThirdWidget({Key? key}) : super(key: key);

  @override
  ConsumerState<ThirdWidget> createState() => _ThirdWidgetState();
}

class _ThirdWidgetState extends ConsumerState<ThirdWidget> {
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller.text = ref.read(_countNotifierProvider).count.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 250,
          child: TextFormField(
            controller: controller,
          ),
        ),
        ElevatedButton(
          onPressed: () {
            int? count = int.tryParse(controller.text);
            if (count == null) return;
            ref.read(_countNotifierProvider).update(count);
          },
          child: const Text('Update'),
        ),
      ],
    );
  }
}
