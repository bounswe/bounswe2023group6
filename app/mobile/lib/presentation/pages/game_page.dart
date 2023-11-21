import 'package:flutter/material.dart';
import 'package:mobile/constants/view_type.dart';
import 'package:mobile/data/models/game_model.dart';
import 'package:mobile/presentation/widgets/app_bar_widget.dart';
import 'package:mobile/presentation/widgets/button_widget.dart';
import 'package:mobile/presentation/widgets/drawer_widget.dart';
import 'package:mobile/presentation/widgets/game_card_widget.dart';
import 'package:mobile/presentation/widgets/grid_widget.dart';

class GamePage extends StatelessWidget {
  GamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: "Game Lounge",
        ),
        drawer: const CustomDrawer(),
        body: SafeArea(child: Center(child: GridWidget())));
  }
}
