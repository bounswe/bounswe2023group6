import 'package:flutter/material.dart';
import 'package:mobile/data/models/content_model.dart';
import 'package:mobile/data/models/post_model.dart';

class PostCard extends StatelessWidget {
  final Post post;

  const PostCard({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/post', arguments: post.id);
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            userInformationSection(context, post.ownerUser),
            postContentSection(post),
          ]),
        ),
      ),
    );
  }
}

Widget postContentSection(Post post) {
  return Flexible(
    child: Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Text(post.title!,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis,
              maxLines: 2),
        ),
        const SizedBox(
          height: 5,
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Text(post.content,
              style: const TextStyle(fontSize: 14),
              overflow: TextOverflow.ellipsis,
              maxLines: 3),
        ),
        // Text(post.timeAgo, style: const TextStyle(fontSize: 12,color: Colors.grey),overflow: TextOverflow.ellipsis,maxLines: 1),
        const SizedBox(
          height: 5,
        ),
        postSocialSection(post),
      ],
    ),
  );
}

Widget postSocialSection(Post post) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Row(
        children: [
          const Icon(Icons.thumb_up_alt_rounded),
          const SizedBox(
            width: 10,
          ),
          Text(post.likes.toString()),
        ],
      ),
      Row(
        children: [
          const Icon(Icons.thumb_down_alt_rounded),
          const SizedBox(
            width: 10,
          ),
          Text(post.dislikes.toString()),
        ],
      ),
      Row(
        children: [
          const Icon(Icons.comment),
          const SizedBox(
            width: 10,
          ),
          Text(post.comments.toString()),
        ],
      ),
    ],
  );
}
