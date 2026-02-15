import 'package:flutter/material.dart';

void main() {
  runApp(const CounterApp());
}

class CounterApp extends StatelessWidget {
  const CounterApp({super.key});

  // This is the top-level widget for the whole app.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CW01 Counter',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // This is the number we show on the screen.
  int _counter = 0; // Start at 0

  // This is how much the counter changes when you press Increment/Decrement.
  int _step = 1; // Default step is +1 / -1

  void _setStep(int newStep) {
    // When the user chooses a step (+1, +5, +10), we remember it for future taps.
    setState(() => _step = newStep);
  }

  void _incrementCounter() {
    // When the user taps Increment, we add the current step and refresh the UI.
    setState(() {
      _counter += _step;
    });
  }

  void _decrementCounter() {
    // When the user taps Decrement, we subtract the step, but never go below 0.
    setState(() {
      _counter -= _step;
      if (_counter < 0) _counter = 0;
    });
  }

  void _resetCounter() {
    // Reset brings the counter back to 0.
    setState(() => _counter = 0);
  }

  @override
  Widget build(BuildContext context) {
    final bool canDecrement = _counter > 0;
    final bool canReset = _counter > 0;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('CW01 Counter'),
      ),
      body: Center(
        // Scaffold -> Center -> Column -> [Counter, StepControls, Buttons]
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '$_counter', // Display the current counter value
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 12),
            // Step selection controls: the user picks how big each change is.
            Wrap(
              spacing: 8,
              runSpacing: 8,
              alignment: WrapAlignment.center,
              children: [
                ChoiceChip(
                  label: const Text('+1'),
                  selected: _step == 1,
                  onSelected: (_) => _setStep(1),
                ),
                ChoiceChip(
                  label: const Text('+5'),
                  selected: _step == 5,
                  onSelected: (_) => _setStep(5),
                ),
                ChoiceChip(
                  label: const Text('+10'),
                  selected: _step == 10,
                  onSelected: (_) => _setStep(10),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: _incrementCounter,
              child: Text('Increment (+$_step)'),
            ),
            const SizedBox(height: 8),
            // Decrement and Reset are disabled when the counter is already 0.
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                OutlinedButton(
                  onPressed: canDecrement ? _decrementCounter : null,
                  child: Text('Decrement (-$_step)'),
                ),
                const SizedBox(width: 12),
                TextButton(
                  onPressed: canReset ? _resetCounter : null,
                  child: const Text('Reset'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
