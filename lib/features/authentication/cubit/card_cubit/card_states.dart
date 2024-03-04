abstract class CardStates {}

class CardInitial extends CardStates {}

class CardLoading extends CardStates {}

class CardSuccess extends CardStates {}

class CardFailure extends CardStates {
  final String error;

  CardFailure(this.error);
}

class JoinedVolunteerLoading extends CardStates {}

class JoinedVolunteerSuccess extends CardStates {}

class JoinedVolunteerFailure extends CardStates {
  final String error;

  JoinedVolunteerFailure(this.error);
}

class leftVolunteerLoading extends CardStates {}

class leftVolunteerSuccess extends CardStates {}

class leftVolunteerFailure extends CardStates {
  final String error;

  leftVolunteerFailure(this.error);
}