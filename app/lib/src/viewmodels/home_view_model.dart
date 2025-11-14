import 'base_view_model.dart';

class HomeViewModel extends BaseViewModel {
  String _welcomeMessage = 'Welcome to Home Screen';
  String _description = 'This is a simple home screen';

  String get welcomeMessage => _welcomeMessage;
  String get description => _description;

  void updateWelcomeMessage(String message) {
    _welcomeMessage = message;
    notifyListeners();
  }

  void updateDescription(String description) {
    _description = description;
    notifyListeners();
  }
}