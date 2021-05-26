import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:upg_calculator/models/about_container_model.dart';

import '../../constants.dart';

class Menu extends StatefulWidget {
  const Menu(this.scrollController);

  final ScrollController scrollController;

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(milliseconds: Constants.aboutAnimationDuration));
  }

  @override
  Widget build(BuildContext context) {
    final _aboutContainerModel = Provider.of<AboutContainerModel>(context);
    return GestureDetector(
      onTap: () {
        widget.scrollController.animateTo(0, duration: Duration(milliseconds: 600), curve: Curves.elasticOut);
        if (!_aboutContainerModel.isAnimating) {
          if (_aboutContainerModel.isOpened) {
            _aboutContainerModel.close();
            _controller.reverse();
          } else {
            _aboutContainerModel.open();
            _controller.forward();
          }
        }
      },
      child: Center(
          child: AnimatedIcon(icon: AnimatedIcons.menu_close, progress: _controller, color: Colors.black, size: 25)),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
