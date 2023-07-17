export 'package:flutter/material.dart';

import '../models/user/userr.dart';
import '../utils/index.dart';
class UserProvider extends ChangeNotifier {
  Userr? currUser;
  Userr? get getCurrUser => currUser;
  bool goPublic = false;


  void toggleToPublic() async {
    goPublic = !goPublic;
    notifyListeners();
  }

  set setCurrUser(Userr? data) {
    currUser = data;
    notifyListeners();
  }

}