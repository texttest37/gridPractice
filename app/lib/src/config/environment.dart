enum EnvironmentType {
  development,
  staging,
  production,
}

class Environment {
  static EnvironmentType _currentEnvironment = EnvironmentType.development;

  static EnvironmentType get currentEnvironment => _currentEnvironment;

  static void setEnvironment(EnvironmentType environment) {
    _currentEnvironment = environment;
  }

  static String get apiBaseUrl {
    switch (_currentEnvironment) {
      case EnvironmentType.development:
        return 'https://dev-api.example.com';
      case EnvironmentType.staging:
        return 'https://staging-api.example.com';
      case EnvironmentType.production:
        return 'https://api.example.com';
    }
  }

  static Duration get apiTimeout {
    switch (_currentEnvironment) {
      case EnvironmentType.development:
        return const Duration(seconds: 60);
      case EnvironmentType.staging:
        return const Duration(seconds: 45);
      case EnvironmentType.production:
        return const Duration(seconds: 30);
    }
  }

  static bool get enableLogging {
    switch (_currentEnvironment) {
      case EnvironmentType.development:
        return true;
      case EnvironmentType.staging:
        return true;
      case EnvironmentType.production:
        return false;
    }
  }

  static String get environmentName {
    switch (_currentEnvironment) {
      case EnvironmentType.development:
        return 'Development';
      case EnvironmentType.staging:
        return 'Staging';
      case EnvironmentType.production:
        return 'Production';
    }
  }

  static bool get isDevelopment => _currentEnvironment == EnvironmentType.development;
  static bool get isStaging => _currentEnvironment == EnvironmentType.staging;
  static bool get isProduction => _currentEnvironment == EnvironmentType.production;

  static Map<String, dynamic> get config {
    return {
      'environment': environmentName,
      'apiBaseUrl': apiBaseUrl,
      'apiTimeout': apiTimeout.inSeconds,
      'enableLogging': enableLogging,
    };
  }
}
