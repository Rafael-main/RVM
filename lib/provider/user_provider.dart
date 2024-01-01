export 'package:flutter/material.dart';

import '../models/user/userr.dart';
import '../utils/index.dart';
class UserProvider extends ChangeNotifier {
  Userr? currUser;
  Userr? get getCurrUser => currUser;
  bool goPublic = false;


  bool _publicAccount = false;
  bool get publicAccount => _publicAccount;
  set setPublicAccount(bool val) {
    _publicAccount = val;
    notifyListeners();
  }


  void toggleToPublic() async {
    goPublic = !goPublic;
    notifyListeners();
  }

  set setCurrUser(Userr? data) {
    currUser = data;
    notifyListeners();
  }

}