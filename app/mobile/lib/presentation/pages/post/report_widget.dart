import 'package:flutter/material.dart';
import 'package:mobile/data/models/content_model.dart';
import 'package:mobile/data/services/comment_service.dart';
import 'package:mobile/data/services/game_service.dart';
import 'package:mobile/data/services/post_service.dart';

class ReportWidget extends StatelessWidget {
  final Content content;
  ReportWidget({Key? key, required this.content}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final _reasonController = TextEditingController();
  final _descriptionController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Report"),
      // increase size of the alert dialog
      
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _reasonController,
              decoration: const InputDecoration(
                hintText: "Reason",
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter a reason";
                }
                return null;
              },
            ),
            TextFormField(
              controller: _descriptionController,
              minLines: 3,
              maxLines: 5,
              decoration: const InputDecoration(
                hintText: "Description",
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter a description";
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
          child: const Text("Report"),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              String reason = _reasonController.text;
              String description = _descriptionController.text;
              content.type == ContentType.post
                  ? PostService().reportPost(content.id, reason, description)
                  : CommentService().reportComment(content.id, reason, description);
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text("Report"),
                    content: const Text("Your report has been sent."),
                    actions: [
                      TextButton(
                        child: const Text("OK"),
                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            }
          },
        ),
      ],
    );
  }
}


class ReportWidgetForGame extends StatelessWidget {
  final int gameid;

  ReportWidgetForGame({Key? key, required this.gameid }) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final _reasonController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Report"),
      // increase size of the alert dialog
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _reasonController,
              decoration: const InputDecoration(
                hintText: "Reason",
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter a reason";
                }
                return null;
              },
            ),
            TextFormField(
              controller: _descriptionController,
              minLines: 3,
              maxLines: 5,
              decoration: const InputDecoration(
                hintText: "Description",
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter a description";
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
          child: const Text("Report"),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              String reason = _reasonController.text;
              String description = _descriptionController.text;
              GameService().reportGame(gameid, reason, description);
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text("Report"),
                    content: const Text("Your report has been sent."),
                    actions: [
                      TextButton(
                        child: const Text("OK"),
                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            }
          },
        ),
      ],
    );
  }
}