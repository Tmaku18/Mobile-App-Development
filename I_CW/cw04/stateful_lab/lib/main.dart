import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stateful Lab',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: CounterWidget(),
    );
  }
}

class CounterWidget extends StatefulWidget {
  @override
  _CounterWidgetState createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  int _counter = 0;
  // How much we add/subtract each button press (the user picks 1, 5, or 10).
  int _step = 1;

  // We keep a small history so the user can undo recent changes (up to 10).
  final List<int> _history = [];

  static const int _maxHistory = 10;

  void _pushHistory(int value) {
    setState(() {
      _history.add(value);
      if (_history.length > _maxHistory) _history.removeAt(0);
    });
  }

  void _undo() {
    if (_history.isEmpty) return;
    setState(() {
      _counter = _history.removeLast();
    });
  }

  Color _colorForValue(int value) {
    if (value <= 33) return Colors.red.shade400;
    if (value <= 66) return Colors.amber.shade600;
    return Colors.green.shade600;
  }

  @override
  Widget build(BuildContext context) {
    final counterColor = _colorForValue(_counter);
    return Scaffold(
      appBar: AppBar(title: Text('Interactive Counter')),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 24),
            Center(
              child: Container(
                color: counterColor.withOpacity(0.25),
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 24),
                child: Text(
                  '$_counter',
                  style: TextStyle(
                    fontSize: 56.0,
                    fontWeight: FontWeight.bold,
                    color: counterColor,
                  ),
                ),
              ),
            ),
            SizedBox(height: 24),
            Slider(
              min: 0,
              max: 100,
              value: _counter.clamp(0, 100).toDouble(),
              onChanged: (double value) {
                // Store the previous value before updating so Undo can restore it.
                _pushHistory(_counter);
                setState(() => _counter = value.round());
              },
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Step: ', style: TextStyle(fontSize: 16)),
                  // Tapping a chip changes the step size used by +/- buttons.
                  ...([1, 5, 10].map(
                    (s) => Padding(
                      padding: EdgeInsets.only(right: 8),
                      child: ChoiceChip(
                        label: Text('$s'),
                        selected: _step == s,
                        onSelected: (selected) => setState(() => _step = s),
                      ),
                    ),
                  )),
                ],
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _pushHistory(_counter);
                    setState(() => _counter = (_counter + _step).clamp(0, 100));
                  },
                  child: Text('+$_step'),
                ),
                SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () {
                    _pushHistory(_counter);
                    setState(() {
                      _counter = (_counter - _step).clamp(0, 100);
                    });
                  },
                  child: Text('-$_step'),
                ),
                SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () {
                    _pushHistory(_counter);
                    setState(() => _counter = 0);
                  },
                  child: Text('Reset'),
                ),
                SizedBox(width: 16),
                ElevatedButton(
                  onPressed: _history.isEmpty ? null : _undo,
                  child: Text('Undo'),
                ),
              ],
            ),
            if (_history.isNotEmpty) ...[
              SizedBox(height: 12),
              Text(
                'Undo stack: ${_history.length}',
                style: TextStyle(
                  fontSize: 12,
                  color: Theme.of(context).textTheme.bodySmall?.color,
                ),
              ),
            ],
            SizedBox(height: 48),
          ],
        ),
      ),
    );
  }
}
