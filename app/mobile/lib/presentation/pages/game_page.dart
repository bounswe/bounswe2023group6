import 'package:flutter/material.dart';
import 'package:mobile/presentation/widgets/app_bar_widget.dart';
import 'package:mobile/presentation/widgets/drawer_widget.dart';

class GamePage extends StatelessWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: CustomAppBar(title: "Game Lounge") ,
      drawer: CustomDrawer(),
      body: ListView(
        children: const [
          GameCard(),
          GameCard(),
          GameCard(),
          GameCard(),
        ],
      )
    );
  }
}

class GameCard extends StatelessWidget {
  const GameCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: SizedBox(
        height: 100,
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage("https://image.api.playstation.com/vulcan/ap/rnd/202211/0711/kh4MUIuMmHlktOHar3lVl6rY.png"),
                      fit: BoxFit.fill,
                    )
                  ),
                ) 
              ),
              const Expanded(
                flex: 3,
                child: SizedBox(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text("Witcher 3: Wild"),
                  ),
                )
              ),
            ],
          ),
        ),
      ),
     );
  }
}

