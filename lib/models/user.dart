import 'package:upg_calculator/models/school.dart';

class User {
  List<int> grades;
  int score;
  int total;
  double upg;
  List<School> schools;

  User({this.grades, this.score, this.total})
      : this.upg = compute(grades, score, total),
        this.schools = List.generate(Schools.list.length, (i) => Schools.list[i]);

  void computeUpg() {
    int sumGrades = grades.reduce((a, b) => a + b);
    double aveGrades = sumGrades / 3;
    double upgPercent = 40 * aveGrades / 100 + 60 * (((5 * score) - total) / (4 * total));
    upg = 6 - (0.05 * (upgPercent));
  }

  static compute(List<int> grades, int score, int total) {
    int sumGrades = grades.reduce((a, b) => a + b);
    double aveGrades = sumGrades / 3;
    double upgPercent = 40 * aveGrades / 100 + 60 * (((5 * score) - total) / (4 * total));
    return 6 - (0.05 * (upgPercent));
  }
}
