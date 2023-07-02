export 'package:flutter/material.dart';

import '../utils/index.dart';
class UserProvider extends ChangeNotifier {
  bool goPublic = false;
  void toggleToPublic() async {
    goPublic = !goPublic;
    
    notifyListeners();
  }

}