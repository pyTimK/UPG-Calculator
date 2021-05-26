import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import 'package:upg_calculator/constants.dart';
import 'package:upg_calculator/models/about_container_model.dart';
import 'package:upg_calculator/models/loading_viewmodel.dart';
import 'package:upg_calculator/models/school.dart';
import 'package:upg_calculator/models/user.dart';
import 'package:upg_calculator/models/user_viewmodel.dart';
import 'package:upg_calculator/styles.dart';

import '../../school_list.dart';
import '../list_item.dart';

class MyFab extends StatefulWidget {
  static final double appBarHeight = AppBar().preferredSize.height;
  static final double defaultTopMargin = Constants.spaceBarHeight + appBarHeight - 40;
  static final double startScale = 96.0;
  static final double endScale = startScale / 2;
  final ScrollController controller;
  final GlobalKey<SliverAnimatedListState> listKey;
  //final GlobalKey<SliverAnimatedListState> listKey;
  MyFab(this.controller, this.listKey);

  @override
  _MyFabState createState() => _MyFabState();
}

class _MyFabState extends State<MyFab> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  // AnimationController _controllerColor;
  Animation<double> _animScale;
  // Animation _animColor;
  UserViewModel _userViewModel;
  String animationName;
  double top = MyFab.defaultTopMargin;
  String buttonText;
  double buttonTextSize;
  String upg;
  bool isAnimating = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 1000));
    _animScale =
        Tween<double>(begin: 1, end: 0).animate(CurvedAnimation(curve: Curves.elasticInOut, parent: _controller));

    // _controllerColor = AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    // _animColor = ColorTween(begin: MyColors.darkRed, end: Colors.white)
    //     .animate(CurvedAnimation(curve: Curves.easeInOut, parent: _controllerColor));
    widget.controller.addListener(() => setState(() {}));
    animationName = 'idle';
    _userViewModel = Provider.of<UserViewModel>(context, listen: false);
    upg = _userViewModel.user.upg.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    print(widget.controller.offset);
    final _aboutContainerModel = Provider.of<AboutContainerModel>(context);
    var scale = 1.0;

    if (widget.controller.hasClients) {
      final offset = widget.controller.offset;
      top = offset > Constants.spaceBarHeight ? MyFab.appBarHeight - 40 : MyFab.defaultTopMargin - offset;

      if (offset < 0) {
        top = MyFab.defaultTopMargin;
      }
      if (_aboutContainerModel.isOpened) {
        animationName = 'idle';
        buttonText = 'BUY NOW';
        buttonTextSize = 15;
      } else if (offset < 10) {
        buttonText = 'COMPUTE';
        buttonTextSize = 15;
      } else {
        buttonText = upg;
        buttonTextSize = 20;
      }

      if (offset < MyFab.defaultTopMargin - MyFab.startScale) {
        scale = 1.0;
      } else if (offset < MyFab.defaultTopMargin - MyFab.endScale) {
        scale = (MyFab.defaultTopMargin - MyFab.endScale - offset) / MyFab.endScale;
      } else {
        scale = 0.0;
      }
    }

    return Positioned(
      child: Container(
        height: 100,
        alignment: Alignment.center,
        child: Stack(overflow: Overflow.visible, alignment: Alignment.centerLeft, children: [
          FloatingActionButton.extended(
            //backgroundColor: MyColors.green,
            backgroundColor: MyColors.darkRed,
            elevation: 5,
            //shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(6)),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            onPressed: () {
              FocusScope.of(context).unfocus();
              if (!isAnimating) {
                if (buttonText == 'BUY NOW') {
                  Constants.launchURL(
                      "https://shopee.ph/Tome-of-Knowledge-2345-New-Shortcuts-and-Techniques-Last-Batch-i.74790835.2246756497");
                } else if (buttonText == 'COMPUTE') {
                  if (validate(_userViewModel.user, context)) {
                    final _loadingViewModel = Provider.of<LoadingViewModel>(context, listen: false);
                    _loadingViewModel.start();
                    setState(() => animationName = 'go');
                    _userViewModel.user.computeUpg();
                    print(_userViewModel.user.upg);
                    scrollUp(_loadingViewModel);
                    //print("UPG :" + User.instance.upg.toString());
                  }
                } else {
                  widget.controller.animateTo(0, duration: Duration(milliseconds: 600), curve: Curves.elasticOut);
                }
              }
            },
            icon: Icon(
              Icons.inbox,
              color: Colors.transparent,
            ),
            label: ScaleTransition(
              scale: _animScale,
              child: Text(
                buttonText,
                style: TextStyles.medium.weight(FontWeight.bold).size(buttonTextSize),
              ),
            ),
          ),
          Positioned(
            left: -35,
            child: IgnorePointer(
              child: Container(
                width: 120,
                height: 120,
                alignment: Alignment.center,
                child: _aboutContainerModel.isOpened
                    ? Container(
                        width: 40,
                        height: 40,
                        child: Image.asset(
                          "assets/shopee_logo.png",
                          fit: BoxFit.fitHeight,
                        ),
                      )
                    : buttonText == 'COMPUTE'
                        ? FlareActor(
                            'assets/compute.flr',
                            callback: (name) => setState(() => animationName = 'idle'),
                            fit: BoxFit.contain,
                            animation: animationName,
                          )
                        : Icon(Icons.arrow_downward, color: Colors.white),
              ),
            ),
          ),
        ]),
      ),
      top: top,
    );
  }

  bool validate(User user, BuildContext context) {
    if (user.score == null) {
      showToast("Score is required");
      // Toast.show("Score is required", context, duration: Toast.LENGTH_LONG, backgroundColor: MyColors.alphaDarkRed);
      return false;
    }
    if (user.total == null) {
      showToast("Total Items is required");
      return false;
    }
    if (user.score > user.total) {
      showToast("Score must be less than the total items");
      return false;
    }

    if (user.total == 0) {
      showToast("A total of 0 is not allowed");
      return false;
    }

    return true;
  }

  Future removeItems() async {
    const delay = 200;
    var schoolLength = schools.length;
    for (int i = 0; i < schoolLength; i++) {
      var removedItem = schools.removeAt(schoolLength - i - 1);
      widget.listKey.currentState.removeItem(schoolLength - i - 1, (_, animation) {
        return ScaleTransition(
          scale: animation.drive(Tween<double>(begin: 0.5, end: 1).chain(CurveTween(curve: Curves.linear))),
          child: ListItem(school: removedItem),
        );
      }, duration: Duration(milliseconds: delay));
      await Future.delayed(Duration(milliseconds: 50));
    }
  }

  Future showResults() async {
    const delay = 200;
    var schoolLength = Schools.list.length;
    for (int i = 0; i < schoolLength; i++) {
      schools.insert(i, Schools.list[i]);
      widget.listKey.currentState.insertItem(i, duration: Duration(milliseconds: delay));
      await Future.delayed(Duration(milliseconds: 100));
    }
  }

  void scrollUp(LoadingViewModel loadingViewModel) async {
    isAnimating = true;
    await removeItems();
    await _userViewModel.saveData();
    //_controller.forward();
    await Future.delayed(Duration(milliseconds: 100));
    upg = _userViewModel.user.upg.toStringAsFixed(2);
    for (School school in Schools.list) school.shownAlready = false;
    await showResults();

    _userViewModel.isScrolling = true;
    await widget.controller
        .animateTo(Constants.spaceBarHeight, duration: Duration(milliseconds: 600), curve: Curves.elasticOut);
    //await _userViewModel.loadData();
    //await _controller.reverse();
    _userViewModel.isScrolling = false;
    isAnimating = false;
    loadingViewModel.end();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
