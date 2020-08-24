import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';

class MainModel extends ChangeNotifier {
  PackageInfo packageInfo;
  FirebaseUser _user;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  MainModel() {
    PackageInfo.fromPlatform().then((value) => packageInfo = value);
    _auth.onAuthStateChanged.listen(_onAuthStateChanged);
  }

  FirebaseUser get user {
    return _user;
  }

  _onAuthStateChanged(FirebaseUser user) {
    _user = user;
    String userString = user != null ? user.toString() : "null";
    print("User authentication state changed: " + userString);
    notifyListeners();
  }
}
