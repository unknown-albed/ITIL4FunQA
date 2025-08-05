# ITIL® 4 Foundation Quiz App

A modern Flutter mobile quiz application for testing ITIL® 4 Foundation knowledge. Features 40 practice questions with explanations, timer functionality, and a beautiful Material 3 UI with light/dark theme support.

## 📱 Features

### Core Functionality
- **40 ITIL® 4 Foundation Questions**: Comprehensive question bank covering key concepts
- **Multiple Choice Format**: 4 options per question (A, B, C, D)
- **Instant Feedback**: Shows correct/incorrect with explanations after each answer
- **Timer**: Tracks time spent on the quiz (no time limit)
- **Score Tracking**: Final score with percentage and pass/fail indication (65% passing)
- **Review Mode**: Go back and review all answers with explanations
- **Question Navigation**: Jump to specific questions during review

### UI/UX Features
- **Material 3 Design**: Modern, clean interface with rounded corners and shadows
- **Light/Dark Theme**: Toggle between themes with system preference support
- **Responsive Design**: Optimized for various screen sizes
- **Progress Indicator**: Visual progress bar during quiz
- **Motivational Messages**: Encouraging feedback for correct answers
- **Question List Overview**: Grid view of all questions with color-coded status

### Technical Features
- **Local Storage**: Questions and results stored locally using SQLite
- **State Management**: Provider pattern for reactive UI updates
- **Offline Support**: Works completely offline, no internet required
- **Data Persistence**: Quiz history and preferences saved locally

## 🚀 Getting Started

### 📱 **Quick Install (Users)**
- **Android**: [Download APK](https://github.com/unknown-albed/ITIL4FunQA/releases/latest/download/app-release.apk)
- **Web**: [Use in Browser](https://unknown-albed.github.io/ITIL4FunQA/) *(Coming Soon)*
- **Full Guide**: [Installation Instructions](INSTALLATION.md)

### 🛠️ **Development Setup**

#### Prerequisites
- Flutter SDK (3.5.4+)
- Dart SDK
- Android Studio / VS Code with Flutter extensions
- iOS development tools (for iOS deployment)

#### Installation

1. **Clone the repository**:
   ```bash
   git clone https://github.com/unknown-albed/ITIL4FunQA.git
   cd ITIL4FunQA
   ```

2. **Install dependencies**:
   ```bash
   flutter pub get
   ```

3. **Run the app**:
   ```bash
   flutter run
   ```

## 📦 Dependencies

- **flutter**: Flutter SDK
- **provider**: State management
- **sqflite**: Local SQLite database
- **shared_preferences**: Simple data persistence
- **path**: File path utilities

## 🎨 Screenshots

*Screenshots will be added here*

## 🏗️ Architecture

The app follows clean architecture principles with:
- **Models**: Data structures for questions and quiz results
- **Providers**: State management using Provider pattern
- **Services**: Database operations and business logic
- **Screens**: UI screens for different app states
- **Widgets**: Reusable UI components

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- **ITIL® 4**: Official ITIL guidance and framework
- **Flutter Team**: Amazing cross-platform framework
- **Material Design**: Beautiful, accessible design system

---

**Note**: ITIL® is a registered trademark of AXELOS Limited. This app is for educational purposes only and is not officially endorsed by AXELOS.
