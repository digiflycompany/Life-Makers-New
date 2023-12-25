
abstract class SignUpState {}

class SignUpInitial extends SignUpState {}

class SignUpLoading extends SignUpState {}

class SignUpSuccess extends SignUpState {}

class SignUpFailure extends SignUpState {
  final String error;

  SignUpFailure(this.error);
}


class OtpSendLoading extends SignUpState{}

class OtpSendSuccess extends SignUpState{}

class OtpResend extends SignUpState{}

class OtpResendCycleState extends SignUpState{}

class OtpSendPhoneNotFull extends SignUpState{}

class OtpSendFailure extends SignUpState{
  final String error;
  OtpSendFailure(this.error);
}

class OtpSubmitLoading extends SignUpState{}

class OtpSubmitSuccess extends SignUpState{}

class OtpSubmitFailure extends SignUpState{
  final String error;
  OtpSubmitFailure(this.error);
}

class ChangePasswordVisibility extends SignUpState {}

class otpResetPasswordSentSuccess extends SignUpState {}

class otpResetPasswordSentLoading extends SignUpState {}

class otpResetPasswordSentFailure extends SignUpState {
  final String error;
  otpResetPasswordSentFailure(this.error);
}

class otpResetPasswordSubmitSuccess extends SignUpState {}

class otpResetPasswordSubmitLoading extends SignUpState {}

class otpResetPasswordSubmitFailure extends SignUpState {
  final String error;
  otpResetPasswordSubmitFailure(this.error);
}

class changePasswordSuccess extends SignUpState {}

class changePasswordLoading extends SignUpState {}

class changePasswordFailure extends SignUpState {
  final String error;
  changePasswordFailure(this.error);
}

class changePasswordAfterLoginSuccess extends SignUpState {}

class changePasswordAfterLoginLoading extends SignUpState {}

class changePasswordAfterLoginFailure extends SignUpState {
  final String error;
  changePasswordAfterLoginFailure(this.error);
}

class cityListLoading extends SignUpState {}

class cityListSuccessfully extends SignUpState {}

class cityListFailure extends SignUpState {
  final String error;
  cityListFailure(this.error);
}
class areaListLoading extends SignUpState {}

class areaListSuccessfully extends SignUpState {}

class areaListFailure extends SignUpState {
  final String error;
  areaListFailure(this.error);
}