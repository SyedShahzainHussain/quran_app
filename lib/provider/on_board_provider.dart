import 'package:flutter/material.dart';

class OnBoarddingProvider with ChangeNotifier {
  int _currentIndex = 0;

  int get index => _currentIndex;

  set index(int index) {
    _currentIndex = index;

    notifyListeners();
  }
}
