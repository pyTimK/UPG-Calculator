import 'package:url_launcher/url_launcher.dart';

abstract class Constants {
  static const List<String> quotes = [
    "Dream as if you'll live forever",
    "Smile :)",
    "Don't give up!",
    ":D",
    ";)",
    "Every moment is a fresh beginning",
    "Start today",
    "One day or day one?",
    "We're rooting for you!",
    "Stay focused",
    "Believe",
    "sm:]e",
    "Adventure is out there!",
    "You can do it!",
    "Cheers to you",
    "Dream Big",
    "Best of Luck!",
    "You're breathtaking!",
    "Yes you can",
    "Learn, learn, learn",
  ];
  static const spaceBarHeight = 290.0;
  static const List<String> bookImgUrlList = [
    "assets/book_pictures/2000.jpg",
    "assets/book_pictures/2345.jpg",
    "assets/book_pictures/2500.png",
    "assets/book_pictures/2800.jpg",
  ];
  static const aboutAnimationDuration = 300;

  static launchURL(String url) async {
    if (await canLaunch(url)) launch(url);
  }
}
