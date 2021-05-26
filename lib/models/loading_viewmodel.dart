import 'package:flutter/cupertino.dart';

class LoadingViewModel extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  start() {
    _isLoading = true;
    notifyListeners();
  }

  end() {
    _isLoading = false;
    notifyListeners();
  }
}
