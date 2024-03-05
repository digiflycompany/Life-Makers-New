abstract class AppLayoutState {}

class AppLayoutInitial extends AppLayoutState {}

class AppLayoutLoading extends AppLayoutState {}

class AppLayoutSuccess extends AppLayoutState {}

class AppLayoutFailure extends AppLayoutState {
  final String error;

  AppLayoutFailure(this.error);
}

class ChangeNavState extends AppLayoutState {}
