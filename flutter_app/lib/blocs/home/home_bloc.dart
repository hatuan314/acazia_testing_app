import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterapp/models/model.dart';
import 'package:flutterapp/service/service.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  Repository _repository = Repository();
  List<Person> _allPersons = [];
  List<Person> _selectPersons = [];
  int _tabIndex = 0;

  @override
  // TODO: implement initialState
  HomeState get initialState => HomeLoadingState(this._allPersons, this._tabIndex);

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    // TODO: implement mapEventToState
    if (event is GetAllPersonsEvent) {
      yield* _mapGetAllPersonsToState();
    } else if (event is DismissPersonOnPressEvent) {
      yield* _mapDismissPersonToState(event.person);
    } else if (event is SavePersonOnPressEvent) {
      yield* _mapSavePersonToState(event.person);
    } else if (event is PersonTabOnFlipEvent) {
      yield* _mapPersonTabToState(event.tabIndex);
    }
  }

  Stream<HomeState> _mapGetAllPersonsToState() async* {
    yield HomeLoadingState(this._allPersons, this._tabIndex);
    try {
      var result = await _repository.fetchAllPersonsRepository();
      if (_allPersons == null) {
        _allPersons = [];
      } else {
        _allPersons = result;
      }
      yield HomeSuccessState(_allPersons, this._tabIndex);
    } catch (e) {
      yield HomeFailureState(e.toString());
    }
  }

  Stream<HomeState> _mapDismissPersonToState(Person person) async* {
    yield PersonWaitingState(this._allPersons, this._tabIndex);
    this._allPersons.remove(person);
    if (this._allPersons.length == 0)
      yield* _mapGetAllPersonsToState();
    else
      yield HomeSuccessState(this._allPersons, this._tabIndex);
  }

  Stream<HomeState> _mapSavePersonToState(Person person) async* {
    yield PersonWaitingState(this._allPersons, this._tabIndex);
    this._allPersons.remove(person);
    this._selectPersons.add(person);
    if (this._allPersons.length == 0)
      yield* _mapGetAllPersonsToState();
    else
      yield HomeSuccessState(this._allPersons, this._tabIndex);
  }

  Stream<HomeState> _mapPersonTabToState(int tabIndex) async* {
    yield PersonWaitingState(this._allPersons, this._tabIndex);
    this._tabIndex = tabIndex;
    yield HomeSuccessState(this._allPersons, this._tabIndex);
  }
}
