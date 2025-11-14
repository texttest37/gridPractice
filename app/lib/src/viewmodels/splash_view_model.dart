import 'base_view_model.dart';

class SplashViewModel extends BaseViewModel {
  bool _isInitialized = false;
  
  bool get isInitialized => _isInitialized;
  
  Future<void> initialize() async {
    setLoading(true);
    
    try {
      // Simulate app initialization delay
      await Future.delayed(const Duration(seconds: 2));
      
      // Perform any necessary app initialization here
      // e.g., check authentication, load user preferences, etc.
      
      _isInitialized = true;
      notifyListeners();
    } catch (e) {
      setError('Failed to initialize app: $e');
    } finally {
      setLoading(false);
    }
  }
}