import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterapp/blocs/bloc.dart';
import 'package:flutterapp/ui/view/view.dart';

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

    final args = settings.arguments as Map<String, dynamic> ?? {};

    // todo:  add screen route here
//    switch (settings.name) {
//      case '/register':
//        screen = RegisterView();
//        break;
//      case '/sign-in':
//        return CupertinoPageRoute(builder: (context) {
//          return SignInView();
//        });
//      case '/todo-detail':
//        PersonalSchedule schedule =
//        PersonalSchedule.fromJson(settings.arguments);
//        return CupertinoPageRoute(builder: (context) {
//          ScUtil.init(context, pWidth: 750, pHeight: 640);
//          return BlocProvider(
//              create: (context) => TodoBloc(),
//              child: TodoDetailView(schedule: schedule));
//        });
//    }

    return CupertinoPageRoute(
      builder: (context) {
        ScreenUtil.init(context, width: 414, height: 896);
        return screen;
      },
    );
  };
}
