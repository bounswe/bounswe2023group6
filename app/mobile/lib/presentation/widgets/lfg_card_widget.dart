import 'package:flutter/material.dart';
import 'package:mobile/data/models/lfg_model.dart';

class LFGCard extends StatelessWidget {
  final LFG lfg;

  const LFGCard({
    super.key,
    required this.lfg,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: SizedBox(
        height: 100,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                  flex: 3,
                  child: SizedBox(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(lfg.title),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
