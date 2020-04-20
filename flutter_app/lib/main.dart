import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterapp/app.dart';
import 'package:flutterapp/sevice_locator.dart';

import 'blocs/bloc.dart';

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  setupLocator();
  runApp(MyApp());}
