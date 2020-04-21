part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  final List<Person> people;
  final int tabIndex;

  HomeState(this.people, this.tabIndex);
}

class PersonWaitingState extends HomeState {
  PersonWaitingState(List<Person> people, int tabIndex)
      : super(people, tabIndex);

  @override
  // TODO: implement props
  List<Object> get props => null;
}

class HomeLoadingState extends HomeState {
  HomeLoadingState(List<Person> people, int tabIndex) : super(people, tabIndex);

  @override
  // TODO: implement props
  List<Object> get props => null;
}

class HomeSuccessState extends HomeState {
  final List<Person> favoritePeople;

  HomeSuccessState(this.favoritePeople, List<Person> people, int tabIndex)
      : super(people, tabIndex);

  @override
  // TODO: implement props
  List<Object> get props => [this.favoritePeople, this.people, this.tabIndex];
}

class HomeFailureState extends HomeState {
  final String error;

  HomeFailureState(this.error, {List<Person> people, int tabIndex})
      : super(people, tabIndex);

  @override
  // TODO: implement props
  List<Object> get props => [this.error];

  @override
  String toString() => "HomeFailureState - Error: {$error}";
}
