import 'package:flutter/cupertino.dart';

class RouteService extends ChangeNotifier {
  int navigateTo = -1;

  navigate(int i) {
    navigateTo = i;
    notifyListeners();
  }
}
