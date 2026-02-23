import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rocket Launch Controller',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: CounterWidget(),
    );
  }
}

class CounterWidget extends StatefulWidget {
  const CounterWidget({super.key});

  @override
  State<CounterWidget> createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  static const int _minCounter = 0;
  static const int _maxCounter = 100;

  int _counter = 0;
  bool _hasShownLiftoffDialog = false;

  int _clampCounter(int value) => value.clamp(_minCounter, _maxCounter);

  Color _statusColorFor(int value) {
    if (value == 0) return Colors.red;
    if (value <= 50) return Colors.orange;
    return Colors.green;
  }

  void _setCounter(int value) {
    final next = _clampCounter(value);
    final shouldResetDialogFlag = next < _maxCounter;
    final shouldShowDialog = next == _maxCounter && !_hasShownLiftoffDialog;

    setState(() {
      _counter = next;

      if (shouldResetDialogFlag) {
        _hasShownLiftoffDialog = false;
      } else if (shouldShowDialog) {
        _hasShownLiftoffDialog = true;
      }
    });

    if (shouldShowDialog) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;

        showDialog<void>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Launch Successful'),
            content: const Text('LIFTOFF! The rocket has launched.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      });
    }
  }

  void _ignite() {
    _setCounter(_counter + 1);
  }

  void _decrement() {
    _setCounter(_counter - 1);
  }

  void _reset() {
    _setCounter(0);
  }

  @override
  Widget build(BuildContext context) {
    final statusColor = _statusColorFor(_counter);
    final displayText = _counter == _maxCounter ? 'LIFTOFF!' : '$_counter';

    return Scaffold(
      appBar: AppBar(title: const Text('Rocket Launch Controller')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                displayText,
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  color: statusColor,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Slider(
              min: _minCounter.toDouble(),
              max: _maxCounter.toDouble(),
              value: _counter.toDouble(),
              onChanged: (double value) {
                _setCounter(value.round());
              },
              activeColor: Colors.blue,
              inactiveColor: Colors.red,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _counter >= _maxCounter ? null : _ignite,
                  child: const Text('Ignite'),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: _counter <= _minCounter ? null : _decrement,
                  child: const Text('Decrement'),
                ),
                const SizedBox(width: 12),
                OutlinedButton(
                  onPressed: _reset,
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
