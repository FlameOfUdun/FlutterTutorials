import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@immutable
class CountState {
  final int count;
  final DateTime? time;

  const CountState({
    this.count = 0,
    this.time,
  });
}

class CountNotifier extends StateNotifier<CountState> {
  CountNotifier() : super(const CountState());

  void increment() {
    state = CountState(
      count: state.count + 1,
      time: DateTime.now(),
    );
  }

  void decrement() {
    state = CountState(
      count: state.count - 1,
      time: DateTime.now(),
    );
  }

  void update(int value) {
    state = CountState(
      count: value,
      time: DateTime.now(),
    );
  }
}

final StateNotifierProvider<CountNotifier, CountState> _countNotifierProvider = StateNotifierProvider((ref) => CountNotifier());

class StateNotifierProviderExamplePage extends StatelessWidget {
  const StateNotifierProviderExamplePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('StateNotifierProvider Example'),
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
              onPressed: () => ref.read(_countNotifierProvider.notifier).increment(),
              child: const Text('Increment'),
            ),
            const SizedBox(width: 16),
            ElevatedButton(
              onPressed: () => ref.read(_countNotifierProvider.notifier).decrement(),
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
            ref.read(_countNotifierProvider.notifier).update(count);
          },
          child: const Text('Update'),
        ),
      ],
    );
  }
}
