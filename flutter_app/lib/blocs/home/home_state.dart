part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  final List<Person> allPersons;
  final int tabIndex;

  HomeState(this.allPersons, this.tabIndex);
}


class PersonWaitingState extends HomeState {
  PersonWaitingState(List<Person> allPersons, int tabIndex) : super(allPersons, tabIndex);

  @override
  // TODO: implement props
  List<Object> get props => null;

}

class HomeLoadingState extends HomeState {
  HomeLoadingState(List<Person> allPersons, int tabIndex) : super(allPersons, tabIndex);

  @override
  // TODO: implement props
  List<Object> get props => null;

}

class HomeSuccessState extends HomeState {
  HomeSuccessState(List<Person> allPersons, int tabIndex) : super(allPersons, tabIndex);

  @override
  // TODO: implement props
  List<Object> get props => [this.allPersons, this.tabIndex];

}

class HomeFailureState extends HomeState {
  final String error;

  HomeFailureState(this.error, {List<Person> allPersons, int tabIndex}) : super(allPersons, tabIndex);
  @override
  // TODO: implement props
  List<Object> get props => [this.error];

  @override
  String toString() => "HomeFailureState - Error: {$error}";
}