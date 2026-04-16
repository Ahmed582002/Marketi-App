import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/core/constants/routes.dart';
import 'package:store/features/Presentation/viewModel/cubit/auth/state/forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  ForgetPasswordCubit() : super(ForgetPasswordInitial());

  TextEditingController emailController = TextEditingController();

  void sendCode(BuildContext context) {
    emit(ForgetPasswordLoading());

    // Later i can call repository here

    emit(ForgetPasswordSuccess("Verification code sent"));

    Navigator.pushReplacementNamed(context, AppRoute.verCode);
  }

  void goToLogin(BuildContext context) {
    Navigator.pushReplacementNamed(context, AppRoute.login);
  }

  void goToVerificationCode(BuildContext context) {
    Navigator.pushReplacementNamed(context, AppRoute.verCode);
  }

  @override
  Future<void> close() {
    emailController.dispose();
    return super.close();
  }
}
