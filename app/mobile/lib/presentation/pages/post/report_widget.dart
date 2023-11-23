import 'package:flutter/material.dart';

class ReportWidget extends StatelessWidget {
  ReportWidget({Key? key}) : super(key: key);

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
              // TODO: sent report to backend
              // content.type == ContentType.post
              //     ? postService.reportPost(content.id, "report")
              //     : postService.reportComment(content.id, "report");              
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