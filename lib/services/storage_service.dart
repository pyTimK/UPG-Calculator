import 'package:shared_preferences/shared_preferences.dart';
import 'package:upg_calculator/models/user.dart';

abstract class StorageService {
  Future<void> saveUser(User user);
  Future<User> getUser();
}

class StorageServiceSharedPref extends StorageService {
  static const List<String> grades = ["g9", "g10", "g11"];
  static const String score = "score";
  static const String total = "total";

  @override
  Future<User> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return User(
      grades: [for (int i = 0; i < 3; i++) prefs.getInt(grades[i]) ?? 85 + 5 * i],
      score: prefs.getInt(score) ?? 92,
      total: prefs.getInt(total) ?? 100,
    );
  }

  @override
  Future<void> saveUser(User user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    for (int i = 0; i < 3; i++) await prefs.setInt(grades[i], user.grades[i]);
    await prefs.setInt(score, user.score);
    await prefs.setInt(total, user.total);
  }
}
