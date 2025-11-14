import '../models/user.dart';
import '../services/api_service.dart';

class UserRepository {
  final ApiService _apiService;

  UserRepository(this._apiService);

  Future<List<User>> getUsers() async {
    try {
      final response = await _apiService.get('/users');
      if (response is List) {
        return response.map((json) => User.fromJson(json as Map<String, dynamic>)).toList();
      }
      throw Exception('Invalid response format');
    } catch (e) {
      throw Exception('Failed to fetch users: $e');
    }
  }

  Future<User> getUserById(String id) async {
    try {
      final response = await _apiService.get('/users/$id');
      return User.fromJson(response as Map<String, dynamic>);
    } catch (e) {
      throw Exception('Failed to fetch user: $e');
    }
  }

  Future<User> createUser(User user) async {
    try {
      final response = await _apiService.post('/users', user.toJson());
      return User.fromJson(response);
    } catch (e) {
      throw Exception('Failed to create user: $e');
    }
  }
}