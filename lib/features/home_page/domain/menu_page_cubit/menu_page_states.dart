abstract class MenuState {}

class MenuInitial extends MenuState {}

class DeleteAccountInProgress extends MenuState {}

class DeleteAccountSuccess extends MenuState {}

class DeleteAccountFailure extends MenuState {
  final String error;

  DeleteAccountFailure(this.error);
}

class fetchDateTimeSuccess extends MenuState {}

class fetchDateTimeLoading extends MenuState {}

class fetchDateTimeFailure extends MenuState {
  final String error;

  fetchDateTimeFailure(this.error);
}