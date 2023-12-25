abstract class SuggestionState {}

class SuggestionInitial extends SuggestionState {}

class SuggestionLoading extends SuggestionState {}

class SuggestionSuccess extends SuggestionState {}

class SuggestionFailure extends SuggestionState {
  final String error;

  SuggestionFailure(this.error);
}
class FileUploadLoading extends SuggestionState {}

class FileUploadSuccess extends SuggestionState {}

class FileUploadFailure extends SuggestionState {
  final String error;

  FileUploadFailure(this.error);
}