# 🚀 Getting Started with Grocery App

A complete guide to setting up and running the Grocery App on your local machine.

## 📋 Prerequisites

Before you begin, ensure you have the following installed on your machine:

### Required Software

1. **Flutter SDK** (>=3.9.2)
   - Download from: https://docs.flutter.dev/get-started/install
   - Verify installation: `flutter doctor`

2. **Dart SDK** (comes with Flutter)
   - Verify: `dart --version`

3. **IDE** (Choose one)
   - [Visual Studio Code](https://code.visualstudio.com/)
     - Install Flutter extension
     - Install Dart extension
   - [Android Studio](https://developer.android.com/studio)
     - Install Flutter plugin
     - Install Dart plugin

4. **Platform-specific tools**

   **For Android:**
   - Android Studio
   - Android SDK
   - Android Emulator or physical device
   
   **For iOS (Mac only):**
   - Xcode (latest stable version)
   - CocoaPods: `sudo gem install cocoapods`
   - iOS Simulator or physical device

## 🛠️ Installation Steps

### 1. Clone the Repository

```bash
git clone https://github.com/yourusername/grocery_app.git
cd grocery_app/grocery_app
```

### 2. Install Dependencies

```bash
flutter pub get
```

This will install all the required packages listed in `pubspec.yaml`.

### 3. Verify Flutter Installation

```bash
flutter doctor -v
```

Ensure all required components are installed. Fix any issues reported.

### 4. Run Code Generation (if needed)

If you modify any freezed models in the future:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

## 🏃 Running the App

### On Android Emulator

1. Start an Android emulator from Android Studio, or use:
   ```bash
   flutter emulators --launch <emulator_id>
   ```

2. Run the app:
   ```bash
   flutter run
   ```

### On iOS Simulator (Mac only)

1. Open iOS Simulator:
   ```bash
   open -a Simulator
   ```

2. Run the app:
   ```bash
   flutter run
   ```

### On Physical Device

#### Android:
1. Enable Developer Options and USB Debugging on your device
2. Connect via USB
3. Run: `flutter devices` to verify connection
4. Run: `flutter run`

#### iOS:
1. Connect your device
2. Trust the computer on your device
3. Run: `flutter devices`
4. Run: `flutter run`

### Selecting a Specific Device

```bash
flutter run -d <device_id>
```

## 🐛 Troubleshooting

### Common Issues

#### Issue: "No devices available"
**Solution:**
```bash
flutter devices
# If no devices show, start an emulator/simulator first
```

#### Issue: "Gradle build failed"
**Solution:**
```bash
cd android
./gradlew clean
cd ..
flutter clean
flutter pub get
```

#### Issue: "CocoaPods not installed" (iOS)
**Solution:**
```bash
sudo gem install cocoapods
cd ios
pod install
cd ..
```

#### Issue: Dependency conflicts
**Solution:**
```bash
flutter clean
flutter pub cache repair
flutter pub get
```

## 📱 Building for Production

### Android APK

```bash
flutter build apk --release
```

Output: `build/app/outputs/flutter-apk/app-release.apk`

### Android App Bundle (for Play Store)

```bash
flutter build appbundle --release
```

Output: `build/app/outputs/bundle/release/app-release.aab`

### iOS (Mac only)

```bash
flutter build ios --release
```

Then open `ios/Runner.xcworkspace` in Xcode to archive and upload.

## 🧪 Testing

### Run All Tests

```bash
flutter test
```

### Run Tests with Coverage

```bash
flutter test --coverage
```

### Run Specific Test File

```bash
flutter test test/widget_test.dart
```

## 🔍 Code Analysis

### Run Flutter Analyzer

```bash
flutter analyze
```

### Fix Auto-fixable Issues

```bash
dart fix --apply
```

## 📦 Project Structure

```
grocery_app/
├── lib/                    # Main application code
│   ├── core/              # Core functionality
│   ├── features/          # Feature modules
│   └── main.dart          # Entry point
├── test/                   # Test files
├── android/               # Android native code
├── ios/                   # iOS native code
├── assets/                # Images, fonts, etc.
├── pubspec.yaml           # Dependencies
└── README.md              # Documentation
```

## 🎨 Hot Reload & Hot Restart

While the app is running:

- **Hot Reload**: Press `r` in terminal (preserves state)
- **Hot Restart**: Press `R` in terminal (resets state)
- **Quit**: Press `q` in terminal

## 📚 Additional Resources

- [Flutter Documentation](https://docs.flutter.dev/)
- [Riverpod Documentation](https://riverpod.dev/)
- [Dart Language Tour](https://dart.dev/guides/language/language-tour)
- [Flutter Widget Catalog](https://docs.flutter.dev/ui/widgets)
- [Material Design Guidelines](https://m3.material.io/)

## 🆘 Getting Help

If you encounter any issues:

1. Check the [Troubleshooting](#-troubleshooting) section
2. Search existing issues on GitHub
3. Create a new issue with:
   - Flutter version (`flutter --version`)
   - Error logs
   - Steps to reproduce
   - Screenshots (if applicable)

## 📄 License

This project is for portfolio purposes.

---

Happy Coding! 🎉
