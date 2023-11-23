import 'package:flutter/material.dart';
import 'package:mobile/data/models/game_model.dart';
import 'package:mobile/data/services/game_service.dart';
import 'package:mobile/presentation/widgets/app_bar_widget.dart';
import 'package:mobile/presentation/widgets/drawer_widget.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:mobile/presentation/widgets/game_card_widget.dart';
import 'package:mobile/presentation/widgets/markdown_widget.dart';


class GameWikiPage extends StatelessWidget {
  

  GameWikiPage({super.key, required this.game});

  final Game game;

  final List<Game> itemList =  GameService.getGameDataList();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Game Page"),
      drawer: const CustomDrawer(),
      body: ListView(
          children: [
            Card(
              margin: const EdgeInsets.symmetric(horizontal:10,vertical: 4),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              child: SizedBox(
                width: 500 ,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Text(game.name, style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700)),
                              const SizedBox( height: 15,),
                              const Align(
                                alignment: Alignment.centerLeft,
                                child: Text("Release Date: ",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600))
                              ),
                              const Align(
                                alignment: Alignment.centerLeft,
                                child: Text("Jan 25, 2018",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w400))
                              ),
                              const SizedBox( height: 10,),
                              const Align(
                                alignment: Alignment.centerLeft,
                                child: Text("Released By:  ",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600))
                              ),
                              const Align(
                                alignment: Alignment.centerLeft,
                                child: Text("Maddy Makes Games",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w400))
                              ),
                              const SizedBox( height: 10,),
                              const Align(
                                alignment: Alignment.centerLeft,
                                child: Text("Genre: ",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600))
                              ),
                              const Align(
                                alignment: Alignment.centerLeft,
                                child: Text("Adventure, Indie, Platform",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w400))
                              ),
                              const SizedBox( height: 10,),
                              const Align(
                                alignment: Alignment.centerLeft,
                                child: Text("Rating: ",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500))
                              ),
                              const Align(
                                alignment: Alignment.centerLeft,
                                child: Text("4.5",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w400))
                              ),
                              const SizedBox( height: 10,),
                              RatingBar.builder(
                                initialRating: 0,
                                minRating: 0,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemSize: 30,
                                itemCount: 5,
                                itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                                itemBuilder: (context, _) => Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                onRatingUpdate: (rating) {
                                  print(rating);
                                },
                              ),
                        
                            ],
                          )
                        ),
                        Container(
                          height: 200,
                          width: 150, // Size of image
                          decoration:  BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(game.imageLink),
                              fit: BoxFit.fill,
                            )
                          ),
                        ),
                      ],
                    ),
                  ]
                ),
              )
            ),
            Card(
              margin: const EdgeInsets.symmetric(horizontal:10,vertical: 4),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              child: SizedBox(
                width: 500 ,
                child:                     SizedBox(
                      height: 500,
                      child: SingleChildScrollView(
                        child: MarkdownBody(data: game.description, shrinkWrap: true,),
                      )
                    ),
              ),
            ),
            Card(
              margin: const EdgeInsets.symmetric(horizontal:10,vertical: 4),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              child: SizedBox(
                width: 500 ,
                child: Column(
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Similar Games: ",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w700, ))
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 20),
                      height: 235,
                      child: ListView(
                        // This next line does the trick.
                        scrollDirection: Axis.horizontal,
                        children: [
                          for (var i = 0; i < 6; i++) VerticalGameCard(game: itemList[i]),
                        ],
                      ),
                    ),
                 ],
                )
              ),
            ),
          ],
        ),
    );
  }
}

class VerticalGameCard extends StatelessWidget {
  final Game game;

  const VerticalGameCard({
    super.key,
    required this.game
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>  GameWikiPage(game: game,)),
        );
      },
      child: SizedBox(
        width: 160,
        child: Column(
          children: [
            Container(
              height: 200,
              width: 150,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(game.imageLink),
                  fit: BoxFit.fill,
                )
              ),
            ),
            Text(game.name, maxLines: 3,),
          ]
        ),
      ),

    );
  }
}