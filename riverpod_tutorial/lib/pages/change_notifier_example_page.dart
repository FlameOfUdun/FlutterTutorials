import 'package:flutter/material.dart';

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

class ChangeNotifierExamplePage extends StatelessWidget {
  const ChangeNotifierExamplePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ChangeNotifier Example'),
      ),
      body: const Center(
        child: FirstWidget(),
      ),
    );
  }
}

class FirstWidget extends StatefulWidget {
  const FirstWidget({Key? key}) : super(key: key);

  @override
  State<FirstWidget> createState() => _FirstWidgetState();
}

class _FirstWidgetState extends State<FirstWidget> {
  final CountNotifier countNotifier = CountNotifier();

  int count = 0;

  void countListener() {
    setState(() {
      count = countNotifier.count;
    });
  }

  @override
  void initState() {
    countNotifier.addListener(countListener);
    super.initState();
  }

  @override
  void dispose() {
    countNotifier.removeListener(countListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Count: $count'),
        const SizedBox(height: 16),
        SecondWidget(
          countNotifier: countNotifier,
        ),
      ],
    );
  }
}

class SecondWidget extends StatelessWidget {
  final CountNotifier countNotifier;

  const SecondWidget({
    Key? key,
    required this.countNotifier,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: countNotifier.increment,
              child: const Text('Increment'),
            ),
            const SizedBox(width: 16),
            ElevatedButton(
              onPressed: countNotifier.decrement,
              child: const Text('Decrement'),
            ),
          ],
        ),
        const SizedBox(height: 16),
        ThirdWidget(
          countNotifier: countNotifier,
        ),
      ],
    );
  }
}

class ThirdWidget extends StatefulWidget {
  final CountNotifier countNotifier;

  const ThirdWidget({
    Key? key,
    required this.countNotifier,
  }) : super(key: key);

  @override
  State<ThirdWidget> createState() => _ThirdWidgetState();
}

class _ThirdWidgetState extends State<ThirdWidget> {
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller.text = widget.countNotifier.count.toString();
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
            widget.countNotifier.update(count);
          },
          child: const Text('Update'),
        ),
      ],
    );
  }
}
