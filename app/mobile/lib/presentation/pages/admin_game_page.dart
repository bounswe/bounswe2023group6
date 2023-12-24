import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:mobile/data/models/game_model.dart';
import 'package:mobile/data/services/admin_service.dart';
import 'package:mobile/presentation/widgets/app_bar_widget.dart';

class AdminGamePage extends StatefulWidget {
  final Game game;
  const AdminGamePage({super.key, required this.game});

  @override
  State<AdminGamePage> createState() => _AdminGamePageState();
}

class _AdminGamePageState extends State<AdminGamePage> {

  AdminService adminService  = AdminService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Pending Game"),
      body: ListView(
              children: [
                Card(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    child: SizedBox(
                      width: 500,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                  child: Column(
                                children: [
                                  Text(widget.game.title,
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700)),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  const Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text("Release Year: ",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600))),
                                  Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                          widget.game.releaseYear!.toString() ?? "-",
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400))),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text("Genre: ",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600))),
                                  Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(widget.game.genre ?? "-",
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400))),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            ),                       ],
                          ),
                        ],
                      ),
                    )),
                SizedBox(
                  height: 10,
                ),
                Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  child: Column(
                    children: [
                      const Text(
                        "Description",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w700),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: SizedBox(
                          width: 500,
                          child: MarkdownBody(
                            data: widget.game.description,
                            shrinkWrap: true,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  child: Container(
                    width: 500,
                    child: Column(
                      children: <Widget>[
                        const Text(
                          "Additional Information",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w700),
                        ),
                        if (widget.game.platform != null)
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: RichText(
                                  text: TextSpan(
                                style: TextStyle(color: Colors.black),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: "Platforms: ",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w500),
                                  ),
                                  TextSpan(
                                    text: widget.game.platform!,
                                  )
                                ],
                              )),
                            ),
                          ),
                        if (widget.game.mechanics != null)
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: RichText(
                                  text: TextSpan(
                                style: TextStyle(color: Colors.black),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: "Mechanics: ",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w500),
                                  ),
                                  TextSpan(
                                    text: widget.game.mechanics!,
                                  )
                                ],
                              )),
                            ),
                          ),
                        if (widget.game.universe != null)
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: RichText(
                                  text: TextSpan(
                                style: TextStyle(color: Colors.black),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: "Universe: ",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w500),
                                  ),
                                  TextSpan(
                                    text: widget.game.universe!,
                                  )
                                ],
                              )),
                            ),
                          ),
                        if (widget.game.playerNumber != null)
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: RichText(
                                  text: TextSpan(
                                style: TextStyle(color: Colors.black),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: "Player Number: ",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w500),
                                  ),
                                  TextSpan(
                                    text: widget.game.playerNumber!,
                                  )
                                ],
                              )),
                            ),
                          ),
                        if (widget.game.playtime != null)
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: RichText(
                                  text: TextSpan(
                                style: TextStyle(color: Colors.black),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: "Playtime: ",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w500),
                                  ),
                                  TextSpan(
                                    text: widget.game.playtime!,
                                  )
                                ],
                              )),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
            Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () async {
                     bool success = await adminService.approveGame(widget.game.gameId);
                     if (success) {
                      Navigator.pop(context);
                     }
                  },
                  child: Text("Approve"),
                ),
                ElevatedButton(
                  onPressed: () async {
                     bool success = await adminService.rejectGame(widget.game.gameId);
                     if (success) {
                      Navigator.pop(context);
                     }                  
                  },
                  style: ElevatedButton.styleFrom(primary: Colors.red),
                  child: Text("Reject"),
                ),
              ],
            ),
          ),

              ],
            ),
    );
    

  }
}



