abstract class VerificationCodeState {}

class VerificationCodeInitial extends VerificationCodeState {}

class VerificationCodeLoading extends VerificationCodeState {}

class VerificationCodeSuccess extends VerificationCodeState {
  final String message;

  VerificationCodeSuccess(this.message);
}

class VerificationCodeError extends VerificationCodeState {
  final String error;

  VerificationCodeError(this.error);
}
