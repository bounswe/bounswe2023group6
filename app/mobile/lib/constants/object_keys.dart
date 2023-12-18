import 'package:flutter/material.dart';

class GlobalStaticKeys {
  static final GlobalKey<NavigatorState> gameNavigatorKey = GlobalObjectKey(UniqueKey());
  static final GlobalKey<NavigatorState> forumNavigatorKey = GlobalObjectKey(UniqueKey());
  static final GlobalKey<NavigatorState> homeNavigatorKey = GlobalObjectKey(UniqueKey());
  static final GlobalKey<NavigatorState> lfgNavigatorKey = GlobalObjectKey(UniqueKey());

  static const GlobalObjectKey profilePageEditorKey = GlobalObjectKey('profilePageEditorKey');
}