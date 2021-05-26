import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:provider/provider.dart';
import 'package:upg_calculator/models/about_container_model.dart';
import 'package:upg_calculator/models/user_viewmodel.dart';
import 'package:upg_calculator/pages/home/home.dart';
import 'package:upg_calculator/service_locator.dart';
import 'package:upg_calculator/styles.dart';
import 'package:upg_calculator/wrapper.dart';

void main() {
  setupServiceLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("MAIN BUILDED");
    return StyledToast(
      locale: Locale('en', 'US'),
      borderRadius: BorderRadius.circular(30),
      textStyle: TextStyles.medium.colour(Colors.white).weight(FontWeight.w300),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'UPG Calculator',
        theme: ThemeData(
          fontFamily: 'SourceSansPro',
          primarySwatch: Colors.red,
          primaryTextTheme:
              TextTheme(headline6: TextStyle(color: Colors.black, fontSize: 23, fontWeight: FontWeight.bold)),
          visualDensity: VisualDensity.adaptivePlatformDensity,
          appBarTheme: AppBarTheme(
            color: Colors.white,
          ),
        ),
        home: SafeArea(
          child: ChangeNotifierProvider(
            create: (context) => AboutContainerModel(),
            child: Wrapper(),
          ),
        ),
      ),
    );
  }
}
