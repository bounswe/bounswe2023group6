import 'package:flutter/material.dart';
import 'package:mobile/data/models/content_model.dart';
import 'package:mobile/data/models/post_model.dart';
import 'package:mobile/data/models/report_model.dart';
import 'package:mobile/data/services/admin_service.dart';
import 'package:mobile/presentation/pages/post/content_card_widget.dart';
import 'package:mobile/presentation/widgets/app_bar_widget.dart';
import 'package:mobile/presentation/widgets/post_card_widget.dart';

class AdminPostReportPage extends StatelessWidget {
  AdminPostReportPage({super.key, required this.report});

  final Report report;

  AdminService adminService  = AdminService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Pending Game"),
      body: ListView(
        children: [
          Text("Report Message:"),
          Text(report.reason),
          PostCardAdmin(post: report.reportedPost!),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () async {
                     bool success = await adminService.deletePost(report.reportedPost!.id);
                     if (success) {
                      Navigator.pop(context);
                     }
                  },
                  child: Text("Delete"),
                ),
                ElevatedButton(
                  onPressed: () async {
                     bool success = await adminService.cancelPost(report.reportedPost!.id);
                     if (success) {
                      Navigator.pop(context);
                     }                  
                  },
                  style: ElevatedButton.styleFrom(primary: Colors.red),
                  child: Text("Cancel"),
                ),
                ElevatedButton(
                  onPressed: () async {
                     bool success = await adminService.banUserPost(report.reportedPost!.id);
                     if (success) {
                      Navigator.pop(context);
                     }                  
                  },
                  style: ElevatedButton.styleFrom(primary: Colors.red),
                  child: Text("Ban User"),
                ),
              ],
            ),
          ),


        ],
      ),
    );
  }
}