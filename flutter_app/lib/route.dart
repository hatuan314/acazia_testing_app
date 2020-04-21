import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterapp/blocs/bloc.dart';
import 'package:flutterapp/models/model.dart';

import 'views/view.dart';

int currentRoot = 1;

RouteFactory router() {
  return (RouteSettings settings) {
    Widget screen;

    if (currentRoot == 1) {
      currentRoot = 2;
      screen = BlocProvider(
          create: (context) => HomeBloc()..add(GetAllPersonsEvent()),
          child: HomeView());
    }

    // todo:  add screen route here
    switch (settings.name) {
      case '/favorites':
        List<Person> favoritePeople = settings.arguments;
        screen = FavoriteView(people: favoritePeople);
        break;
    }

    return CupertinoPageRoute(
      builder: (context) {
        ScreenUtil.init(context, width: 414, height: 896);
        return screen;
      },
    );
  };
}
