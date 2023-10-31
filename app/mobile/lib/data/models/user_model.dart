class User {
  final String name;
  final String surname;
  final String email;
  final String password; // Remember to securely hash and salt the password in a real application.

  User({
    required this.name,
    required this.surname,
    required this.email,
    required this.password,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      surname: json['surname'],
      email: json['email'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'surname': surname,
      'email': email,
      'password': password,
    };
  }
}
