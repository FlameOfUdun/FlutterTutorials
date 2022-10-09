import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StateProviderExamplePage extends StatelessWidget {
  const StateProviderExamplePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('StateProvider Example'),
      ),
      body: const Center(
        child: FirstWidget(),
      ),
    );
  }
}

final StateProvider<int> _countProvider = StateProvider((ref) => 0);

class FirstWidget extends ConsumerWidget {
  const FirstWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int count = ref.watch(_countProvider);

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
              onPressed: () => ref.read(_countProvider.notifier).update((state) => state + 1),
              child: const Text('Increment'),
            ),
            const SizedBox(width: 16),
            ElevatedButton(
              onPressed: () => ref.read(_countProvider.notifier).update((state) => state - 1),
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
    controller.text = ref.read(_countProvider).toString();
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
            ref.read(_countProvider.notifier).update((state) => count);
          },
          child: const Text('Update'),
        ),
      ],
    );
  }
}
