import 'package:flutter/material.dart';
import 'package:mobile/presentation/widgets/app_bar_widget.dart';
import 'package:mobile/presentation/widgets/drawer_widget.dart';

class LFGPage extends StatelessWidget {
  const LFGPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(title: "Game Lounge") ,
      body: Text("tsr"),
      drawer: CustomDrawer(),
    );
  }
}