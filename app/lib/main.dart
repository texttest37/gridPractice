import 'package:app/src/app.dart';
import 'package:flutter/material.dart';
import 'src/config/environment.dart';
import 'src/utils/logger.dart';

void main() {
  // Get environment from build arguments
  // Use: flutter run --dart-define=ENVIRONMENT=dev|staging|prod
  const environmentString = String.fromEnvironment('ENVIRONMENT', defaultValue: 'dev');

  // Set environment based on build argument
  switch (environmentString.toLowerCase()) {
    case 'prod':
    case 'production':
      Environment.setEnvironment(EnvironmentType.production);
      break;
    case 'staging':
      Environment.setEnvironment(EnvironmentType.staging);
      break;
    case 'dev':
    case 'development':
    default:
      Environment.setEnvironment(EnvironmentType.development);
      break;
  }

  // Log environment configuration
  Logger.logEnvironmentConfig();

  runApp(const MyApp());
}
