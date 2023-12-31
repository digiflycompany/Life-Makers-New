abstract class CardStates {}

class CardInitial extends CardStates {}

class CardLoading extends CardStates {}

class CardSuccess extends CardStates {}

class CardFailure extends CardStates {
  final String error;

  CardFailure(this.error);
}