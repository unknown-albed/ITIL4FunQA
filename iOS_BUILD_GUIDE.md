# 🍎 iOS Build Guide - ITIL® 4 Foundation Quiz App

## 📋 **Prerequisites**

Before you can build the iOS app, you need:

### **Required Software:**
- ✅ **macOS** (macOS 10.14.6 or later)
- ✅ **Xcode** (14.0 or later) - [Download from App Store](https://apps.apple.com/us/app/xcode/id497799835)
- ✅ **Flutter SDK** (3.5.4 or later) - [Install Flutter](https://docs.flutter.dev/get-started/install/macos)
- ✅ **Git** (usually pre-installed on macOS)

### **Apple Developer Requirements:**
- ✅ **Apple ID** (free for simulator testing)
- ✅ **Apple Developer Account** ($99/year for device installation)
- ✅ **iOS Device** (iPhone/iPad running iOS 12.0+)

---

## 🛠️ **Step-by-Step Build Instructions**

### **Step 1: Install Prerequisites**

#### **Install Xcode:**
```bash
# Install Xcode from App Store, then install command line tools:
sudo xcode-select --install
```

#### **Install Flutter:**
```bash
# Download and install Flutter
cd ~/development
git clone https://github.com/flutter/flutter.git -b stable
export PATH="$PATH:`pwd`/flutter/bin"

# Add to your shell profile (.zshrc or .bash_profile):
echo 'export PATH="$PATH:~/development/flutter/bin"' >> ~/.zshrc

# Verify installation
flutter doctor
```

### **Step 2: Clone and Setup Project**

```bash
# Clone the ITIL Quiz app repository
git clone https://github.com/unknown-albed/ITIL4FunQA.git
cd ITIL4FunQA

# Get Flutter dependencies
flutter pub get

# Check for any iOS-specific issues
flutter doctor
```

### **Step 3: iOS Simulator Testing**

```bash
# List available simulators
xcrun simctl list devices

# Open iOS Simulator
open -a Simulator

# Run app on simulator
flutter run -d ios
```

### **Step 4: Build for Physical Device**

#### **Option A: Development Build (Free Apple ID)**
```bash
# Build for development (requires device connection)
flutter run -d ios --debug

# Or build and open in Xcode
flutter build ios --debug
open ios/Runner.xcworkspace
```

#### **Option B: Release Build (Apple Developer Account)**
```bash
# Build release version
flutter build ios --release

# Open in Xcode for signing and distribution
open ios/Runner.xcworkspace
```

### **Step 5: Xcode Configuration**

When Xcode opens:

1. **Select your development team:**
   - Click on "Runner" in the project navigator
   - Go to "Signing & Capabilities" tab
   - Select your Apple ID/Developer Team

2. **Configure Bundle Identifier:**
   - Change bundle identifier to something unique (e.g., `com.yourname.itil4quiz`)

3. **Connect your iOS device:**
   - Connect iPhone/iPad via USB
   - Trust the computer on your device
   - Select your device in Xcode's device dropdown

4. **Build and Install:**
   - Click the "Play" button in Xcode
   - Or use: Product → Run (⌘R)

---

## 📱 **Alternative Methods**

### **Method 1: TestFlight Distribution**
*Coming soon - we'll provide TestFlight links for beta testing*

### **Method 2: Web App (No Build Required)**
iPhone users can use the web version:
- **URL**: https://unknown-albed.github.io/ITIL4FunQA/ *(Coming Soon)*
- Add to Home Screen for app-like experience
- Works offline after first load

### **Method 3: GitHub Codespaces**
Build in the cloud without local setup:
1. Go to: https://github.com/unknown-albed/ITIL4FunQA
2. Click "Code" → "Codespaces" → "Create codespace"
3. Run: `flutter run -d web` for web version

---

## 🔧 **Troubleshooting**

### **Common Issues:**

#### **"No iOS devices found"**
```bash
# Check connected devices
flutter devices

# Ensure device is trusted and developer mode is enabled
# Settings → Privacy & Security → Developer Mode → On
```

#### **"CocoaPods not installed"**
```bash
# Install CocoaPods
sudo gem install cocoapods
cd ios
pod install
cd ..
```

#### **"Xcode license not accepted"**
```bash
sudo xcodebuild -license accept
```

#### **"Flutter doctor shows issues"**
```bash
# Run doctor and follow suggestions
flutter doctor -v

# Common fixes:
flutter doctor --android-licenses  # Accept Android licenses
sudo xcode-select -s /Applications/Xcode.app/Contents/Developer
```

#### **"Build failed with signing errors"**
1. Open `ios/Runner.xcworkspace` in Xcode
2. Select "Runner" project
3. Go to "Signing & Capabilities"
4. Select your development team
5. Change bundle identifier to be unique

#### **"App crashes on device"**
- Make sure iOS version is 12.0+
- Check device storage (app needs ~50MB)
- Try building in Debug mode first
- Check Xcode console for error messages

---

## 📋 **Build Configurations**

### **Debug Build (Development):**
```bash
flutter build ios --debug
# - Larger file size
# - Includes debugging info
# - Hot reload capable
# - Good for testing
```

### **Release Build (Distribution):**
```bash
flutter build ios --release
# - Optimized and smaller
# - No debugging info
# - Better performance
# - Ready for App Store
```

### **Profile Build (Performance Testing):**
```bash
flutter build ios --profile
# - Optimized but with profiling
# - Good for performance testing
```

---

## 🎯 **App Store Distribution (Optional)**

If you want to distribute via App Store:

### **1. Prepare for App Store:**
```bash
# Build archive
flutter build ios --release
open ios/Runner.xcworkspace

# In Xcode:
# Product → Archive
# Window → Organizer → Upload to App Store
```

### **2. App Store Requirements:**
- ✅ Unique Bundle Identifier
- ✅ App Icons (all sizes)
- ✅ Privacy Policy
- ✅ App Store Screenshots
- ✅ App Description
- ✅ Apple Developer Account ($99/year)

---

## 📞 **Need Help?**

### **Flutter iOS Issues:**
- 📖 [Flutter iOS Setup Guide](https://docs.flutter.dev/get-started/install/macos)
- 🐛 [Flutter GitHub Issues](https://github.com/flutter/flutter/issues)

### **Xcode Issues:**
- 📖 [Apple Developer Documentation](https://developer.apple.com/documentation/)
- 💬 [Apple Developer Forums](https://developer.apple.com/forums/)

### **Project-Specific Issues:**
- 🐛 [Report Issue](https://github.com/unknown-albed/ITIL4FunQA/issues/new)
- 💬 [Discussions](https://github.com/unknown-albed/ITIL4FunQA/discussions)

---

## ⚡ **Quick Start Summary**

For experienced developers:

```bash
# 1. Prerequisites: macOS + Xcode + Flutter
# 2. Clone and setup
git clone https://github.com/unknown-albed/ITIL4FunQA.git
cd ITIL4FunQA
flutter pub get

# 3. Run on simulator
flutter run -d ios

# 4. Build for device
flutter build ios --release
open ios/Runner.xcworkspace
# Configure signing in Xcode, then build & run
```

**Happy Building! 🚀**