import 'package:cladiaq/commons/repository/user_repository.dart';

class AuthenticationService {
  final UserRepository userRepository;

  AuthenticationService(this.userRepository);

  Future login(String email, String password) async {
    try {
      return await userRepository.login(email, password);

      // Optionally, you can perform any additional logic after a successful login
    } catch (e) {
      // Handle login errors (e.g., show an error message)
      print(e.toString());
      throw Exception('Login failed: ${e.toString()}');
    }
  }

  Future register(String username, String email, String password) async {
    try {
      return await userRepository.register(username, email, password);
      // Optionally, you can perform actions after successful registration
    } catch (e) {
      // Handle registration errors
      throw Exception('Registration failed: ${e.toString()}');
    }
  }

  Future<void> logout() async {
    try {
      await userRepository.logout();
      // Optionally, handle any additional logic after logout (e.g., navigate to login screen)
    } catch (e) {
      // Handle logout errors
      throw Exception('Logout failed: ${e.toString()}');
    }
  }

  Future<String?> getToken() async {
    return await userRepository.getToken();
  }
}
