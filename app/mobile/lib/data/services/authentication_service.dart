import '../models/user_model.dart'; // Import the User model
import 'dart:async';

class AuthenticationService {
  // Simulated user data for demonstration (replace with a database or authentication service)
  final Map<String, User> _users = {};
  User? _currentUser;

  // User registration
  Future<bool> register(String name, String surname, String email, String password) async {
    if (_users.containsKey(email)) {
      return false; // User already exists
    } else {
      final user = User(name: name, surname: surname, email: email, password: password);
      _users[email] = user; // Store the user
      return true; // Successful registration
    }
  }

  // User login
  Future<User?> login(String email, String password) async {
    if (_users.containsKey(email)) {
      final user = _users[email];
      if (user!.password == password) {
        _currentUser = user;
        return user; // Successful login
      }
    }
    return null; // Invalid email or password
  }

  // User logout
  void logout() {
    _currentUser = null;
  }

  // Password reset (not implemented in this example)
  Future<void> resetPassword(String email) async {
    // Implement password reset logic if needed
  }

  // Get the current user
  User? getCurrentUser() {
    return _currentUser;
  }
}

// Example usage:
// AuthenticationService authService = AuthenticationService();
// bool isRegistered = await authService.register("John", "Doe", "john@example.com", "password123");
// User? user = await authService.login("john@example.com", "password123");
// authService.logout();
// User? currentUser = authService.getCurrentUser();
