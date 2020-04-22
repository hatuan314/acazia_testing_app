part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  final List<Person> people;
  final List<Person> favoritePeople;
  final int tabIndex;

  HomeState(this.people, this.tabIndex, this.favoritePeople);
}

class PersonWaitingState extends HomeState {
  PersonWaitingState(List<Person> people, int tabIndex, List<Person> favoritePeople) : super(people, tabIndex, favoritePeople);


  @override
  // TODO: implement props
  List<Object> get props => null;
}

class HomeLoadingState extends HomeState {
  HomeLoadingState(List<Person> people, int tabIndex, List<Person> favoritePeople) : super(people, tabIndex, favoritePeople);


  @override
  // TODO: implement props
  List<Object> get props => null;
}

class HomeSuccessState extends HomeState {
  HomeSuccessState(List<Person> people, int tabIndex, List<Person> favoritePeople) : super(people, tabIndex, favoritePeople);


  @override
  // TODO: implement props
  List<Object> get props => [this.favoritePeople, this.people, this.tabIndex];
}

class HomeFailureState extends HomeState {
  final String error;

  HomeFailureState(this.error, {List<Person> people, int tabIndex, List<Person> favoritePeople}) : super(people, tabIndex, favoritePeople);

  @override
  // TODO: implement props
  List<Object> get props => [this.error];

  @override
  String toString() => "HomeFailureState - Error: {$error}";
}
