# 📲 ITIL® 4 Foundation Quiz App - Installation Guide

## 🚀 **Quick Download Links**

### **Android (APK)**
📱 **[Download Latest APK](https://github.com/unknown-albed/ITIL4FunQA/releases/latest/download/app-release.apk)**

*APK files are automatically built when we update the app. Check the [Releases page](https://github.com/unknown-albed/ITIL4FunQA/releases) for all versions.*

### **iOS (Coming Soon)**
🍎 iOS version requires Apple Developer Account. Web version available for iPhone users.

### **Web Version (All Devices)**
🌐 **[Use in Browser](https://unknown-albed.github.io/ITIL4FunQA/)** - **Live Now!**

📖 **[Complete Web Guide](WEB_DEPLOYMENT_GUIDE.md)** - PWA installation & features

---

## 📱 **Android Installation**

### **Method 1: Direct APK Install (Recommended)**

1. **Download APK**:
   - Click the [Download APK](https://github.com/unknown-albed/ITIL4FunQA/releases/latest/download/app-release.apk) link above
   - Or go to [Releases](https://github.com/unknown-albed/ITIL4FunQA/releases) and download the latest APK

2. **Enable Unknown Sources**:
   - Go to **Settings** → **Security** → **Unknown Sources**
   - Or **Settings** → **Apps** → **Special Access** → **Install Unknown Apps**
   - Enable for your browser/file manager

3. **Install**:
   - Open the downloaded APK file
   - Tap **Install**
   - Wait for installation to complete
   - Tap **Open** to start the quiz!

### **Method 2: Build from Source**

```bash
# Prerequisites: Flutter SDK, Android Studio
git clone https://github.com/unknown-albed/ITIL4FunQA.git
cd ITIL4FunQA
flutter pub get
flutter build apk --release

# APK will be at: build/app/outputs/flutter-apk/app-release.apk
```

---

## 🍎 **iOS Installation**

### **Method 1: TestFlight (Beta Testing)**
*Coming soon - we'll provide TestFlight link for beta testing*

### **Method 2: Build from Source (Requires macOS)**

📖 **[📱 Complete iOS Build Guide](iOS_BUILD_GUIDE.md)** - Detailed step-by-step instructions

**Quick Start:**
```bash
# Prerequisites: macOS, Xcode, Flutter SDK
git clone https://github.com/unknown-albed/ITIL4FunQA.git
cd ITIL4FunQA
flutter pub get

# For simulator testing:
flutter run -d ios

# For device installation:
flutter build ios --release
open ios/Runner.xcworkspace
# Configure signing in Xcode, then build & run
```

**Need help?** Check the [detailed iOS build guide](iOS_BUILD_GUIDE.md) for:
- ✅ Complete prerequisites setup
- ✅ Step-by-step Xcode configuration
- ✅ Troubleshooting common issues
- ✅ App Store distribution guide

### **Method 3: Use Web Version**
iPhone users can use the web version in Safari for the full experience.

---

## 🌐 **Web Version (All Devices)**

### **Access Online**
- **URL**: https://unknown-albed.github.io/ITIL4FunQA/ - **Live Now!** 🎉
- Works on any device with a web browser
- No installation required
- Same features as mobile apps
- Offline capable after first load
- **PWA Support**: Install as native app on any device

### **Run Locally**
```bash
git clone https://github.com/unknown-albed/ITIL4FunQA.git
cd ITIL4FunQA
flutter pub get
flutter run -d chrome
```

---

## 🖥️ **Desktop Installation**

### **Windows/macOS/Linux**
```bash
# Enable desktop support
flutter config --enable-windows-desktop
flutter config --enable-macos-desktop  
flutter config --enable-linux-desktop

# Build for your platform
flutter build windows  # Windows
flutter build macos    # macOS
flutter build linux    # Linux
```

*Pre-built desktop versions coming soon!*

---

## ✅ **System Requirements**

### **Android**
- ✅ **Android 5.0** (API level 21) or higher
- ✅ **50 MB** free storage
- ✅ **1 GB RAM** recommended
- ✅ **Internet** for initial download only (app works offline)

### **iOS**
- ✅ **iOS 12.0** or higher
- ✅ **50 MB** free storage
- ✅ **1 GB RAM** recommended

### **Web Browser**
- ✅ **Chrome 84+**
- ✅ **Safari 14+**
- ✅ **Firefox 78+**
- ✅ **Edge 84+**

---

## 🎯 **App Features**

✅ **40 ITIL® 4 Foundation Questions** - Professional exam-style questions  
✅ **Instant Feedback** - Learn from explanations after each answer  
✅ **Timer Tracking** - Monitor your progress (no time pressure)  
✅ **Score Analysis** - Get percentage score with pass/fail indication  
✅ **Review Mode** - Go back through all questions and answers  
✅ **Dark/Light Theme** - Choose your preferred interface  
✅ **Offline Support** - Works without internet after installation  
✅ **Progress Tracking** - See your quiz progress visually  

---

## 🔧 **Troubleshooting**

### **Android Issues**

**"App not installed" error:**
- Enable "Install from Unknown Sources"
- Clear download cache and try again
- Make sure you have enough storage space

**"Parse error" when installing:**
- Download the APK again (might be corrupted)
- Make sure your Android version is 5.0+

**App crashes on startup:**
- Restart your device
- Clear app data: Settings → Apps → ITIL Quiz → Storage → Clear Data

### **iOS Issues**

**"Untrusted Developer" message:**
- Go to Settings → General → Device Management
- Trust the developer certificate

**App won't install:**
- Make sure iOS version is 12.0+
- Free up storage space
- Restart device and try again

### **Web Version Issues**

**App won't load:**
- Clear browser cache and cookies
- Try in incognito/private mode
- Make sure JavaScript is enabled

**Features not working:**
- Update your browser to the latest version
- Try a different browser
- Check internet connection for first load

---

## 📞 **Support**

### **Get Help**
- 🐛 **Report Bugs**: [Create an Issue](https://github.com/unknown-albed/ITIL4FunQA/issues/new)
- 💡 **Request Features**: [Feature Request](https://github.com/unknown-albed/ITIL4FunQA/issues/new)
- 📧 **Email Support**: *[Add your email here]*
- 💬 **Community**: Check [Discussions](https://github.com/unknown-albed/ITIL4FunQA/discussions)

### **FAQ**

**Q: Is this app free?**
A: Yes! Completely free and open source.

**Q: Do I need internet to use the app?**
A: Only for initial download. The app works completely offline.

**Q: Are these real ITIL exam questions?**
A: These are practice questions based on ITIL 4 Foundation concepts, designed for learning.

**Q: Can I contribute questions or improvements?**
A: Absolutely! Check our [Contributing Guide](CONTRIBUTING.md).

**Q: Is my progress saved?**
A: Yes, all quiz results and preferences are saved locally on your device.

---

## 🎓 **About ITIL® 4**

This app helps you prepare for the ITIL 4 Foundation certification by providing:
- **Comprehensive Coverage** of ITIL 4 concepts
- **Realistic Questions** similar to the actual exam
- **Detailed Explanations** to reinforce learning
- **Self-Paced Learning** with no time pressure

**Note**: ITIL® is a registered trademark of AXELOS Limited. This app is for educational purposes and is not officially endorsed by AXELOS.

---

## 🌟 **Rate & Share**

If you find this app helpful:
- ⭐ **Star the project** on [GitHub](https://github.com/unknown-albed/ITIL4FunQA)
- 📱 **Share with colleagues** preparing for ITIL certification
- 🐦 **Tweet about it** to help others discover the app
- 📝 **Write a review** or create a blog post

**Happy Learning! 🎉**