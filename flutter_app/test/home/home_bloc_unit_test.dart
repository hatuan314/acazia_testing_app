import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutterapp/blocs/bloc.dart';
import 'package:flutterapp/models/model.dart';

void main() {
  HomeBloc homeBloc;
  setUp(() {
    homeBloc = HomeBloc();
  });

  tearDown(() {
    homeBloc?.close();
  });

  test('initial is correct', () {
    expect(HomeLoadingState([], 0, [],), homeBloc.initialState);
  });
}
