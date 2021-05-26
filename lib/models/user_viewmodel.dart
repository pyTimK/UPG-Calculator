import 'package:flutter/cupertino.dart';
import 'package:upg_calculator/models/user.dart';
import 'package:upg_calculator/service_locator.dart';
import 'package:upg_calculator/services/storage_service.dart';

class UserViewModel extends ChangeNotifier {
  User _user = User(grades: [65, 65, 65], score: 92, total: 100);
  User get user => _user;
  bool isScrolling = false;

  UserViewModel() {
    loadData();
  }

  StorageService _storageService = locator<StorageService>();

  Future loadData() async {
    _user = await _storageService.getUser();
    notifyListeners();
  }

  Future saveData() async {
    await _storageService.saveUser(user);
  }
}
