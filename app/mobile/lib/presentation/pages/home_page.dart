import 'package:flutter/material.dart';
import 'package:mobile/constants/text_constants.dart';

import 'package:mobile/presentation/widgets/app_bar_widget.dart';
import 'package:mobile/presentation/widgets/drawer_widget.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var isLoggedIn = true;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: const CustomAppBar(title: TextConstants.titleText),
      drawer: const CustomDrawer(),
      body:ListView(
        children: const [
          PostCard(),
          PostCard(),
          PostCard(),
          PostCard(),
          PostCard(),
          PostCard(),
        ],
      )
    );
  }
}


class PostCard extends StatelessWidget {
  const PostCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal:10,vertical: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child:  const SizedBox(
        height: 150,
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween, 
            children: [
              Row(
                children: [
                  Icon(Icons.verified_user_outlined),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Username . 8hr',style: TextStyle(fontSize: 15)),
                  ),
                ],
              ),
              Center(child: SizedBox()),
              Align(
                alignment: Alignment.topLeft,
                child: Text("Usta oyuncudan mid line oynama rehberi fdsafdfdfdf fdf  fd fd f df d f df",style: TextStyle(fontSize: 18)),
              ),
              SizedBox(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.thumb_up_alt_rounded),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("15",style: TextStyle(fontSize: 15)),
                  ),
                  Icon(Icons.thumb_down_alt_rounded),
                  Text("20"),
                  Icon(Icons.comment),
                  Text("20"),
                ],
              )
            ]
          ),
        ) ,
      ),
    );
  }
}