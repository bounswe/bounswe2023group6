import 'package:flutter/material.dart';
import 'package:mobile/presentation/pages/forgot_password_page.dart';

import 'package:mobile/presentation/pages/login_page.dart';
import 'package:mobile/presentation/pages/registration_page.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const GuestDrawer();
  }
}

class LoggedDrawer extends StatelessWidget {
  const LoggedDrawer({
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
                          radius: 70,
                          child: ClipOval(
                            child: Image.asset(
                              "lib/assets/aysecaglayan.png",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        const Text(
                          'Ayşe Çağlayan',
                          style: TextStyle(fontSize: 28, color: Colors.white),
                        ),
                        const Text(
                          'acaglayan',
                          style: TextStyle(fontSize: 14, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                )),
          ),
          const Expanded(
            flex: 5,
            child: Column(
              children: [
                ListTile(
                  leading: Icon(Icons.account_circle_outlined),
                  title: Text('My Profile'),
                ),
                ListTile(
                  leading: Icon(Icons.bookmarks_outlined),
                  title: Text('Saved'),
                ),
                ListTile(
                  leading: Icon(Icons.history),
                  title: Text('History'),
                ),
                ListTile(
                  leading: Icon(Icons.settings_outlined),
                  title: Text('Settings'),
                ),
                ListTile(
                  leading: Icon(Icons.logout_outlined),
                  title: Text('Log Out'),
                ),
              ],
            ),
          )
        ],
      ),
    );
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
                      MaterialPageRoute(builder: (context) => LoginPage()),
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
                ListTile(
                  leading: const Icon(Icons.person_off_outlined),
                  title: const Text('Forgot Password'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ForgotPage()),
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
