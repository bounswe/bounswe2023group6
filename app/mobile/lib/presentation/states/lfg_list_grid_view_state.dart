import 'package:flutter/material.dart';
import 'package:mobile/data/models/lfg_model.dart';
import 'package:mobile/data/services/lfg_service.dart';
import 'package:mobile/presentation/widgets/alert_widget.dart';
import 'package:mobile/presentation/widgets/lfg_card_widget.dart';
import 'package:mobile/utils/cache_manager.dart';
import 'package:mobile/utils/shared_manager.dart';

class GridViewState extends State {
  int countValue = 2;
  int aspectWidth = 2;
  int aspectHeight = 1;
  List<LFG> itemList = getImageDataList();

  static List<LFG> getImageDataList() {
    return LFGService.lfgList;
  }

  late bool isLoggedIn;

  @override
  void initState() {
    super.initState();

    isLoggedIn = SharedManager().checkString(SharedKeys.sessionId);
  }

  changeMode() {
    if (countValue == 2) {
      setState(() {
        countValue = 1;
        aspectWidth = 3;
        aspectHeight = 1;
      });
    } else {
      setState(() {
        countValue = 2;
        aspectWidth = 2;
        aspectHeight = 1;
      });
    }
  }

  getGridViewSelectedItem(BuildContext context, LFG gridItem) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertWidget(
          title: gridItem.title![0],
          content: gridItem.content,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      Expanded(
        child: GridView.count(
          crossAxisCount: countValue,
          childAspectRatio: (aspectWidth / aspectHeight),
          children: itemList
              .map((data) => GestureDetector(
                  onTap: () {
                    if (!isLoggedIn) {
                      Navigator.pushNamed(context, '/login');
                    } else {
                      Navigator.pushNamed(context, "/group",
                          arguments: data.id);
                    }
                  },
                  child: LFGCard(lfg: data)))
              .toList(),
        ),
      )
    ]));
  }
}
