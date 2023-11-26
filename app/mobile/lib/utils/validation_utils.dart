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
    
    final passwordRegExp = RegExp(
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$',
    );
    return passwordRegExp.hasMatch(password);
  }


  static passwordValidation(String password) {
    // Password should be at least 8 characters long.
    
    if (password == '') {
      return null;
    } else if (password.length <= 7) {
      return "Password should be at least 8 characters long.";
    } else if (!password.contains(new RegExp(r'[A-Z]'))) {
      return "Password should contain at least one upper case.";
    } else if (!password.contains(new RegExp(r'[a-z]'))) {
      return "Password should contain at least one lower case.";
    } else if (!password.contains(new RegExp(r'[0-9]'))) {
      return "Password should contain at least one digit.";
    }  else {
      return null;
    }
  }

  static usernameValidation(String username) {

    final usernameRegExp = RegExp(r'^[a-zA-Z0-9]([._-](?![._-])|[a-zA-Z0-9]){3,18}[a-zA-Z0-9]$');

    if (username == '') {
      return null;
    } else if (!usernameRegExp.hasMatch(username)) {
      return "Username should be valid";
    }  else {
      return null;
    }
  }

  static emailValidation(String email) {
    // Password should be at least 8 characters long.

    final emailRegExp = RegExp(
      r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$',
    );
    
    if (email == '') {
      return null;
    } else if (!emailRegExp.hasMatch(email)) {
      return "Email should be valid";
    }  else {
      return null;
    }
  }

  static confirmPasswordValidation(String password, String confirm) {
    // Password should be at least 8 characters long.

    if (password == '') {
      return null;
    } else if (password != confirm) {
      return "Password must be same as above";
    }  else {
      return null;
    }
  }

  static dummyValidation(String value) {
    // Password should be at least 8 characters long.

    return null;
  }

}
