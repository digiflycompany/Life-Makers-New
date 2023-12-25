abstract class OneDayActivityState {}

class OneDayActivityInitial extends OneDayActivityState {}

class OneDayActivityLoading extends OneDayActivityState {}

class OneDayActivitySuccess extends OneDayActivityState {}

class OneDayActivityFailure extends OneDayActivityState {
  final String error;

  OneDayActivityFailure(this.error);
}

class JoinOneDayActivityLoading extends OneDayActivityState {}

class JoinOneDayActivitySuccess extends OneDayActivityState {}

class JoinOneDayActivityFailure extends OneDayActivityState {
  final String error;

  JoinOneDayActivityFailure(this.error);
}

class leftOneDayActivityLoading extends OneDayActivityState {}

class leftOneDayActivitySuccess extends OneDayActivityState {}

class leftOneDayActivityFailure extends OneDayActivityState {
  final String error;

  leftOneDayActivityFailure(this.error);
}