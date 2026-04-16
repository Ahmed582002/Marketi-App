import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/core/constants/routes.dart';
import 'package:store/features/Presentation/viewModel/cubit/auth/state/verification_code_state.dart';

class VerificationCodeCubit extends Cubit<VerificationCodeState> {
  VerificationCodeCubit() : super(VerificationCodeInitial());

  TextEditingController codeController = TextEditingController();

  void verifyCode(BuildContext context) {
    emit(VerificationCodeLoading());

    // Later i will call repository here

    emit(VerificationCodeSuccess("Code Verified"));

    Navigator.pushReplacementNamed(context, AppRoute.newPass);
  }

  void resendCode() {
    emit(VerificationCodeSuccess("Code Sent Again"));
  }

  @override
  Future<void> close() {
    codeController.dispose();
    return super.close();
  }
}
