import 'dart:typed_data';

class User {
  final String? name;
  final String? surname;
  final String? email;
  final String? password;
  final String? username;

  ByteData? profileImage;

  User({
    this.name,
    this.surname,
    this.email,
    this.password,
    this.username,
    this.profileImage,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      surname: json['surname'],
      email: json['email'],
      password: json['password'],
      username: json['username'],
      profileImage: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'surname': surname,
      'email': email,
      'password': password,
      'username': username,
      'image': profileImage.toString(),
    };
  }
}
