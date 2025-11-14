import 'package:flutter/foundation.dart';
import '../config/environment.dart';

enum LogLevel {
  debug,
  info,
  warning,
  error,
}

class Logger {
  static void log(String message, {LogLevel level = LogLevel.info}) {
    if (!Environment.enableLogging) return;

    final timestamp = DateTime.now().toIso8601String();
    final levelStr = level.name.toUpperCase();

    if (kDebugMode) {
      debugPrint('[$timestamp] [$levelStr] $message');
    }
  }

  static void debug(String message) {
    log(message, level: LogLevel.debug);
  }

  static void info(String message) {
    log(message, level: LogLevel.info);
  }

  static void warning(String message) {
    log(message, level: LogLevel.warning);
  }

  static void error(String message, {Object? error, StackTrace? stackTrace}) {
    if (!Environment.enableLogging) return;

    final timestamp = DateTime.now().toIso8601String();

    if (kDebugMode) {
      debugPrint('[$timestamp] [ERROR] $message');
      if (error != null) {
        debugPrint('Error: $error');
      }
      if (stackTrace != null) {
        debugPrint('StackTrace: $stackTrace');
      }
    }
  }

  static void logEnvironmentConfig() {
    if (!Environment.enableLogging) return;

    if (kDebugMode) {
      debugPrint('=== Environment Configuration ===');
      debugPrint('Environment: ${Environment.environmentName}');
      debugPrint('API Base URL: ${Environment.apiBaseUrl}');
      debugPrint('API Timeout: ${Environment.apiTimeout.inSeconds}s');
      debugPrint('Logging Enabled: ${Environment.enableLogging}');
      debugPrint('================================');
    }
  }
}
