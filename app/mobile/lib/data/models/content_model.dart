import 'package:flutter/material.dart';
import 'package:mobile/data/models/comment_model.dart';
import 'package:mobile/data/models/user_model.dart';

enum ContentType { post, comment, lfg }

class Content {
  final DateTime createdDate;
  final int id;
  final String content;
  final ContentType type;
  final int userId;
  final String username; 
  // final List<String>? annotations;
  // final List<String>? tags;
  // final List<Report> reports;
  // final List<Content>? relatedContent;
  // final List<Content>? relatedGames;
  // final List<Content>? relatedUsers;

  int likes;
  int dislikes;
  int comments;
  int shares;
  int views;

  List<int> likeIds = [];
  List<int> dislikeIds = [];
  List<int> commentIds = [];

  List<Comment> commentList = [];

  // User? ownerUser;
  String? title; // For post and lfg

  Content({
    required this.id,
    required this.content,
    required this.type,
    required this.userId,
    required this.username,
    required this.createdDate,
    // this.annotations,
    // this.tags,
    // this.reports,
    // this.relatedContent,
    // this.relatedGames,
    // this.relatedUsers,
    this.title,
    this.likes = 0,
    this.dislikes = 0,
    this.comments = 0,
    this.shares = 0,
    this.views = 0,
  });

  // Content initialize
}


// Content related widgets
Widget userInformationSection(Content content) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            const Icon(Icons.account_circle),
            SizedBox(
              width: 50,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(content.username,
                      style: const TextStyle(fontSize: 13)),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }