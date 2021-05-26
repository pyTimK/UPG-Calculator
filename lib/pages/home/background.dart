import 'package:flutter/material.dart';

class Background extends StatefulWidget {
  final ScrollController controller;
  Background(this.controller);
  @override
  _BackgroundState createState() => _BackgroundState();
}

class _BackgroundState extends State<Background> {
  static final double top1Max = -200.0;
  static final double top2Max = 140.0;
  static final double top3Max = -80.0;
  double top1;
  double top2;
  double top3;
  @override
  void initState() {
    super.initState();
    //widget.controller.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    if (widget.controller.hasClients) {
      double maxScroll = widget.controller.position.maxScrollExtent;
      double percent = maxScroll != 0 ? widget.controller.offset / maxScroll : 0;
      top1 = top1Max * percent;
      top2 = top2Max * percent;
      top3 = top3Max * percent;
      //print(widget.controller.offset);
    }
    return Stack(
      children: [
        Container(color: Colors.black),
        Positioned(
          width: MediaQuery.of(context).size.width,
          top: top1,
          child: Image.asset("assets/parallax/layer3.png", fit: BoxFit.fill),
        ),
        Positioned(
          width: MediaQuery.of(context).size.width,
          top: top2,
          child: Image.asset("assets/parallax/layer2.png", fit: BoxFit.fill),
        ),
        Positioned(
          width: MediaQuery.of(context).size.width,
          top: top3,
          child: Image.asset("assets/parallax/layer1.png", fit: BoxFit.fill),
        ),
      ],
    );
  }
}
