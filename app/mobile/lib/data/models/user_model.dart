import 'dart:convert';
import 'dart:typed_data';

import 'package:mobile/data/models/game_model.dart';
import 'package:mobile/data/models/post_model.dart';

class User {
  final int userId;
  final String email;
  final String username;

  bool? isAdmin;
  String? name;
  String? surname;
  String? about;
  String? title; 
  String? company;

  List<Post> likedPosts = [];
  List<Post> savedPosts = [];
  List<Post> createdPosts = [];
  List<Post> commentedPosts = [];
  List<Post> reportedPosts = [];
  List<Post> blockedPosts = [];

  List<Game> likedGames = [];
  List<Game> createdGames = [];
  List<Game> savedGames = [];

  ByteData? profileImage;
  String profilePicture = '';

  int followers;
  int following;
  List<User> followersList = [];

  User({
    required this.userId,
    required this.email,
    required this.username,
    this.profilePicture = '',
    this.about,
    this.title,
    this.company,
    this.followers = 0,
    this.following = 0,
    this.followersList = const [],
    this.isAdmin,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      isAdmin: json['isAdmin'],
      userId: json['userId'],
      email: json['email'],
      username: json['username'],
      profilePicture: json['profilePicture'] ?? '',
      about: json['about'],
      title: json['title'] ?? '',
      company: json['company'] ?? '',
      followers: json['followers'] ?? 0,
      following: json['following'] ?? 0,
      // followersList: json['followersList'] ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'isAdmin': isAdmin,
      'userId': userId,
      'email': email,
      'username': username,
      'profilePicture': profilePicture,
      'about': about,
      'title': title,
      'company': company,
      'followers': followers,
      'following': following,
      'followersList': followersList,
    };
  }
}
