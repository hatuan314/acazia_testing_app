import 'package:flutter/material.dart';
import 'package:flutterapp/route.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      onGenerateRoute: router(),
    );
  }

}