import 'package:flutter/material.dart';
import 'package:mobile/data/models/content_model.dart';

Widget updateWidget(BuildContext context, {required Content content}) {
  ContentType contentType = content.type;
  if (contentType == ContentType.post) {
    return _buildPostUpdateWidget(context, content);
  } else {
    return _buildCommentUpdateWidget(context, content);
  }
}

Widget _buildPostUpdateWidget(BuildContext context, Content post) {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();

  return AlertDialog(
    title: const Text("Update Post"),
    // increase size of the alert dialog
    content: SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: titleController..text = post.title!,
            decoration: const InputDecoration(
              hintText: "Title",
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter a title";
              }
              return null;
            },
          ),
          TextFormField(
            controller: bodyController..text = post.content,
            minLines: 3,
            maxLines: 5,
            decoration: const InputDecoration(
              hintText: "Body",
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter a body";
              }
              return null;
            },
          ),
        ],
      ),
    ),
    actions: [
      TextButton(
        child: const Text("Cancel"),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      TextButton(
        child: const Text("Update"),
        onPressed: () {
          post.title = titleController.text;
          post.content = bodyController.text;
          // postService.updatePost(newContent);
          Navigator.of(context).pop();
        },
      ),
    ],
  );
}

Widget _buildCommentUpdateWidget(BuildContext context, Content content) {
  final TextEditingController bodyController = TextEditingController();

  return AlertDialog(
    title: const Text("Update Comment"),
    // increase size of the alert dialog
    content: SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: bodyController..text = content.content,
            minLines: 3,
            maxLines: 5,
            decoration: const InputDecoration(
              hintText: "Body",
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter a body";
              }
              return null;
            },
          ),
        ],
      ),
    ),
    actions: [
      TextButton(
        child: const Text("Cancel"),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      TextButton(
        child: const Text("Update"),
        onPressed: () {
          content.content = bodyController.text;
          // postService.updateComment(newContent);
          Navigator.of(context).pop();
        },
      ),
    ],
  );
}