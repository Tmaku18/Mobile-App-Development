# In-Class Activity 06 — Mission Control (CW06)

This folder contains the Flutter project for the **Mission Control: Stateful Rocket Launch** activity.

## Project

- **Flutter app**: `control_panel_app/`
- **Main entry**: `control_panel_app/lib/main.dart`

## Run

```powershell
cd control_panel_app
flutter pub get
flutter run
```

If more than one device is connected:

```powershell
flutter devices
flutter run -d <device_id>
```

## Build APK (submission)

```powershell
cd control_panel_app
flutter build apk
```

Common APK output paths:

- `control_panel_app/build/app/outputs/flutter-apk/app-debug.apk`
- `control_panel_app/build/app/outputs/flutter-apk/app-release.apk`

## Submission

- **APK file**: build and submit the APK (paths above)
- **GitHub repo link**: submit the link to the repository containing the full source code

