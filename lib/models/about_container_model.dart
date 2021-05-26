import 'package:flutter/cupertino.dart';

class AboutContainerModel extends ChangeNotifier {
  bool _isOpened = false;
  bool _isAnimating = false;
  bool get isOpened => _isOpened;
  bool get isAnimating => _isAnimating;
  set isAnimating(value) {
    _isAnimating = value;
  }

  open() {
    if (!_isOpened) {
      _isOpened = true;
      notifyListeners();
    }
  }

  close() {
    if (_isOpened) {
      _isOpened = false;
      notifyListeners();
    }
  }
}
