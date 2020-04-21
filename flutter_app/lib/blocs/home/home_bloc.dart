import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterapp/models/model.dart';
import 'package:flutterapp/service/service.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  Repository _repository = Repository();
  List<Person> _people = [];
  List<Person> favoritePeople = [];
  int _tabIndex = 0;

  @override
  // TODO: implement initialState
  HomeState get initialState => HomeLoadingState(this._people, this._tabIndex);

  @override
  Stream<HomeState> mapEventToState(HomeEvent event) async* {
    // TODO: implement mapEventToState
    if (event is GetAllPersonsEvent) {
      yield* _mapGetAllPersonsToState();
    } else if (event is DismissPersonOnPressEvent) {
      yield* _mapDismissPersonToState(event.person);
    } else if (event is SavePersonOnPressEvent) {
      yield* _mapSavePersonToState(event.person);
    } else if (event is SelecPersonTabOnPressEvent) {
      yield* _mapPersonTabToState(event.tabIndex);
    }
  }

  Stream<HomeState> _mapGetAllPersonsToState() async* {
    yield HomeLoadingState(this._people, this._tabIndex);
    try {
      var result = await _repository.fetchAllPersonsRepository();
      if (_people == null) {
        _people = [];
      } else {
        _people = result;
      }
      yield HomeSuccessState(this.favoritePeople, this._people, this._tabIndex);
    } catch (e) {
      yield HomeFailureState(e.toString());
    }
  }

  Stream<HomeState> _mapDismissPersonToState(Person person) async* {
    yield PersonWaitingState(this._people, this._tabIndex);
    this._people.remove(person);
    if (this._people.length == 0)
      yield* _mapGetAllPersonsToState();
    else
      yield HomeSuccessState(this.favoritePeople, this._people, this._tabIndex);
  }

  Stream<HomeState> _mapSavePersonToState(Person person) async* {
    yield PersonWaitingState(this._people, this._tabIndex);
    this._people.remove(person);
    this.favoritePeople.add(person);
    if (this._people.length == 0)
      yield* _mapGetAllPersonsToState();
    else
      yield HomeSuccessState(this.favoritePeople, this._people, this._tabIndex);
  }

  Stream<HomeState> _mapPersonTabToState(int tabIndex) async* {
    yield PersonWaitingState(this._people, this._tabIndex);
    this._tabIndex = tabIndex;
    yield HomeSuccessState(this.favoritePeople, this._people, this._tabIndex);
  }
}
