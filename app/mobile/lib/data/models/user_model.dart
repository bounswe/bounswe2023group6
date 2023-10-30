class User {
  final String name;
  final String surname;
  final String email;
  final String
      password; // Remember to securely hash and salt the password in a real application.
  final String username;

  User({
    required this.name,
    required this.surname,
    required this.email,
    required this.password,
    required this.username,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      surname: json['surname'],
      email: json['email'],
      password: json['password'],
      username: json['username'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'surname': surname,
      'email': email,
      'password': password,
      'username': username,
    };
  }
}
