import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:upg_calculator/constants.dart';
import 'package:upg_calculator/models/about_container_model.dart';
import 'package:upg_calculator/styles.dart';

class About extends StatefulWidget {
  const About({Key key}) : super(key: key);

  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;
  int _current = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(milliseconds: Constants.aboutAnimationDuration));
    final _aboutContainerModel = Provider.of<AboutContainerModel>(context, listen: false);
    _controller.addStatusListener((status) {
      _aboutContainerModel.isAnimating = status == AnimationStatus.forward || status == AnimationStatus.reverse;
    });
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    final _screenWidth = MediaQuery.of(context).size.width;
    final _spaceBarHeight = Constants.spaceBarHeight + AppBar().preferredSize.height;
    final _aboutContainerDiameter = [_screenWidth * sqrt(2), _spaceBarHeight * sqrt(2)].reduce(max);
    final _aboutContainerModel = Provider.of<AboutContainerModel>(context);
    final _xOffset = _screenWidth / 2 - ((30 + _aboutContainerDiameter) / 2) - 20;
    final _yOffset = (_spaceBarHeight) / 2 - ((30 + _aboutContainerDiameter) / 2) - 12;
    if (_aboutContainerModel.isOpened && _animation.value == 0) {
      _controller.forward();
    } else if (!_aboutContainerModel.isOpened && _animation.value == 1) {
      _controller.reverse();
    }

    final _blur = 0.0;
    final _offset = 0.0;
    final _top = 5.0;

    return Stack(clipBehavior: Clip.hardEdge, overflow: Overflow.clip, children: [
      AnimatedBuilder(
        animation: _animation,
        child: Container(
          width: _screenWidth - 40,
          height: Constants.spaceBarHeight - 48,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 110,
                  child: CarouselSlider(
                    items: Constants.bookImgUrlList
                        .map(
                          (imgUrl) => Container(
                            // duration: Duration(milliseconds: 500),
                            // curve: Curves.easeInQuint,
                            margin: EdgeInsets.only(top: _top),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: AssetImage(imgUrl),
                                ),
                                boxShadow: [
                                  BoxShadow(color: Colors.black87, blurRadius: _blur, offset: Offset(_offset, _offset))
                                ]),
                          ),
                        )
                        .toList(),
                    options: CarouselOptions(
                      aspectRatio: 1.3,
                      initialPage: 0,
                      enlargeCenterPage: true,
                      autoPlayAnimationDuration: Duration(milliseconds: 1800),
                      autoPlayInterval: Duration(seconds: 10),
                      autoPlay: true,
                      pauseAutoPlayOnTouch: true,
                      viewportFraction: 1,
                      onPageChanged: (index, reason) {
                        setState(() => _current = index);
                      },
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: map<Widget>(Constants.bookImgUrlList, (index, url) {
                    return AnimatedContainer(
                      duration: Duration(milliseconds: 200),
                      width: _current == index ? 20 : 5.0,
                      height: 5.0,
                      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 3.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: _current == index ? Colors.black38 : Colors.black12,
                      ),
                    );
                  }),
                ),
                SizedBox(height: 10),
                Text(
                    "The UPCAT Review is formed by a group of enthusiastic individals inspired by the likes of Steve Jobs, Stephen Hawking, Elon Musk, and other changemakers. The organization's goal is to help students learn what is not taught inside the four corners of a regular classroom by publishing one of a kind books at a modest price.",
                    style: TextStyles.small),
                Text("Contact Us", style: TextStyles.medium),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                        onTap: () => Constants.launchURL("https://www.facebook.com/upcatreviewer/"),
                        child: SizedBox(width: 50, height: 50, child: Image.asset("assets/fb_logo.png"))),
                    GestureDetector(
                        onTap: () => Constants.launchURL("http://theupcatreview.com/"),
                        child: SizedBox(width: 35, height: 35, child: Image.asset("assets/upcat_review_logo.jpg"))),
                  ],
                ),
              ],
            ),
          ),
        ),
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(_xOffset * _animation.value, _yOffset * _animation.value),
            child: Opacity(
              opacity: _animation.value,
              child: Container(
                alignment: Alignment.center,
                width: 30 + _aboutContainerDiameter * _animation.value,
                height: 30 + _aboutContainerDiameter * _animation.value,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: child,
              ),
            ),
          );
        },
      ),
    ]);
  }

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }
}
