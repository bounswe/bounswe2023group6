import 'package:autoscale_tabbarview/autoscale_tabbarview.dart';
import 'package:flutter/material.dart';
import 'package:mobile/data/models/game_model.dart';
import 'package:mobile/data/services/admin_service.dart';
import 'package:mobile/presentation/widgets/app_bar_widget.dart';

class AdminPanel extends StatefulWidget {
  const AdminPanel({super.key});

  @override
  State<AdminPanel> createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> with SingleTickerProviderStateMixin{
  final AdminService adminService = AdminService();

  late TabController tabController;

  Future<List<Game>> loadGames() async {

    List<Game> gameList = await adminService.getPendingGames();

    return gameList;
  }

  @override
  void initState() {
    super.initState();

    setState(() {
      tabController = TabController(length: 2, vsync: this);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Admin Panel",),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TabBar(
              controller: tabController,
              tabs: [
                Tab(
                  text: 'Related Posts',
                ),
                Tab(
                  text: 'Related LFGs',
                ),
              ],
              labelColor: Colors.black,
            ),
            Container(
              child: AutoScaleTabBarView(
                  controller: tabController,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 20),
                      child: Column(
                        // This next line does the trick.
                        children: [
                          for (var i = 0;
                              i < 10;
                              i++)
                            Text("Contetn"),
                        ],
                      ),
                    ),
                    const Column(
                      children: [
                        SizedBox(
                          height: 25,
                        ),
                        Center(
                            child: Text("Nothing to show",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ))),
                        SizedBox(
                          height: 25,
                        ),
                      ],
                    )
                  ]
                ),
            ),
          ],
        ),
      ),
    );
  }
}