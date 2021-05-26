import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:upg_calculator/pages/home/home.dart';

import 'models/about_container_model.dart';
import 'models/user_viewmodel.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _aboutContainerModel = Provider.of<AboutContainerModel>(context, listen: false);
    return WillPopScope(
      onWillPop: () => _onWillPop(_aboutContainerModel),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: ChangeNotifierProvider(
          create: (context) => UserViewModel(),
          child: Home(),
        ),
      ),
    );
  }
}

Future<bool> _onWillPop(AboutContainerModel aboutContainerModel) {
  if (!aboutContainerModel.isAnimating && aboutContainerModel.isOpened) {
    aboutContainerModel.close();
  }
  return Future.value(false);
}
