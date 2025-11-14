# Environment Configuration Guide

This project supports multiple environments using a single `main.dart` file with build arguments.

## Quick Start

### Running Different Environments

#### Development (Default)
```bash
flutter run
# OR explicitly
flutter run --dart-define=ENVIRONMENT=dev
```

#### Staging
```bash
flutter run --dart-define=ENVIRONMENT=staging
```

#### Production
```bash
flutter run --dart-define=ENVIRONMENT=prod
```

## Environment Configuration

### Current Settings

| Environment | API Base URL | Timeout | Logging |
|------------|--------------|---------|---------|
| Development | `https://dev-api.example.com` | 60s | ✅ Enabled |
| Staging | `https://staging-api.example.com` | 45s | ✅ Enabled |
| Production | `https://api.example.com` | 30s | ❌ Disabled |

### Customizing Environment Settings

Edit [lib/src/config/environment.dart](lib/src/config/environment.dart):

```dart
static String get apiBaseUrl {
  switch (_currentEnvironment) {
    case EnvironmentType.development:
      return 'YOUR_DEV_API_URL';
    case EnvironmentType.staging:
      return 'YOUR_STAGING_API_URL';
    case EnvironmentType.production:
      return 'YOUR_PRODUCTION_API_URL';
  }
}
```

## Building for Different Environments

### Android

```bash
# Development
flutter build apk --dart-define=ENVIRONMENT=dev

# Staging
flutter build apk --dart-define=ENVIRONMENT=staging

# Production
flutter build apk --dart-define=ENVIRONMENT=prod --release
```

### iOS

```bash
# Development
flutter build ios --dart-define=ENVIRONMENT=dev

# Staging
flutter build ios --dart-define=ENVIRONMENT=staging

# Production
flutter build ios --dart-define=ENVIRONMENT=prod --release
```

### Web

```bash
# Development
flutter build web --dart-define=ENVIRONMENT=dev

# Staging
flutter build web --dart-define=ENVIRONMENT=staging

# Production
flutter build web --dart-define=ENVIRONMENT=prod --release
```

## VS Code Launch Configurations

Create `.vscode/launch.json` for easy environment switching:

```json
{
  "version": "0.2.0",
  "configurations": [
    {
      "name": "Development",
      "request": "launch",
      "type": "dart",
      "args": [
        "--dart-define=ENVIRONMENT=dev"
      ]
    },
    {
      "name": "Staging",
      "request": "launch",
      "type": "dart",
      "args": [
        "--dart-define=ENVIRONMENT=staging"
      ]
    },
    {
      "name": "Production",
      "request": "launch",
      "type": "dart",
      "args": [
        "--dart-define=ENVIRONMENT=prod"
      ]
    }
  ]
}
```

## Logging

The project uses a custom `Logger` utility that respects environment settings.

### Usage Examples

```dart
import 'package:app/src/utils/logger.dart';

// Debug logging
Logger.debug('This is a debug message');

// Info logging
Logger.info('User logged in successfully');

// Warning logging
Logger.warning('API response took longer than expected');

// Error logging
Logger.error('Failed to fetch data', error: e, stackTrace: stackTrace);
```

### Logging Behavior

- **Development**: All logs are printed
- **Staging**: All logs are printed
- **Production**: Logging is disabled

## Environment Detection in Code

```dart
import 'package:app/src/config/environment.dart';

if (Environment.isDevelopment) {
  // Development-only code
}

if (Environment.isStaging) {
  // Staging-only code
}

if (Environment.isProduction) {
  // Production-only code
}

// Get environment info
print(Environment.environmentName);      // "Development", "Staging", or "Production"
print(Environment.apiBaseUrl);           // Current API URL
print(Environment.apiTimeout);           // Current timeout duration
print(Environment.enableLogging);        // true or false
print(Environment.config);               // Full config map
```

## API Service Integration

The `ApiService` automatically uses environment configuration:

```dart
// Automatically uses correct base URL and timeout based on environment
final apiService = ApiService();
final data = await apiService.get('/users');

// Logs are automatically added based on environment
// Development/Staging: Shows detailed request/response logs
// Production: No logs
```

## Best Practices

1. **Never commit API keys** - Use environment variables or secure storage
2. **Test in staging** before deploying to production
3. **Enable logging** in development and staging for debugging
4. **Disable logging** in production for performance and security
5. **Use appropriate timeouts** for each environment
6. **Keep API URLs** in environment configuration, not hardcoded

## Troubleshooting

### Issue: Environment not switching
- Ensure you're using `--dart-define=ENVIRONMENT=<env>`
- Restart the app completely (hot reload won't update compile-time constants)

### Issue: Logs not appearing
- Check if logging is enabled for your environment in `environment.dart`
- Verify you're using `Logger` class, not `print()`

### Issue: API timeouts
- Adjust timeout values in `environment.dart`
- Check network connectivity
- Verify API URL is correct for the environment

## File Structure

```
lib/
├── main.dart              # Single entry point with environment detection
└── src/
    ├── config/
    │   └── environment.dart               # Environment configuration
    ├── utils/
    │   ├── logger.dart                    # Logging utility
    │   └── constants/
    │       └── colors.dart                # UI constants
    └── services/
        └── api_service.dart               # HTTP service with environment integration
```

## Additional Configuration Options

You can add more environment-specific settings in `lib/src/config/environment.dart`:

```dart
// Example: Feature flags
static bool get enableAnalytics {
  return _currentEnvironment != EnvironmentType.development;
}

// Example: Custom API endpoints
static String get authEndpoint => '$apiBaseUrl/auth';
static String get userEndpoint => '$apiBaseUrl/users';

// Example: Environment-specific keys
static String get apiKey {
  switch (_currentEnvironment) {
    case EnvironmentType.development:
      return 'dev_key_12345';
    case EnvironmentType.staging:
      return 'staging_key_67890';
    case EnvironmentType.production:
      return 'prod_key_abcde';
  }
}
```
