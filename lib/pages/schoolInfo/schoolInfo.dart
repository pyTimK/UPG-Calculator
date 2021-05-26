import 'package:flutter/material.dart';
import 'package:upg_calculator/models/school.dart';
import 'package:upg_calculator/pages/list_item.dart';
import 'package:upg_calculator/styles.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants.dart';

class SchoolInfo extends StatelessWidget {
  SchoolInfo(this.school, this.passed, this.animation, this.secondaryAnimation);

  final School school;
  final bool passed;
  final Animation animation;
  final Animation secondaryAnimation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Column(
          children: [
            Container(
              height: (MediaQuery.of(context).size.height / 2) - 50,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(school.picLocation),
                  fit: BoxFit.fill,
                ),
                //borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
              ),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.transparent, Colors.black12, Colors.black],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(school.abbreviation, style: TextStyles.large.colour(Colors.white)),
                        // Text(' • ', style: TextStyles.medium.colour(Colors.white)),
                        // Text(school.name, style: TextStyles.medium.colour(Colors.white)),
                      ],
                    ),
                    Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                      Text(school.location, style: TextStyles.medium.colour(Colors.white)),
                      Icon(
                        Icons.location_on,
                        color: Colors.white,
                        size: 12,
                      ),
                    ]),
                  ],
                ),
              ),
            ),
            Hero(
              tag: 'schoolInfo ${school.name}',
              flightShuttleBuilder: _buildFlightWidget,
              child: Container(
                padding: EdgeInsets.only(left: 12, top: 12),
                width: double.infinity,
                height: (MediaQuery.of(context).size.height / 2) + 50,
                decoration: BoxDecoration(color: Colors.white),
                child: SchoolDescription(school: school),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFlightWidget(BuildContext flightContext, Animation<double> heroAnimation,
      HeroFlightDirection flightDirection, BuildContext fromHeroContext, BuildContext toHeroContext) {
    return AnimatedBuilder(
      animation: heroAnimation,
      builder: (context, child) {
        return DefaultTextStyle(
          style: DefaultTextStyle.of(toHeroContext).style,
          child: ListItem(school: school, animationValue: heroAnimation.value),
        );
      },
    );
  }
}

class SchoolDescription extends StatefulWidget {
  const SchoolDescription({
    Key key,
    @required this.school,
  }) : super(key: key);

  final School school;

  @override
  _SchoolDescriptionState createState() => _SchoolDescriptionState();
}

class _SchoolDescriptionState extends State<SchoolDescription> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animationDescription;
  Animation<double> _animationLogo;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 2000));
    _animationDescription = Tween<double>(begin: 0, end: 1.0)
        .animate(CurvedAnimation(parent: _controller, curve: Interval(0, 0.6, curve: Curves.decelerate)));
    _animationLogo = Tween<double>(begin: 0, end: 1.0)
        .animate(CurvedAnimation(parent: _controller, curve: Interval(0.6, 1, curve: Curves.decelerate)));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Positioned(
        bottom: -80,
        height: 400,
        right: -80,
        child: AnimatedBuilder(
          animation: _animationLogo,
          child: Image.asset(widget.school.logoLocation),
          builder: (context, child) => Opacity(
            opacity: _animationLogo.value * 0.2,
            child: Transform.translate(offset: Offset(-30 * (1 - _animationLogo.value), 0), child: child),
          ),
        ),
      ),
      SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: AnimatedBuilder(
          animation: _animationDescription,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _nickname(),
              SizedBox(height: 32),
              _age(),
              SizedBox(height: 32),
              _motto(),
              SizedBox(height: 32),

              if (widget.school.rank != null) ...[
                _ranking(context),
                SizedBox(height: 32),
              ],
              // _courses(),
              // SizedBox(height: 32),
              _website(),
            ],
          ),
          builder: (context, child) => Opacity(
            opacity: _animationDescription.value,
            child: child,
          ),
        ),
      ),
    ]);
  }

  Widget _nickname() {
    return _Info(
      icon: Icons.chat_bubble,
      category: "NickName",
      value: Text(widget.school.nickname, style: TextStyles.large),
    );
  }

  Widget _motto() {
    return _Info(
        icon: Icons.chat_bubble,
        category: "Motto",
        value: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.school.motto, style: TextStyles.large),
            if (widget.school.mottoMeaning != null) Text("*${widget.school.mottoMeaning}", style: TextStyles.medium)
          ],
        ));
  }

  Widget _location() {
    return _Info(
      icon: Icons.my_location,
      category: "Location",
      value: Text("Manila", style: TextStyles.large),
    );
  }

  Widget _age() {
    int age = _calculateAge(widget.school.established);
    return _Info(
      icon: Icons.nature,
      category: "Age",
      value: Text("$age years", style: TextStyles.large),
    );
  }

  int _calculateAge(DateTime birthDate) {
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - birthDate.year;
    if (currentDate.month < birthDate.month)
      age--;
    else if (currentDate.month == birthDate.month && currentDate.day < birthDate.day) age--;
    return age;
  }

  Widget _ranking(context) {
    print(widget.school.rank);
    const scope = ["Philippines", "Asia", "Worldwide"];

    return _Info(
        icon: Icons.leaderboard,
        category: "Ranking",
        value: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (int i = 0; i < 3; i++)
              if (widget.school.rank[i] != 0)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.school.rank[i].toString(), style: TextStyles.large),
                    Text(_formatOrdinal(widget.school.rank[i]), style: TextStyles.medium.bold),
                    Text(" ${scope[i]}", style: TextStyles.large),
                  ],
                ),
            SizedBox(height: 4),
            Container(
              padding: EdgeInsets.all(1),
              decoration: BoxDecoration(
                border: Border.all(width: 1),
              ),
              child: GestureDetector(
                onTap: () => Constants.launchURL(widget.school.linkRank),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Text("Source: ", style: TextStyles.small),
                        SizedBox(width: 14, height: 14, child: Image.asset("assets/qs.png")),
                        Text("Quacquarelli Symonds", style: TextStyles.small),
                      ],
                    ),
                    Transform.translate(
                        offset: Offset(-2, 0), child: Icon(Icons.open_in_new, size: 12, color: MyColors.link))
                  ],
                ),
              ),
            ),
          ],
        ));
  }

  String _formatOrdinal(int x) {
    String number = x.toString();
    String onesDigit = number.substring(number.length - 1, number.length);

    if (["1", "2", "3"].contains(onesDigit)) {
      String tensDigit = x > 9 ? number.substring(number.length - 2, number.length - 1) : "0";
      if (tensDigit == "1") return "th";
      if (onesDigit == "1") return "st";
      if (onesDigit == "2") return "nd";
      if (onesDigit == "3") return "rd";
    }
    return "th";
  }

  Widget _courses() {
    return _Info(
      icon: Icons.notes,
      category: "Courses",
      value: Text("Manila", style: TextStyles.large),
    );
  }

  Widget _website() {
    return _Info(
      icon: Icons.link,
      category: "Website",
      value: SelectableText(
        widget.school.website,
        style: TextStyles.medium.colour(MyColors.link),
        onTap: () => Constants.launchURL(widget.school.website),
      ),
    );
  }
}

class _Info extends StatelessWidget {
  _Info({@required this.icon, @required this.category, @required this.value});

  final IconData icon;
  final String category;
  final Widget value;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        Icon(icon),
        SizedBox(width: 6),
        Text(category, style: TextStyles.medium.bold),
      ]),
      SizedBox(height: 2),
      value,
    ]);
  }
}

// opacity: Tween<double>(begin: 1.0, end: 0).animate(CurvedAnimation(curve: Interval(0, .22), parent: animationStopped.value)),

// child: Transform.translate(
//   offset: Offset(0, 0),
//   child: Card(
//     margin: EdgeInsets.all(0),
//     elevation: 5,
//     shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(0))),
//     child: Stack(children: [
//       Container(
//         width: double.infinity,
//         height: (MediaQuery.of(context).size.height / 2) + 50,
//         decoration: BoxDecoration(
//             borderRadius: BorderRadius.all(Radius.circular(4)),
//             gradient: LinearGradient(
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//               // colors: passed
//               //     ? [Colors.white, Colors.green[50], Colors.green[100]]
//               //     : [Colors.white, Colors.red[50], Colors.red[100]],
//               colors: [Colors.white, Colors.white],
//             )),
//       ),
//       Positioned(
//         bottom: 0,
//         height: 100,
//         width: 100,
//         left: 0,
//         child: Opacity(
//           opacity: 0.4,
//           child: Image.asset(school.logoLocation),
//         ),
//       )
//     ]),
//   ),
// ),
