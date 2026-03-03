# Open Life 🎹🦞

**The ultimate AI-powered life management app with synthwave aesthetics.**

<p align="center">
  <img src="assets/images/logo.png" alt="Open Life Logo" width="200">
</p>

## Overview

Open Life is a comprehensive life management app that combines fitness tracking, financial management, and health/assurance features into one unified, beautiful experience. Powered by AI that has access to all your data, it provides holistic insights and personalized recommendations.

**100% free and open source.**

## Features

### 🏋️ Fitness
- Step tracking with daily/weekly goals
- Workout logging and planning
- Nutrition and calorie tracking
- AI-powered fitness coaching
- Personalized workout recommendations
- Progress visualization with charts

### 💰 Finance
- Budget tracking and management
- Expense categorization
- Savings goals
- Transaction history
- AI financial advisor
- Spending insights and recommendations

### 🏥 Health & Assurance
- Insurance policy management
- Appointment scheduling and reminders
- Medication tracking
- Health metrics monitoring
- Medical document storage
- AI health assistant

### 🤖 AI Integration
- **Holistic insights** - AI analyzes data across all three pillars
- **Personalized recommendations** - Based on your actual data
- **Natural language queries** - Ask questions about your life
- **Proactive suggestions** - AI suggests improvements before you ask
- **Context-aware responses** - AI knows your fitness, finance, and health context

## Design Philosophy

Open Life embraces a **synthwave aesthetic** inspired by 80s retro-futurism:

- 🌅 Sunset gradients (pink, purple, orange)
- ✨ Neon glow effects
- 🔲 Grid patterns and chrome accents
- 🎨 Dark mode by default
- 💜 Electric color palette

## Tech Stack

- **Framework:** Flutter 3.x
- **Language:** Dart
- **State Management:** Riverpod
- **Navigation:** GoRouter
- **Local Storage:** Hive
- **Charts:** FL Chart
- **Icons:** Phosphor Flutter
- **Animations:** Flutter Animate
- **AI:** OpenAI API (configurable)

## Getting Started

### Prerequisites

- Flutter SDK 3.2.0 or higher
- Dart SDK 3.2.0 or higher
- Android Studio / Xcode (for mobile development)

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/synthalorian/open-life.git
   cd open-life
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Generate necessary code (Riverpod, Hive, etc.):
   ```bash
   flutter pub run build_runner build
   ```

4. Run the app:
   ```bash
   flutter run
   ```

### Configuration

1. **AI Integration:**
   - Add your OpenAI API key to `lib/core/constants/api_keys.dart`
   - Or configure a different AI provider in `lib/core/services/ai_service.dart`

2. **Theme Customization:**
   - Modify colors in `lib/core/theme/app_colors.dart`
   - Adjust text styles in `lib/core/theme/app_text_styles.dart`

## Project Structure

```
lib/
├── main.dart                 # App entry point
├── app.dart                  # Root app widget
├── core/
│   ├── theme/               # Synthwave theme system
│   ├── router/              # GoRouter configuration
│   ├── constants/           # App constants, AI prompts
│   └── services/            # API services, AI integration
├── features/
│   ├── dashboard/           # Main dashboard
│   │   ├── presentation/
│   │   └── providers/
│   ├── fitness/             # Fitness tracking
│   │   ├── data/
│   │   ├── domain/
│   │   ├── presentation/
│   │   └── providers/
│   ├── finance/             # Financial management
│   │   ├── data/
│   │   ├── domain/
│   │   ├── presentation/
│   │   └── providers/
│   ├── assurance/           # Health & insurance
│   │   ├── data/
│   │   ├── domain/
│   │   ├── presentation/
│   │   └── providers/
│   └── ai_assistant/        # AI chat interface
│       ├── presentation/
│       └── providers/
└── shared/
    ├── widgets/             # Reusable UI components
    ├── models/              # Shared data models
    └── utils/               # Utility functions
```

## Architecture

Open Life follows **Clean Architecture** principles:

- **Presentation Layer** - UI widgets and controllers
- **Domain Layer** - Business logic and entities
- **Data Layer** - Data sources and repositories

### State Management

Using **Riverpod** for:
- Dependency injection
- State management
- Provider composition
- Testability

## AI Capabilities

The AI assistant has access to:
- Your fitness data (steps, workouts, nutrition)
- Your financial data (budget, transactions, goals)
- Your health data (appointments, medications, insurance)

This enables:
- **Cross-domain insights** - "How does my spending affect my fitness?"
- **Personalized recommendations** - Based on actual data patterns
- **Proactive suggestions** - AI identifies opportunities you might miss
- **Natural conversations** - Ask questions in plain English

## Contributing

We welcome contributions! Please see [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

### Ways to Contribute

- 🐛 Report bugs
- 💡 Suggest features
- 🎨 Improve the UI/UX
- 📝 Write documentation
- 🔧 Submit pull requests

## Roadmap

### v1.0 (Current)
- [x] Core UI with synthwave theme
- [x] Dashboard with quick stats
- [x] Fitness tracking (steps, workouts)
- [x] Finance tracking (budget, transactions)
- [x] Health/Assurance (appointments, insurance)
- [x] AI chat interface
- [x] Basic AI integration

### v1.1
- [ ] Cloud sync (optional)
- [ ] Data export/import
- [ ] Widget support
- [ ] Notifications
- [ ] Enhanced AI insights

### v1.2
- [ ] Wearable integration
- [ ] Bank account syncing
- [ ] Calendar integration
- [ ] Advanced analytics

### v2.0
- [ ] Social features
- [ ] Family sharing
- [ ] Custom AI models
- [ ] Plugin system

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- **synthwave aesthetic** - Inspired by 80s retro-futurism
- **Flutter team** - For an amazing framework
- **Riverpod** - For elegant state management
- **Phosphor Icons** - Beautiful, consistent icons

---

<p align="center">
  <strong>Stay retro, stay futuristic.</strong> 🌆
</p>

<p align="center">
  Made with 💜 by <a href="https://github.com/synthalorian">synth</a>
</p>
