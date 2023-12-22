import 'package:flutter/material.dart';
import 'package:mobile/constants/color_constants.dart';
import 'package:mobile/constants/view_type.dart';
import 'package:mobile/data/models/game_model.dart';
import 'package:mobile/presentation/states/game_list_grid_view_state.dart';
import 'package:mobile/presentation/widgets/app_bar_widget.dart';
import 'package:mobile/presentation/widgets/button_widget.dart';
import 'package:mobile/presentation/widgets/drawer_widget.dart';
import 'package:mobile/presentation/widgets/game_card_widget.dart';
import 'package:mobile/presentation/widgets/game_grid_widget.dart';

class GamePage extends StatefulWidget {
  GamePage({Key? key}) : super(key: key);

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  late GridWidget gridWidget;
  var isLoggedIn = true;
  late GlobalKey<GridViewState> _gridKey;
  bool isSettingsPressed = false; // Flag to track if settings are pressed

  @override
  void initState() {
    super.initState();
    _gridKey = GlobalKey<GridViewState>();
    gridWidget = GridWidget(
      onSettingsPressed: () {
        setState(() {
          // Toggle the flag when settings are pressed
          isSettingsPressed = !isSettingsPressed;
          _gridKey.currentState?.changeMode();
        });
      },
      key: _gridKey,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Game Lounge",
        actions: [
          IconButton(
            icon: isSettingsPressed
                ? Icon(Icons.view_list_outlined)
                : Icon(Icons.grid_view_outlined),
            onPressed: () {
              if (gridWidget.onSettingsPressed != null) {
                gridWidget.onSettingsPressed!();
              }
            },
          ),
        ],
      ),
      drawer: const CustomDrawer(),
      body: SafeArea(
        child: Builder(
          builder: (context) {
            return Center(child: gridWidget);
          },
        ),
      ),
      floatingActionButton: isLoggedIn
          ? FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, '/create_game_page').then((value) {
                  if (value != null && value == "create") {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Post created"),
                      ),
                    );
                    // refresh the current page
                    Navigator.pushReplacementNamed(context, '/');
                  }
                });
              },
              child: const Icon(
                Icons.add,
                color: ColorConstants.buttonColor,
              ),
            )
          : FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              },
              child: const Icon(Icons.login),
            ),
    );
  }
}
