import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:upg_calculator/constants.dart';
import 'package:upg_calculator/models/user.dart';
import 'package:upg_calculator/models/user_viewmodel.dart';
import 'package:upg_calculator/styles.dart';

import 'about/about.dart';

class MyFlexibleSpaceBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double appBarHeight = AppBar().preferredSize.height;
    return Stack(overflow: Overflow.clip, children: [
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15)),
          //gradient: LinearGradient(colors: [Color(0xfff7f7f7), Colors.white, Color(0xfff7f7f7)]),
          image: DecorationImage(image: AssetImage('assets/bg.jpg'), fit: BoxFit.fill),
        ),
        padding: EdgeInsets.only(left: 20, right: 20, top: appBarHeight),
        height: Constants.spaceBarHeight + appBarHeight,
        child: InputForm(),
      ),
      Positioned(top: 12, left: 20, child: About()),
    ]);
  }
}

class InputForm extends StatelessWidget {
  const InputForm({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserViewModel>(context).user;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [for (int i = 0; i < 3; i++) GradeInput(user: user, grade: 9 + i)],
        ),
        SizedBox(height: 20),
        ScoreInput(user: user),
      ],
    );
  }
}

class ScoreInput extends StatelessWidget {
  final User user;
  ScoreInput({@required this.user});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Score', style: TextStyles.medium),
        MyTextField(
          key: UniqueKey(),
          initialValue: user.score == null ? null : user.score.toString(),
          textInputAction: TextInputAction.next,
          onChanged: (value) => user.score = int.tryParse(value),
          onEditingComplete: () => FocusScope.of(context).nextFocus(),
        ),
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Container(height: 2, width: 100, color: Colors.black)),
        MyTextField(
          key: UniqueKey(),
          initialValue: user.total == null ? null : user.total.toString(),
          textInputAction: TextInputAction.done,
          onChanged: (value) => user.total = int.tryParse(value),
        ),
      ],
    );
  }
}

class GradeInput extends StatefulWidget {
  final User user;
  final int grade;
  GradeInput({@required this.user, @required this.grade});

  @override
  _GradeInputState createState() => _GradeInputState();
}

class _GradeInputState extends State<GradeInput> {
  @override
  Widget build(BuildContext context) {
    final sliderKeys = Provider.of<List<GlobalKey>>(context);
    final _userViewModel = Provider.of<UserViewModel>(context);
    return Container(
      child: Column(
        children: [
          // CircularProgressIndicator(
          //   strokeWidth: 8,
          //   backgroundColor: Colors.grey,
          //   valueColor: AlwaysStoppedAnimation<Color>(Colors.orange[400]),
          // ),
          SizedBox(height: 15),

          SleekCircularSlider(
            key: sliderKeys[widget.grade - 9],
            // key: UniqueKey(),
            min: 65,
            max: 100,
            initialValue: widget.user.grades[widget.grade - 9].toDouble(),
            innerWidget: (percentage) => Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('${percentage.toInt()} %', style: TextStyles.medium),
                  Text('G${widget.grade == 9 ? '9 ' : widget.grade}', style: TextStyles.small.colour(Colors.grey[700])),
                ],
              ),
            ),
            appearance: CircularSliderAppearance(
              size: 80,
              angleRange: 360,
              animationEnabled: true,
              startAngle: 270,
              //spinnerMode: false,
              customColors: CustomSliderColors(
                hideShadow: true,
                progressBarColors: [MyColors.darkRed, MyColors.darkRed],
                trackColor: Colors.grey[300],
              ),
              customWidths: CustomSliderWidths(trackWidth: 6, progressBarWidth: 6),
            ),
            onChange: (value) {
              if (!_userViewModel.isScrolling) {
                widget.user.grades[widget.grade - 9] = value.toInt();
              }
            },
          ),
        ],
      ),
    );
  }
}
