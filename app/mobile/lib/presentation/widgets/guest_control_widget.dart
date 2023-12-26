import 'package:flutter/material.dart';
import 'package:mobile/constants/color_constants.dart';
import 'package:mobile/utils/cache_manager.dart';

class GuestControlWidget extends StatelessWidget {
  final Widget widgetToShowLoggedInUser;
  const GuestControlWidget({
    Key? key, required this.widgetToShowLoggedInUser
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: CacheManager().isUserLoggedInNotifier,
      builder: (BuildContext context, bool isLoggedIn, Widget? child) {
        return isLoggedIn
            ? widgetToShowLoggedInUser
            : FloatingActionButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                child: const Icon(
                  Icons.login,
                  color: ColorConstants.buttonColor,
                ),
              );
      },
    );
  }
}
