import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: DigitalPetApp()));
}

class DigitalPetApp extends StatefulWidget {
  @override
  _DigitalPetAppState createState() => _DigitalPetAppState();
}

class _DigitalPetAppState extends State<DigitalPetApp> {
  // These are the pet's core stats shown on screen.
  String petName = "Your Pet";
  int happinessLevel = 50;
  int hungerLevel = 50;
  int tiredLevel = 0;

  // Timers drive the "time passes" behavior (stats change automatically).
  Timer? _tiredTimer;
  Timer? _hungerTimer;

  // We track when happiness first crossed 80 so we can check "stayed above 80 for 3 minutes".
  DateTime? _above80Since;

  // Once the player wins/loses, we stop allowing actions and freeze the timers' effects.
  bool _gameOver = false;

  @override
  void initState() {
    super.initState();

    // Every 30 seconds, adjust tiredness over time and re-check win/loss rules.
    _tiredTimer = Timer.periodic(const Duration(seconds: 30), (_) {
      if (!mounted) return;
      setState(() {
        tiredLevel -= 10;
        if (tiredLevel < 0) tiredLevel = 0;
        _updateAbove80Since();
        _checkWinLoss();
      });
    });

    // Every 30 seconds, hunger increases automatically (which also affects happiness).
    _hungerTimer = Timer.periodic(const Duration(seconds: 30), (_) {
      if (!mounted) return;
      _updateHunger();
    });
  }

  @override
  void dispose() {
    // Always cancel timers when the widget is removed to avoid leaks/background work.
    _tiredTimer?.cancel();
    _hungerTimer?.cancel();
    super.dispose();
  }

  void _updateAbove80Since() {
    // Start (or clear) the "above 80" stopwatch depending on current happiness.
    if (happinessLevel > 80) {
      _above80Since ??= DateTime.now();
    } else {
      _above80Since = null;
    }
  }

  void _checkWinLoss() {
    if (_gameOver || !mounted) return;
    final effective = _effectiveHappiness;

    // Loss condition: if hunger is maxed out AND the pet's effective happiness is very low.
    if (hungerLevel >= 100 && effective <= 10) {
      _gameOver = true;
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (ctx) => AlertDialog(
          title: const Text('Game Over'),
          content: const Text(
            'Hunger reached 100 and happiness dropped to 10 or below.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
      return;
    }

    // Win condition: keep happiness above 80 continuously for 3 minutes.
    if (_above80Since != null &&
        DateTime.now().difference(_above80Since!) >= const Duration(minutes: 3)) {
      _gameOver = true;
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (ctx) => AlertDialog(
          title: const Text('You Win!'),
          content: const Text(
            'Happiness stayed above 80 for 3 minutes!',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  void _playWithPet() {
    if (_gameOver) return;
    setState(() {
      // Playing boosts happiness, but also makes the pet hungrier and more tired.
      happinessLevel += 15;
      hungerLevel += 5;
      tiredLevel += 5;
      if (happinessLevel > 100) happinessLevel = 100;
      if (hungerLevel > 100) hungerLevel = 100;
      if (tiredLevel > 100) tiredLevel = 100;
      _updateAbove80Since();
      _checkWinLoss();
    });
  }

  void _feedPet() {
    if (_gameOver) return;
    setState(() {
      // Feeding reduces hunger and gives a small happiness boost.
      hungerLevel -= 10;
      happinessLevel += 10;
      if (hungerLevel < 0) hungerLevel = 0;
      if (happinessLevel > 100) happinessLevel = 100;
      _updateAbove80Since();
      _checkWinLoss();
    });
  }

  void _sendToSleep() {
    if (_gameOver) return;
    setState(() {
      // Sleeping restores energy by resetting tiredness.
      tiredLevel = 0;
      _checkWinLoss();
    });
  }

  void _reset() {
    // Reset returns the game to a fresh starting state.
    setState(() {
      happinessLevel = 50;
      hungerLevel = 0;
      tiredLevel = 0;
      _gameOver = false;
      _above80Since = null;
    });
  }

  void _updateHunger() {
    if (_gameOver || !mounted) return;
    setState(() {
      // Hunger rises over time; we derive happiness from hunger (100 - hunger).
      hungerLevel += 5;
      if (hungerLevel > 100) hungerLevel = 100;
      happinessLevel = 100 - hungerLevel;
      _updateAbove80Since();
      _checkWinLoss();
    });
  }

  // Map happiness to a mood color so the pet can visually look happier/sadder.
  Color _moodColor(int happiness) {
    if (happiness > 70) return Colors.green;  // happy
    if (happiness >= 30) return Colors.yellow; // neutral
    return Colors.red;                         // unhappy
  }

  String _moodLabel(int happiness) {
    if (happiness > 70) return 'Happy';
    if (happiness >= 30) return 'Neutral';
    return 'Unhappy';
  }

  String _moodEmoji(int happiness) {
    if (happiness > 70) return '😊';
    if (happiness >= 30) return '😐';
    return '😢';
  }

  // "Effective happiness" is what we show to the user after applying tiredness penalty.
  int get _effectiveHappiness =>
      (happinessLevel - (tiredLevel ~/ 10) * 5).clamp(0, 100);

  // Energy is just the inverse of tiredness, used by the progress bar.
  int get _energyLevel => (100 - tiredLevel).clamp(0, 100);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Digital Pet')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Name: $petName', style: TextStyle(fontSize: 20.0)),
            SizedBox(height: 16.0),
            Text(
              'Happiness Level: $_effectiveHappiness (current − 5 per 10 tired)',
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 16.0),
            Text(
              'Hunger Level: $hungerLevel',
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 16.0),
            Text(
              'Tired Level: $tiredLevel',
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 8.0),
            Text('Energy', style: TextStyle(fontSize: 16.0)),
            SizedBox(height: 4.0),
            SizedBox(
              width: 200.0,
              child: LinearProgressIndicator(
                value: _energyLevel / 100.0,
                minHeight: 12.0,
                backgroundColor: Colors.grey.shade300,
                valueColor: AlwaysStoppedAnimation<Color>(
                  _energyLevel > 50
                      ? Colors.green
                      : _energyLevel > 25
                          ? Colors.orange
                          : Colors.red,
                ),
              ),
            ),
            SizedBox(height: 8.0),
            ColorFiltered(
              colorFilter: ColorFilter.mode(
                _moodColor(_effectiveHappiness),
                BlendMode.modulate,
              ),
              child: Image.asset('assets/pet_image.png'),
            ),
            SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _moodLabel(_effectiveHappiness),
                  style: TextStyle(
                    fontSize: 18.0,
                    color: _moodColor(_effectiveHappiness),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(width: 8.0),
                Text(
                  _moodEmoji(_effectiveHappiness),
                  style: TextStyle(fontSize: 24.0),
                ),
              ],
            ),
            SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: _gameOver ? null : _playWithPet,
              child: Text('Play with Your Pet'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _gameOver ? null : _feedPet,
              child: Text('Feed Your Pet'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _gameOver ? null : _sendToSleep,
              child: Text('Send to Sleep'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _reset,
              child: Text('Reset'),
            ),
          ],
        ),
      ),
    );
  }
}
