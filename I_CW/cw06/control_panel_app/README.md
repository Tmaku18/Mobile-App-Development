# Mission Control: Rocket Launch Controller (CW06)

Flutter control panel demonstrating **StatefulWidget** state updates and UI feedback for a rocket launch sequence.

## Required features implemented

- **Fuel value**: 0–100 via slider + buttons
- **Ignite**: increments by 1 (never above 100)
- **Decrement**: decrements by 1 (never below 0)
- **Reset**: sets fuel to 0
- **Visual status color**:
  - **Red** at 0
  - **Orange** from 1–50
  - **Green** above 50
- **LIFTOFF logic**: at 100, display switches to **"LIFTOFF!"**

## Bonus feature implemented

- **Launch Success Popup**: when the value first reaches 100, a dialog appears indicating launch success. If you go below 100 and return to 100, it can show again.

## Run

```powershell
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
flutter build apk
```

APK output path (debug runs may also generate this):

- `build\app\outputs\flutter-apk\app-debug.apk`

Release APK output path:

- `build\app\outputs\flutter-apk\app-release.apk`

## Submission checklist

- **APK file**: include the APK you built (see paths above)
- **GitHub repo link**: include the repository URL containing the full source code
