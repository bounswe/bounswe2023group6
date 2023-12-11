import 'package:flutter/material.dart';
import 'package:mobile/presentation/pages/game_page.dart';
import 'package:mobile/presentation/states/game_list_grid_view_state.dart';

class GridWidget extends StatefulWidget {
  final VoidCallback? onSettingsPressed;

  GridWidget({Key? key, this.onSettingsPressed}) : super(key: key);

  GridViewState createState() => GridViewState();
}
