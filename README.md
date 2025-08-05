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

## 🏗️ Architecture

### Project Structure
```
lib/
├── models/
│   ├── question.dart          # Question data model
│   └── quiz_result.dart       # Quiz session and result models
├── providers/
│   ├── quiz_provider.dart     # Quiz state management
│   └── theme_provider.dart    # Theme state management
├── screens/
│   ├── home_screen.dart       # Main entry screen
│   ├── quiz_screen.dart       # Quiz taking interface
│   ├── results_screen.dart    # Final score display
│   └── review_screen.dart     # Answer review interface
├── services/
│   └── database_service.dart  # SQLite database operations
├── widgets/
│   ├── question_card.dart     # Question display component
│   └── answer_feedback.dart   # Answer feedback component
└── main.dart                  # App entry point
```

### Key Components

#### Models
- **Question**: Represents a quiz question with options, correct answer, and explanation
- **QuizResult**: Tracks individual question responses
- **QuizSession**: Manages complete quiz attempts with scoring

#### Providers
- **QuizProvider**: Manages quiz state, timer, navigation, and scoring logic
- **ThemeProvider**: Handles light/dark theme switching with persistence

#### Services
- **DatabaseService**: SQLite operations for questions and quiz history

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (3.5.4+)
- Dart SDK
- Android Studio / VS Code with Flutter extensions
- iOS development tools (for iOS deployment)

### Installation

1. **Clone the repository**:
   ```bash
   git clone <repository-url>
   cd itil4_quiz_app
   ```

2. **Install dependencies**:
   ```bash
   flutter pub get
   ```

3. **Run the app**:
   ```bash
   flutter run
   ```

### Adding Your Questions

Replace the sample questions in `assets/data/questions.json` with your 40 ITIL® 4 questions:

```json
{
  "questions": [
    {
      "id": 1,
      "questionText": "Your question here?",
      "options": [
        "Option A",
        "Option B", 
        "Option C",
        "Option D"
      ],
      "correctAnswerIndex": 1,
      "explanation": "Detailed explanation of the correct answer."
    }
  ]
}
```

## 📦 Dependencies

### Production Dependencies
- **flutter**: Flutter SDK
- **provider**: State management
- **sqflite**: Local SQLite database
- **shared_preferences**: Simple data persistence
- **path**: File path utilities
- **google_fonts**: Typography enhancements

### Development Dependencies
- **flutter_test**: Testing framework
- **flutter_lints**: Code quality rules

## 🎨 Design System

### Color Scheme
- **Primary**: Purple (#6750A4) - ITIL brand-inspired
- **Success**: Green - Correct answers
- **Error**: Red - Incorrect answers
- **Surface**: Material 3 surface colors

### Typography
- **Questions**: 18pt, medium weight
- **Options**: 16pt body text
- **Explanations**: 14pt with line height 1.4

### Components
- **Cards**: 16px border radius, 2dp elevation
- **Buttons**: 12px border radius, consistent padding
- **Progress**: Linear indicator with smooth animations

## 🔧 Configuration

### Theme Settings
The app supports three theme modes:
- **Light**: Default light theme
- **Dark**: High contrast dark theme  
- **System**: Follows device preference

### Database Schema
```sql
-- Questions table
CREATE TABLE questions(
  id INTEGER PRIMARY KEY,
  questionText TEXT NOT NULL,
  options TEXT NOT NULL,        -- JSON array
  correctAnswerIndex INTEGER NOT NULL,
  explanation TEXT NOT NULL
);

-- Quiz sessions table  
CREATE TABLE quiz_sessions(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  startTime TEXT NOT NULL,
  endTime TEXT,
  totalQuestions INTEGER NOT NULL,
  results TEXT NOT NULL         -- JSON array
);
```

## 🚀 Building for Production

### Android
```bash
flutter build apk --release
# or
flutter build appbundle --release
```

### iOS
```bash
flutter build ios --release
```

### Web (if enabled)
```bash
flutter build web --release
```

## 🧪 Testing

Run the test suite:
```bash
flutter test
```

Check code quality:
```bash
flutter analyze
```

## 📱 Supported Platforms

- ✅ **Android** (API 21+)
- ✅ **iOS** (iOS 12+)
- 🔄 **Web** (can be enabled)
- 🔄 **Desktop** (can be enabled)

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests if applicable
5. Run `flutter analyze` and `flutter test`
6. Submit a pull request

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🙏 Acknowledgments

- **ITIL® 4**: Official ITIL guidance and framework
- **Flutter Team**: Amazing cross-platform framework
- **Material Design**: Beautiful, accessible design system

---

**Note**: ITIL® is a registered trademark of AXELOS Limited. This app is for educational purposes only and is not officially endorsed by AXELOS. 
