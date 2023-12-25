import 'package:flutter/material.dart';
import 'package:mobile/data/models/user_model.dart';
import 'package:mobile/presentation/pages/auth_page_demo.dart';
import 'package:mobile/presentation/pages/main_screen.dart';
import 'package:mobile/utils/cache_manager.dart';
import 'package:mobile/utils/shared_manager.dart';

class OpeningPage extends StatefulWidget {
  const OpeningPage({super.key});

  @override
  State<OpeningPage> createState() => _OpeningPageState();
}

class _OpeningPageState extends State<OpeningPage> {
  late String username = '';
  User? currentuser;

  final CacheManager cacheManager = CacheManager();

  @override
  void initState() {
    //loadData();
    //getUser();
    super.initState();
    initializeCache();
  }

  Future<void> initializeCache() async {
    print(cacheManager.getSessionId());

    setState(() {
      currentuser = cacheManager.getUser();
      username = currentuser!.username!;
    });
  }

  @override
  Widget build(BuildContext context) {

    if (username == '' || currentuser == null || username == 'admin') {
      return const AuthPageDemo();
    } 
    else {
      return MainScreen();  
    }
}
}