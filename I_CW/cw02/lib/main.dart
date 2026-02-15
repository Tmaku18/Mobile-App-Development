import 'package:flutter/material.dart';

/// In-Class Activity 02: Creating Themes in Flutter (Part 1 & 2).
/// Implements light/dark themes, AnimatedContainer, Switch, and dynamic icons.
void main() {
  runApp(const RunMyApp());
}

class RunMyApp extends StatefulWidget {
  const RunMyApp({super.key});

  @override
  State<RunMyApp> createState() => _RunMyAppState();
}

class _RunMyAppState extends State<RunMyApp> {
  // Step 3: Variable to track current theme mode (system, light, or dark).
  ThemeMode _themeMode = ThemeMode.system;

  // Step 3: Method to toggle the theme; calls setState so the app rebuilds.
  void changeTheme(ThemeMode themeMode) {
    setState(() {
      _themeMode = themeMode;
    });
    print("Data updated! Current mode is now: $_themeMode");
  }

  @override
  Widget build(BuildContext context) {
    // Step 1: MaterialApp with theme (light) and darkTheme (dark).
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Theme Demo',

      // Light mode: blueGrey primary, light gray scaffold background.
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        scaffoldBackgroundColor: Colors.grey[200],
      ),
      // Dark mode: standard dark theme.
      darkTheme: ThemeData.dark(),
      // Connects state to the app so switching themeMode rebuilds with correct theme.
      themeMode: _themeMode,

      home: Scaffold(
        appBar: AppBar(
          title: const Text('Theme Demo'),
        ),
        // Part 1: Layout — Column inside Center, centered on the page.
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              // Enhanced UI: Card with elevation (shadow) for professional styling.
              child: Card(
                elevation: 8,
                shadowColor: Colors.black26,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Part 1: Container — Task 1: AnimatedContainer, Task 3: 500ms duration.
                      // Background: Light = Grey, Dark = White; high border radius (circular look).
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 500),
                        width: 300,
                        height: 200,
                        margin: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: _themeMode == ThemeMode.dark
                              ? Colors.white
                              : Colors.grey,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        alignment: Alignment.center,
                        // Step 2: Text uses theme (font 18); color inherits from theme.
                        child: Text(
                          'Mobile App Development Testing',
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    fontSize: 18,
                                  ),
                          textAlign: TextAlign.center,
                        ),
                      ),

                      const SizedBox(height: 20),

                      Text(
                        'Choose the Theme:',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontSize: 16,
                            ),
                      ),

                      const SizedBox(height: 10),

                      // Part 1: Controls — Task 2: Switch widget; Task 4: Dynamic Sun/Moon icons.
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            _themeMode == ThemeMode.dark
                                ? Icons.nightlight_round
                                : Icons.wb_sunny,
                            size: 28,
                          ),
                          const SizedBox(width: 12),
                          Switch(
                            value: _themeMode == ThemeMode.dark,
                            onChanged: (isDark) {
                              setState(() {
                                _themeMode =
                                    isDark ? ThemeMode.dark : ThemeMode.light;
                              });
                              print(
                                  "Data updated! Current mode is now: $_themeMode");
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
