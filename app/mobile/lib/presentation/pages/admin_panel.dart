import 'package:autoscale_tabbarview/autoscale_tabbarview.dart';
import 'package:flutter/material.dart';
import 'package:mobile/data/models/game_model.dart';
import 'package:mobile/data/services/admin_service.dart';
import 'package:mobile/presentation/pages/admin_game_page.dart';
import 'package:mobile/presentation/widgets/app_bar_widget.dart';
import 'package:mobile/presentation/widgets/game_card_widget.dart';

class AdminPanel extends StatefulWidget {
  const AdminPanel({super.key});

  @override
  State<AdminPanel> createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> with SingleTickerProviderStateMixin{
  final AdminService adminService = AdminService();

  late TabController tabController;

  bool showCreatedGames = true;
  

  Future<List<Game>> loadGames() async {

    List<Game> gameList = await adminService.getPendingGames();

    return gameList;
  }

  Future<List<Game>> loadEditedGames() async {

    List<Game> gameList = await adminService.getEditedGames();

    return gameList;
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  void initState() {
      super.initState();
      tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Admin Panel",showBackButton: false,),
      body: Column(
        children: [
          TabBar(
            controller: tabController,
            isScrollable: true,
            tabs: [
              Tab(
                text: 'Created Games',
              ),
              Tab(
                text: 'Updated Games',
              ),
              Tab(
                text: 'Reports',
              ),
            ],
            labelColor: Colors.black,
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: [
                // Tab 1
                FutureBuilder<List<Game>>(
                  future: loadGames(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text("Error: ${snapshot.error}"));
                    } else {
                      List<Game> gameList = snapshot.data ?? [];
                      return ListView(
                        children: [
                          for (var game in gameList)
                            GestureDetector(
                              onTap: () {
                                // Open a new page with game information
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AdminGamePage(game: game),
                                  ),
                                );
                              },
                              child: GameCard(game: game),
                            )
                        ],
                      );
                    }
                  },
                ),
                FutureBuilder<List<Game>>(
                  future: loadEditedGames(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text("Error: ${snapshot.error}"));
                    } else {
                      List<Game> gameList = snapshot.data ?? [];
                      if (gameList.isEmpty) {
                        return Center(child: Text("Nothing to show"));
                      }
                      return ListView(
                        children: [
                          for (var game in gameList)
                            GestureDetector(
                              onTap: () {
                                // Open a new page with game information
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AdminGamePage(game: game),
                                  ),
                                );
                              },
                              child: GameCard(game: game),
                            )
                        ],
                      );
                    }
                  },
                ),
                // Tab 2
                const Center(
                  child: Text("Nothing to show",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      )),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
