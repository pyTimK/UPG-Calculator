import 'dart:math';

import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:provider/provider.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:toast/toast.dart';
import 'package:upg_calculator/constants.dart';
import 'package:upg_calculator/models/about_container_model.dart';
import 'package:upg_calculator/models/loading_viewmodel.dart';
import 'package:upg_calculator/models/school.dart';
import 'package:upg_calculator/models/user_viewmodel.dart';
import 'package:upg_calculator/pages/home/background.dart';
import 'package:upg_calculator/pages/home/my_flexible_spacebar.dart';
import 'package:upg_calculator/styles.dart';

import '../../school_list.dart';
import '../list_item.dart';
import 'menu.dart';
import 'myFab.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final scrollController = ScrollController();
  static bool dayTheme = true;
  static String themeFlr = dayTheme ? 'day_idle' : 'night_idle';
  static String graduateHatAnim = 'idle';
  final listKey = GlobalKey<SliverAnimatedListState>();
  final sliderKeys = List.generate(3, (_) => GlobalKey());
  final List<UniqueKey> gradesKey = List.generate(3, (index) => UniqueKey());

  @override
  Widget build(BuildContext context) {
    print("HOME BUILDED");
    return Stack(alignment: Alignment.center, children: [
      // Background(scrollController),
      Container(
        color: Colors.white54,
        child: CustomScrollView(
          controller: scrollController,
          physics: BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              forceElevated: true,
              centerTitle: true,
              //forceElevated: true,
              //backgroundColor: Colors.white,
              //backgroundColor: Color(0xfff7f7f7),
              //backgroundColor: LinearGradient(),
              shape: ContinuousRectangleBorder(borderRadius: BorderRadius.vertical(bottom: Radius.circular(50))),
              expandedHeight: Constants.spaceBarHeight + AppBar().preferredSize.height,
              pinned: true,
              floating: false,
              flexibleSpace: ClipRRect(
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15)),
                child: FlexibleSpaceBar(
                  background: Provider<List<GlobalKey>>.value(value: sliderKeys, child: MyFlexibleSpaceBar()),
                ),
              ),
              leading: Menu(scrollController),

              title: Builder(builder: (context) {
                final _aboutContainerModel = Provider.of<AboutContainerModel>(context);
                return AnimatedCrossFade(
                  crossFadeState: _aboutContainerModel.isOpened ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                  duration: Duration(milliseconds: 100),
                  firstChild: Text('UPG CALCULATOR'),
                  secondChild: Text('ABOUT US'),
                );
              }),
              actions: [
                GestureDetector(
                  onTap: () {
                    // setState(() {
                    //   graduateHatAnim = 'shine';
                    // });
                    final _random = Random();
                    showToast((Constants.quotes[_random.nextInt(Constants.quotes.length)]));
                  },
                  child: Container(
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(right: 16),
                    width: 76,
                    child: SizedBox(
                      width: 40,
                      height: 40,
                      child: FlareActor(
                        'assets/graduateHat.flr',
                        fit: BoxFit.fill,
                        animation: graduateHatAnim,
                        callback: (name) => setState(() => graduateHatAnim = 'idle'),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            //BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)
            SliverPadding(
                padding: const EdgeInsets.fromLTRB(12, 32, 12, 16),
                sliver: SliverAnimatedList(
                  key: listKey,
                  initialItemCount: 0,
                  itemBuilder: (context, index, animation) {
                    School school = schools[index];
                    final _userViewModel = Provider.of<UserViewModel>(context);
                    school.passed = _userViewModel.user.upg <= school.requiredUPG;
                    return ScaleTransition(
                      scale:
                          animation.drive(Tween<double>(begin: 1.15, end: 1).chain(CurveTween(curve: Curves.linear))),
                      child: Hero(
                        tag: 'schoolInfo ${school.name}',
                        child: ListItem(school: school),
                      ),
                    );
                  },
                )),
          ],
        ),
      ),
      ChangeNotifierProvider(
        create: (context) => LoadingViewModel(),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Loading(),
            MyFab(scrollController, listKey),
          ],
        ),
      ),
    ]);
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}

class Loading extends StatelessWidget {
  const Loading({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _loadingViewModel = Provider.of<LoadingViewModel>(context);
    return IgnorePointer(
      ignoring: !_loadingViewModel.isLoading,
      child: AnimatedOpacity(
        opacity: _loadingViewModel.isLoading ? 0.6 : 0,
        duration: Duration(milliseconds: 600),
        child: Container(
          color: Colors.black,
          width: double.infinity,
          height: double.infinity,
        ),
      ),
    );
  }
}

// GestureDetector(
//   onTap: () {
//     if (themeFlr == 'day_idle' || themeFlr == 'night_idle') {
//       setState(() {
//         themeFlr = dayTheme ? 'switch_night' : 'switch_day';
//       });
//     }
//   },
//   child: Container(
//     padding: EdgeInsets.only(right: 16),
//     width: 70,
//     child: FlareActor(
//       'assets/toggle.flr',
//       fit: BoxFit.contain,
//       animation: themeFlr,
//       callback: (name) {
//         dayTheme ^= true;
//         setState(() {
//           themeFlr = name == 'switch_day' ? 'day_idle' : 'night_idle';
//         });
//       },
//     ),
//   ),
// ),
