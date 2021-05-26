import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:upg_calculator/models/school.dart';
import 'package:upg_calculator/models/user_viewmodel.dart';
import 'package:upg_calculator/pages/schoolInfo/schoolInfo.dart';

import '../styles.dart';

class ListItem extends StatelessWidget {
  const ListItem({Key key, @required this.school, this.animationValue = 0}) : super(key: key);

  final School school;
  final double animationValue;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    var animation = AlwaysStoppedAnimation(animationValue);
    return _buildCard(context, animation, screenSize);
  }

  Widget _buildCard(BuildContext context, Animation animation, Size screenSize) {
    var gradientMiddle = ColorTween(begin: school.passed ? Colors.green[50] : Colors.red[50], end: Colors.white)
        .animate(CurvedAnimation(curve: Curves.easeOut, parent: animation));
    var gradientEnd =
        ColorTween(begin: school.passed ? Colors.green[100] : Colors.red[100], end: Colors.white).evaluate(animation);
    var shadowColor = ColorTween(begin: school.passed ? Colors.green[400] : Colors.red[400], end: Colors.transparent)
        .evaluate(animation);
    String flareAnim;
    if (school.shownAlready) {
      flareAnim = 'idle';
    } else {
      flareAnim = 'go';
      school.shownAlready = true;
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4 * (1 - animationValue), vertical: 15 * (1 - animationValue)),
      child: Card(
        color: Colors.grey[50],

        shadowColor: shadowColor,
        margin: EdgeInsets.all(4 * (1 - animationValue)),
        clipBehavior: Clip.antiAlias,
        elevation: 5 * (1 - animationValue),
        //decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Color(0xf6ffffff)),
        child: Container(
          // height: ((MediaQuery.of(context).size.height / 2) + 50),
          height: (((MediaQuery.of(context).size.height / 2) + 50) - 65) * animationValue + 65,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.white, gradientMiddle.value, gradientEnd])),
          child: Opacity(
            opacity: animationValue > 0.5 ? 0 : 1 - 2 * animationValue,
            child: ListTile(
              onTap: () => {
                Navigator.of(context).push(PageRouteBuilder(
                  transitionDuration: Duration(milliseconds: 600),
                  reverseTransitionDuration: Duration(milliseconds: 600),
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      SchoolInfo(school, school.passed, animation, secondaryAnimation),
                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                    var fadeIn = Tween<double>(begin: 0, end: 1)
                        .animate(CurvedAnimation(curve: Interval(.5, 1, curve: Curves.easeIn), parent: animation));
                    var fadeOut = Tween<double>(begin: 0, end: 1)
                        .animate(CurvedAnimation(curve: Interval(0, .5, curve: Curves.easeOut), parent: animation));
                    return Stack(children: <Widget>[
                      // FadeTransition(opacity: fadeOut, child: Container(color: Colors.white)),
                      FadeTransition(opacity: fadeIn, child: child)
                    ]);
                  },
                ))
              },
              leading: Transform.translate(
                  offset: Offset(-20, 13),
                  child:
                      Transform.scale(scale: 2, child: Opacity(opacity: 0.6, child: Image.asset(school.logoLocation)))),
              dense: true,
              title: Text(school.name, style: TextStyles.medium),
              subtitle: Text(school.motto, style: TextStyles.small),
              // subtitle: RichText(
              //   text: TextSpan(style: DefaultTextStyle.of(context).style, children: [
              //     TextSpan(text: 'UPG Required: ', style: TextStyles.small),
              //     TextSpan(text: "${school.requiredUPG}", style: TextStyles.medium.weight(FontWeight.bold))
              //   ]),
              // ),
              trailing: Transform.translate(
                offset: Offset(10, 0),
                child: Transform.scale(
                  scale: 1.4,
                  child: SizedBox(
                    height: 50,
                    width: 50,
                    child: FlareActor(
                      school.passed ? "assets/check.flr" : "assets/cross.flr",
                      animation: flareAnim,
                      fit: BoxFit.fill,
                      alignment: Alignment.centerRight,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // @override
  // void dispose() {
  //   _controller.dispose();
  //   super.dispose();
  // }
}

// AnimationController _controller;
// Animation<double> _animation;

// @override
// void initState() {
//   super.initState();
//   _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 2000));

//   if (!widget.school.shownAlready) {
//     _animation =
//         Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(curve: Curves.elasticOut, parent: _controller));
//     _controller.forward();
//     widget.school.shownAlready = true;
//     print("${widget.school.name} show");
//   } else {
//     _animation = Tween<double>(begin: 1, end: 1).animate(_controller);
//     print("${widget.school.name} dont show");
//   }
// }
