import 'package:flutter/material.dart';

class NativeExamplePage extends StatelessWidget {
  const NativeExamplePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Native Example'),
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
  int count = 0;

  void increment() {
    setState(() {
      count++;
    });
  }

  void decrement() {
    setState(() {
      count--;
    });
  }

  void update(int value) {
    setState(() {
      count = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Count: $count'),
        const SizedBox(height: 16),
        SecondWidget(
          count: count,
          increment: increment,
          decrement: decrement,
          update: update,
        ),
      ],
    );
  }
}

class SecondWidget extends StatelessWidget {
  final int count;
  final VoidCallback increment;
  final VoidCallback decrement;
  final ValueChanged<int> update;

  const SecondWidget({
    Key? key,
    required this.count,
    required this.increment,
    required this.decrement,
    required this.update,
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
              onPressed: increment,
              child: const Text('Increment'),
            ),
            const SizedBox(width: 16),
            ElevatedButton(
              onPressed: decrement,
              child: const Text('Decrement'),
            ),
          ],
        ),
        const SizedBox(height: 16),
        ThirdWidget(
          count: count,
          update: update,
        ),
      ],
    );
  }
}

class ThirdWidget extends StatefulWidget {
  final int count;
  final ValueChanged<int> update;

  const ThirdWidget({
    Key? key,
    required this.count,
    required this.update,
  }) : super(key: key);

  @override
  State<ThirdWidget> createState() => _ThirdWidgetState();
}

class _ThirdWidgetState extends State<ThirdWidget> {
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller.text = widget.count.toString();
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
            widget.update(count);
          },
          child: const Text('Update'),
        ),
      ],
    );
  }
}
