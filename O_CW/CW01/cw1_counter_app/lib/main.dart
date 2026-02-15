import 'package:flutter/material.dart';

void main() {
  runApp(const CounterApp());
}

class CounterApp extends StatefulWidget {
  const CounterApp({super.key});

  @override
  State<CounterApp> createState() => _CounterAppState();
}

class _CounterAppState extends State<CounterApp> {
  // This controls whether the entire app is in Light mode or Dark mode.
  bool _isDark = false;

  void _toggleTheme() {
    // When the user taps the theme button, we flip between Light and Dark mode.
    setState(() => _isDark = !_isDark);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CW01 Counter',
      themeMode: _isDark ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: HomePage(
        isDark: _isDark,
        onToggleTheme: _toggleTheme,
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
    required this.isDark,
    required this.onToggleTheme,
  });

  // True when the app is currently using the dark theme.
  final bool isDark;

  // Called when the user taps the theme toggle button.
  final VoidCallback onToggleTheme;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  // This is the number we show on the screen.
  int _counter = 0; // Start at 0

  // This is how much the counter changes when you press Increment/Decrement.
  int _step = 1; // Default step is +1 / -1

  // This decides which image is currently shown.
  bool _isFirstImage = true;

  // Prevents spamming the toggle button while the animation is running.
  bool _isImageAnimating = false;

  // These drive the fade animation when we switch images.
  late final AnimationController _controller;
  late final Animation<double> _fade;

  @override
  void initState() {
    super.initState();

    // Create an animation controller that runs for half a second.
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    // We use an ease-in-out curve so the fade looks smooth.
    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);

    // Start fully visible so the first image shows immediately.
    _controller.value = 1.0;
  }

  @override
  void dispose() {
    // Always dispose animation controllers to avoid memory leaks.
    _controller.dispose();
    super.dispose();
  }

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

  Future<void> _toggleImage() async {
    // When the user toggles the image:
    // 1) Fade out the current image
    // 2) Swap which asset we show
    // 3) Fade the new image back in
    if (_isImageAnimating) return;

    setState(() => _isImageAnimating = true);
    await _controller.reverse();
    setState(() => _isFirstImage = !_isFirstImage);
    await _controller.forward();
    setState(() => _isImageAnimating = false);
  }

  @override
  Widget build(BuildContext context) {
    final bool canDecrement = _counter > 0;
    final bool canReset = _counter > 0;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('CW01 Counter'),
        actions: [
          // This button toggles the entire app between Light and Dark mode.
          IconButton(
            onPressed: widget.onToggleTheme,
            icon: Icon(widget.isDark ? Icons.light_mode : Icons.dark_mode),
            tooltip: widget.isDark ? 'Switch to Light mode' : 'Switch to Dark mode',
          ),
        ],
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
            const SizedBox(height: 24),
            // The image fades between two local assets when toggled.
            FadeTransition(
              opacity: _fade,
              child: Image.asset(
                _isFirstImage ? 'assets/image1.png' : 'assets/image2.png',
                width: 180,
                height: 180,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: _isImageAnimating ? null : _toggleImage,
              child: const Text('Toggle Image'),
            ),
          ],
        ),
      ),
    );
  }
}
