# 📁 Project Structure

## Clean Architecture Overview

This project follows **Clean Architecture** principles to ensure scalability, maintainability, and testability.

```
lib/
├── core/                           # Core application layer
│   ├── theme/                      # App theme & styling
│   │   ├── app_colors.dart        # Color palette
│   │   └── app_theme.dart         # Material theme configuration
│   ├── constants/                  # App-wide constants
│   │   └── app_constants.dart     # UI strings, dimensions
│   └── utils/                      # Utility classes
│       └── navigation_provider.dart # Navigation state management
│
├── features/                       # Feature-based modules
│   ├── onboarding/                # Onboarding feature
│   │   └── presentation/
│   │       └── pages/
│   │           └── onboarding_page.dart
│   │
│   ├── home/                      # Home/Main feature
│   │   ├── domain/                # Business logic layer
│   │   │   └── entities/          # Domain models
│   │   │       ├── product.dart
│   │   │       ├── category.dart
│   │   │       └── deal.dart
│   │   ├── data/                  # Data layer
│   │   │   └── repositories/      # Data source implementations
│   │   │       └── mock_home_repository.dart
│   │   └── presentation/          # UI layer
│   │       ├── pages/             # Screen widgets
│   │       │   ├── home_page.dart
│   │       │   └── main_navigation_page.dart
│   │       ├── widgets/           # Reusable UI components
│   │       │   ├── category_chip.dart
│   │       │   ├── deal_card.dart
│   │       │   ├── product_card.dart
│   │       │   └── search_bar.dart
│   │       └── providers/         # State management
│   │           └── home_providers.dart
│   │
│   ├── categories/                # Categories feature
│   │   └── presentation/
│   │       └── pages/
│   │           └── categories_page.dart
│   │
│   ├── orders/                    # Orders feature
│   │   └── presentation/
│   │       └── pages/
│   │           └── orders_page.dart
│   │
│   └── profile/                   # User profile feature
│       ├── domain/
│       │   └── entities/
│       │       └── user_profile.dart
│       ├── data/
│       │   └── repositories/
│       │       └── mock_user_repository.dart
│       └── presentation/
│           ├── pages/
│           │   └── profile_page.dart
│           └── providers/
│               └── user_providers.dart
│
└── main.dart                      # App entry point
```

## Layer Responsibilities

### 🎯 Domain Layer
- **Purpose**: Contains business logic and entities
- **Components**: 
  - Entities: Pure Dart classes representing business models
  - Use Cases: Business logic operations (to be implemented)
- **Rules**: 
  - No dependencies on other layers
  - Framework-independent
  - Reusable across platforms

### 💾 Data Layer
- **Purpose**: Manages data sources and repositories
- **Components**:
  - Repositories: Implementations of data fetching/storing
  - Data Sources: API clients, local database handlers
  - Models: Data transfer objects (DTOs)
- **Current State**: Using mock repositories for UI-only implementation

### 🎨 Presentation Layer
- **Purpose**: UI and user interaction
- **Components**:
  - Pages: Full-screen widgets
  - Widgets: Reusable UI components
  - Providers: Riverpod state management
- **State Management**: Flutter Riverpod

## State Management with Riverpod

### Provider Types Used

1. **Provider**: Read-only state
   ```dart
   final productsProvider = Provider<List<Product>>((ref) {...});
   ```

2. **StateProvider**: Simple mutable state
   ```dart
   final searchQueryProvider = StateProvider<String>((ref) => '');
   ```

3. **StateNotifierProvider**: Complex state with logic
   ```dart
   final categoriesProvider = StateNotifierProvider<CategoriesNotifier, List<CategoryItem>>(...);
   ```

## Adding New Features

To add a new feature, follow this structure:

1. Create feature folder: `lib/features/feature_name/`
2. Add layers as needed:
   ```
   feature_name/
   ├── domain/
   │   └── entities/
   ├── data/
   │   └── repositories/
   └── presentation/
       ├── pages/
       ├── widgets/
       └── providers/
   ```
3. Implement from domain → data → presentation
4. Create providers for state management
5. Wire up navigation in main_navigation_page.dart

## Best Practices

✅ **DO:**
- Keep each layer independent
- Use const constructors where possible
- Follow naming conventions
- Write widget tests for UI components
- Use providers for all state management
- Keep widgets small and focused

❌ **DON'T:**
- Mix presentation logic with business logic
- Access repositories directly from UI
- Use setState for complex state
- Create god classes/widgets
- Ignore linter warnings

## Design System

### Colors
- Primary: `#CDFF00` (Lime Green)
- Secondary: `#89A600` (Dark Green)
- Background: `#FFFFFF` (White)
- Cards: Soft pastels (pink, green, yellow, blue)

### Typography
- Font Family: Inter (via Google Fonts)
- Scale: Display, Headline, Title, Body, Label

### Spacing
- Small: 8px
- Default: 16px
- Large: 24px

### Border Radius
- Cards: 20px
- Buttons: 30px
- Chips: 25px

## Testing Strategy

### Unit Tests
- Domain entities
- Business logic
- State notifiers

### Widget Tests
- Individual widgets
- Page layouts
- User interactions

### Integration Tests
- Complete user flows
- Navigation
- State changes

## Future Enhancements

- [ ] API integration layer
- [ ] Local database (Hive/SQLite)
- [ ] Authentication module
- [ ] Cart functionality
- [ ] Payment gateway
- [ ] Push notifications
- [ ] Analytics integration
- [ ] Internationalization (i18n)
