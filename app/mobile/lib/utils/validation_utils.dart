// Includes functions for input validation, email validation, or other common form validation tasks.

class ValidationUtils {
  static bool isNameValid(String name) {
    // Name should not be empty and should contain only letters.
    final nameRegExp = RegExp(r'^[A-Za-z ]+$');
    return name.isNotEmpty && nameRegExp.hasMatch(name);
  }

  static bool isEmailValid(String email) {
    // A simple email validation check using a regular expression.
    final emailRegExp = RegExp(
      r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$',
    );
    return emailRegExp.hasMatch(email);
  }

  static bool isPasswordValid(String password) {
    // Password should be at least 8 characters long.
    return password.length >= 6;
  }
}
