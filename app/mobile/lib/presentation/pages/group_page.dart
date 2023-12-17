import 'package:flutter/material.dart';
import 'package:mobile/data/models/comment_model.dart';
import 'package:mobile/data/models/lfg_model.dart';
import 'package:mobile/data/models/user_model.dart';
import 'package:mobile/data/services/lfg_service.dart';
import 'package:mobile/presentation/widgets/app_bar_widget.dart';
import 'package:mobile/presentation/widgets/avatar_widget.dart';
import 'package:mobile/utils/cache_manager.dart';
import 'package:mobile/utils/shared_manager.dart';

class GroupPage extends StatefulWidget {
  const GroupPage({super.key});

  @override
  State<GroupPage> createState() => _GroupPageState();
}

class _GroupPageState extends State<GroupPage> {

  final LFGService lfgService =LFGService();
  late User currentUser;
  final TextEditingController _commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    initializeUser();
  }

  Future<void> initializeUser() async {
    final SharedManager manager = SharedManager();
    await manager.init();
    currentUser = CacheManager(manager).getUser();
  }

  Future<LFG> loadlfg(int lfgId) async {
    LFG lfg = await lfgService.getLFG(lfgId);

    return lfg;
  }

  static late LFG lfg;

  @override
  Widget build(BuildContext context) {
    final int lfgId = ModalRoute.of(context)!.settings.arguments as int;
    return FutureBuilder(
      future: loadlfg(lfgId),
      builder: (BuildContext context, AsyncSnapshot<LFG> snapshot) {
        if (snapshot.hasData) {
          lfg = snapshot.data!;
          return Scaffold(
            appBar: CustomAppBar(title: "LFG Page"),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Card(
                    margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children:[
                          Row(
                            children: [
                              userInformationSectionLfg(
                                  currentUser.username,
                                  currentUser.profilePicture),
                              Flexible(
                                child: Container(
                                  child: Column(
                                    children: [
                                      Text(
                                        lfg.title,
                                        style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                                      ),
                                      Text(lfg.description),
                                      const Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text("Game: ",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600))),
                                      const Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text("Language: ",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600))),
                                      const Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text("Platform: ",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600))),
                                      const Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text("Mic/Cam: ",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600)))
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(Icons.people),
                              Container(
                                child: Column(
                                  children: [
                                    Text("Players"),
                                    Text("3/5"),
                                  ]
                                ),
                              ),
                              InkWell(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.blue,
                                    border: Border.all(
                                      color: Colors.black,
                                    ),
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                  ),
                                  width: 100,
                                  height: 40,
                                  //color: Colors.amberAccent,
                                  child: Center(child: Text("JOIN")),
                                ),
                              )
                            ],
                          )
                        ] 
                      ),
                    )
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Comments',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  leaveNewCommentSectionLfg(lfg),
                ],
              )
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },

    );
  }


  Widget userInformationSectionLfg(String username, String profileImage){
    return InkWell(
      onTap: () {
        // go to profile page
        Navigator.pushNamed(context, '/profile', arguments: username);
      },
      child: Column(
        children: [
          profileImage != ''
              ? DisplayAvatar(
                  imageLink: profileImage,
                  size: 20,
                )
              : const Icon(Icons.account_circle),
          SizedBox(
            width: 80,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(username, style: const TextStyle(fontSize: 13)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget leaveNewCommentSectionLfg(LFG lfg) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              userInformationSectionLfg(
                  currentUser.username,
                  currentUser.profilePicture),
              newCommentSection(lfg),
            ],
          )),
    );
  }

  Widget newCommentSection(LFG lfg) {
    return Flexible(
      fit: FlexFit.loose,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Align(
                alignment: Alignment.topLeft,
                child: Text('Leave a comment',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ),
              IconButton(
                icon: const Icon(Icons.send),
                onPressed: () async {
                },
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: TextField(
              controller: _commentController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter your comment',
              ),
              onChanged: (text) {},
            ),
          ),
        ],
      ),
    );
  }

}