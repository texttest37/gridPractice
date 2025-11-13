# Flutter MVVM Architecture App

A Flutter project implementing the **Model-View-ViewModel (MVVM)** architecture pattern with clean code principles.

## 🏗️ Architecture Overview

This project follows the **MVVM (Model-View-ViewModel)** architectural pattern, which provides:

- **Separation of Concerns**: Clear separation between UI, business logic, and data
- **Testability**: Easy unit testing of business logic
- **Maintainability**: Organized code structure for better maintenance
- **Scalability**: Easy to extend and add new features

### Architecture Layers

```
┌─────────────────┐
│      VIEW       │  ← UI Components (Widgets)
├─────────────────┤
│   VIEWMODEL     │  ← Business Logic & State Management
├─────────────────┤
│     MODEL       │  ← Data Models & Entities
├─────────────────┤
│   REPOSITORY    │  ← Data Access Layer
├─────────────────┤
│    SERVICE      │  ← External APIs & Data Sources
└─────────────────┘
```

## 📁 Project Structure

```
lib/src/
├── models/                 # 📋 Data Models
│   └── user.dart          # User entity with JSON serialization
├── views/                 # 🎨 UI Components
│   ├── screens/           # Application screens
│   │   └── home_screen.dart
│   └── widgets/           # Reusable UI components
├── viewmodels/            # 🧠 Business Logic & State Management
│   ├── base_view_model.dart    # Base class with common functionality
│   └── home_view_model.dart    # Home screen business logic
├── services/              # 🌐 External Services
│   └── api_service.dart   # HTTP API service
├── repositories/          # 📚 Data Access Layer
│   └── user_repository.dart    # User data operations
├── utils/                 # 🛠️ Utilities & Constants
│   └── constants/
│       └── colors.dart    # App color constants
└── app.dart              # Main application widget
```

## 🧩 Architecture Components Explained

### 1. **Models** (`lib/src/models/`)
- **Purpose**: Define data structures and entities
- **Features**:
  - JSON serialization (`fromJson`, `toJson`)
  - Immutable data objects
  - Copy methods for state updates
- **Example**: `User` model for user data

### 2. **Views** (`lib/src/views/`)
- **Purpose**: UI components and screens
- **Features**:
  - Stateless/Stateful widgets
  - Uses `Consumer` and `Provider` for state management
  - No business logic - only UI rendering
- **Structure**:
  - `screens/`: Full-screen pages
  - `widgets/`: Reusable UI components

### 3. **ViewModels** (`lib/src/viewmodels/`)
- **Purpose**: Business logic and state management
- **Features**:
  - Extends `ChangeNotifier` for reactive updates
  - Handles user interactions and business rules
  - Manages loading states and error handling
  - No direct UI references
- **Base Class**: `BaseViewModel` provides common functionality

### 4. **Repositories** (`lib/src/repositories/`)
- **Purpose**: Abstraction layer for data operations
- **Features**:
  - Centralizes data access logic
  - Can combine multiple data sources
  - Handles data caching and offline support
  - Returns domain models

### 5. **Services** (`lib/src/services/`)
- **Purpose**: External integrations and APIs
- **Features**:
  - HTTP API calls
  - Third-party service integrations
  - Raw data fetching and posting
  - Error handling for network operations

### 6. **Utils** (`lib/src/utils/`)
- **Purpose**: Shared utilities and constants
- **Features**:
  - App-wide constants (colors, strings, etc.)
  - Helper functions
  - Extension methods

## 📦 Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  provider: ^6.1.2      # State management
  http: ^1.1.0          # HTTP client for API calls
  cupertino_icons: ^1.0.8
```

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (>=3.5.0)
- Dart SDK
- Android Studio / VS Code with Flutter extensions

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd gridPractice/app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the application**
   ```bash
   flutter run
   ```

## 🛠️ Development Guidelines

### Adding a New Feature

1. **Create Model** (if needed)
   ```dart
   // lib/src/models/new_model.dart
   class NewModel {
     // Define properties and methods
   }
   ```

2. **Create Repository** (if API integration needed)
   ```dart
   // lib/src/repositories/new_repository.dart
   class NewRepository {
     // Data access methods
   }
   ```

3. **Create ViewModel**
   ```dart
   // lib/src/viewmodels/new_view_model.dart
   class NewViewModel extends BaseViewModel {
     // Business logic
   }
   ```

4. **Create View**
   ```dart
   // lib/src/views/screens/new_screen.dart
   class NewScreen extends StatelessWidget {
     // UI implementation with Consumer<NewViewModel>
   }
   ```

### State Management Flow

```
User Action → View → ViewModel → Repository → Service → API
                ↓
User sees result ← View ← ViewModel ← Repository ← Service ← Response
```

## 🔄 Data Flow Example

1. **User taps a button** in `HomeScreen`
2. **View calls method** in `HomeViewModel`
3. **ViewModel processes** business logic
4. **ViewModel calls** `UserRepository`
5. **Repository calls** `ApiService`
6. **Service makes** HTTP request
7. **Response flows back** through the layers
8. **ViewModel updates state** and notifies listeners
9. **View rebuilds** automatically via `Consumer`

## 🧪 Testing

The MVVM architecture makes testing straightforward:

- **Unit Tests**: Test ViewModels and Repositories
- **Widget Tests**: Test Views in isolation
- **Integration Tests**: Test complete user flows

```dart
// Example ViewModel test
test('should update welcome message', () {
  final viewModel = HomeViewModel();
  viewModel.updateWelcomeMessage('New Message');
  expect(viewModel.welcomeMessage, 'New Message');
});
```

## 🎯 Benefits of This Architecture

- **🔄 Reactive UI**: Automatic UI updates when data changes
- **🧪 Testable**: Easy to unit test business logic
- **🔧 Maintainable**: Clear separation of responsibilities
- **📈 Scalable**: Easy to add new features and screens
- **🎨 Flexible UI**: ViewModels are UI-agnostic
- **🔒 Type Safe**: Strong typing throughout the app

## 📚 Resources

- [Flutter Documentation](https://docs.flutter.dev/)
- [Provider Package](https://pub.dev/packages/provider)
- [MVVM Pattern Guide](https://docs.microsoft.com/en-us/xamarin/xamarin-forms/enterprise-application-patterns/mvvm)
- [Clean Architecture in Flutter](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
