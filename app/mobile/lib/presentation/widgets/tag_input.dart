import 'package:flutter/material.dart';

class TagInput extends StatefulWidget {
  final List<String> tags;
  final TextEditingController tagController;

  const TagInput({
    Key? key,
    required this.tags,
    required this.tagController,
  }) : super(key: key);

  @override
  _TagInputWidgetState createState() => _TagInputWidgetState();
}

class _TagInputWidgetState extends State<TagInput> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: widget.tagController,
                decoration: const InputDecoration(
                  hintText: "Add tags",
                ),
                onFieldSubmitted: (value) {
                  setState(() {
                    widget.tags.add(value);
                    // clear the text field
                    widget.tagController.clear();
                  });
                },
              ),
            ),
            Wrap(
              children: widget.tags
                  .map((tag) => Chip(
                        label: Text(tag),
                        onDeleted: () {
                          setState(() {
                            widget.tags.remove(tag);
                          });
                        },
                      ))
                  .toList(),
            ),
          ],
        ),
      ],
    );
  }
}
