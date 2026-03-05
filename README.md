# 🛒 Grocery App - Flutter Clean Architecture

A modern, beautiful grocery shopping application built with Flutter, featuring Clean Architecture and Riverpod state management.

## 📱 Features

- **Onboarding Screen**: Engaging welcome screen with smooth animations
- **Home Screen**: Browse products, deals, and categories
- **Categories**: Organized product categories for easy navigation
- **Order Again**: Quick reordering from past purchases
- **Profile**: User profile management
- **Search**: Search across 20k+ products
- **Responsive UI**: Beautiful green and white theme with modern design

## 🏗️ Architecture

This project follows **Clean Architecture** principles with feature-based organization:

```
lib/
├── core/
│   ├── theme/           # App theme and colors
│   ├── constants/       # App constants
│   └── utils/          # Utility functions and providers
├── features/
│   ├── onboarding/
│   │   └── presentation/
│   ├── home/
│   │   ├── domain/       # Entities
│   │   ├── data/         # Repository implementations
│   │   └── presentation/ # UI, widgets, and providers
│   ├── categories/
│   │   └── presentation/
│   ├── orders/
│   │   └── presentation/
│   └── profile/
│       ├── domain/
│       ├── data/
│       └── presentation/
└── main.dart
```

## 🎨 Design System

### Color Palette
- **Primary Green**: `#CDFF00` - Main brand color
- **Dark Green**: `#89A600` - Accent color
- **White**: `#FFFFFF` - Background
- **Black**: `#000000` - Text and icons

### Typography
- Using **Inter** font family via Google Fonts
- Consistent typography scale for readability

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (>=3.9.2)
- Dart SDK
- Android Studio / Xcode (for mobile development)

### Installation

1. Clone the repository:
```bash
git clone https://github.com/yourusername/grocery_app.git
cd grocery_app
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the app:
```bash
flutter run
```

## 📦 Dependencies

### State Management
- `flutter_riverpod` - State management solution

### UI
- `google_fonts` - Custom typography
- `flutter_svg` - SVG support
- `cached_network_image` - Image caching
- `smooth_page_indicator` - Page indicators

### Utilities
- `equatable` - Value equality
- `dartz` - Functional programming
- `freezed` - Code generation for models

## 🧪 Testing

Run tests with:
```bash
flutter test
```

## 📱 Screenshots

(Add your screenshots here)

## 🛠️ Development

### Code Generation

If you modify freezed models, run:
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### Folder Structure

Each feature follows the same structure:
- **domain/**: Business logic, entities
- **data/**: Repository implementations, data sources
- **presentation/**: UI components, pages, widgets, providers

## 🎯 Roadmap

- [ ] Add cart functionality
- [ ] Implement checkout flow
- [ ] Add payment integration
- [ ] User authentication
- [ ] Order tracking
- [ ] Push notifications
- [ ] Wishlist feature
- [ ] Product reviews and ratings

## 📄 License

This project is created for portfolio purposes.

## 👤 Author

**Your Name**
- LinkedIn: [Your LinkedIn Profile](https://linkedin.com/in/yourprofile)
- GitHub: [@yourusername](https://github.com/yourusername)
- Portfolio: [yourportfolio.com](https://yourportfolio.com)

## 🙏 Acknowledgments

- Design inspiration from modern grocery apps
- Flutter community for excellent packages
- Riverpod for state management patterns

---

⭐ If you found this project helpful, please consider giving it a star!
