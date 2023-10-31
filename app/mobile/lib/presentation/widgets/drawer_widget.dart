import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:mobile/data/models/user_model.dart';
import 'package:mobile/data/services/user_authentication_service.dart';
import 'package:mobile/presentation/pages/main_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mobile/presentation/pages/login_page.dart';
import 'package:mobile/presentation/pages/registration_page.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({
    super.key,
  });

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  late String username = '';
  bool ispp = false;
  late ByteData byteData;
  late User currentuser;

  final UserAuthenticationService authService = UserAuthenticationService();



  @override
  void initState() {

    loadData();
    getUser();
    super.initState();
  }

  void loadData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      username = prefs.getString('username') ?? '';
    });
  }

  void getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    currentuser = (await authService.getCurrentUser(prefs.getString('username')))!;
    
    if (currentuser.profileImage != null){
      
      setState(() {
        byteData = currentuser.profileImage!;
        ispp = true;
      });

    }
  }

  CircleAvatar profilphoto(bool istrue){
    if (istrue) {
      return  CircleAvatar(
                    radius: 70,
                    child: ClipOval(
                      child: Image.memory(
                        byteData.buffer.asUint8List(),
                        fit: BoxFit.cover,
                      ),
                    ),
                );
    } else {
      return  CircleAvatar(
                backgroundColor: Theme.of(context).primaryColor,
                radius: 60,
                child: const Icon(
                  Icons.account_circle,
                  size: 130,
                  color: Colors.white,
                ),
              );
    }
  }


  @override
  Widget build(BuildContext context) {

    if (username == '') {
      return const GuestDrawer();
    }
    else {
    
      return LoggedDrawer(username: username, pp : profilphoto(ispp));

    }

  }
}

class LoggedDrawer extends StatelessWidget {
  final String username;
  final CircleAvatar pp;
  const LoggedDrawer({
    super.key, required this.username, required this.pp,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 4,
            child: Material(
                color: Theme.of(context).primaryColor, // This will change
                child: InkWell(
                  child: Container(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).padding.top, bottom: 24),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 50,
                        ),
                        pp,
                        const SizedBox(
                          height: 12,
                        ),
                        const Text(
                          'Welcome',
                          style: TextStyle(fontSize: 28, color: Colors.white),
                        ),
                        Text(
                          username,
                          style: const TextStyle(fontSize: 14, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                )),
          ),
          Expanded(
            flex: 5,
            child: Column(
              children: [
                const ListTile(
                  leading: Icon(Icons.account_circle_outlined),
                  title: Text('My Profile'),
                ),
                const ListTile(
                  leading: Icon(Icons.bookmarks_outlined),
                  title: Text('Saved'),
                ),
                const ListTile(
                  leading: Icon(Icons.history),
                  title: Text('History'),
                ),
                const ListTile(
                  leading: Icon(Icons.settings_outlined),
                  title: Text('Settings'),
                ),
                ListTile(
                  leading: const Icon(Icons.logout_outlined),
                  title: const Text('Log Out'),
                  onTap:() {
                    clearData();
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const MainScreen()),);
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void clearData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}

class GuestDrawer extends StatelessWidget {
  const GuestDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 4,
            child: Material(
                color: Theme.of(context).primaryColor, // This will change
                child: InkWell(
                  child: Container(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).padding.top, bottom: 24),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 50,
                        ),
                        CircleAvatar(
                          backgroundColor: Theme.of(context).primaryColor,
                          radius: 60,
                          child: const Icon(
                            Icons.account_circle,
                            size: 130,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        const Text(
                          'Guest',
                          style: TextStyle(fontSize: 28, color: Colors.white),
                        ),
                        const Center(
                          child: SizedBox(
                            width: 250,
                            child: Center(
                              child: Text(
                                'Sign up to share your experience, customize your feed, edit game pages, find game friends, and more! ',
                                style: TextStyle(
                                    fontSize: 14, color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
          ),
          Expanded(
            flex: 5,
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.person_outlined),
                  title: const Text('Login'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>  LoginPage()),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.person_add_alt_1_outlined),
                  title: const Text('Sign Up'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RegistrationPage()),
                    );
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
