
abstract class HomePageState {}

class HomePageInitial extends HomePageState {}

class HomePageLoading extends HomePageState {}

class HomePageSuccess extends HomePageState {}

class HomePageFailure extends HomePageState {
  final String error;

  HomePageFailure(this.error);
}

class ChangeNavState extends HomePageState {}
