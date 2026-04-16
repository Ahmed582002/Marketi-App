import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/core/constants/routes.dart';
import 'package:store/features/Presentation/viewModel/cubit/auth/state/login_state.dart';
import 'package:store/features/data/repositories/user_repository.dart';

class LoginCubit extends Cubit<LoginState> {
  final UserRepository repository;

  LoginCubit(this.repository) : super(LoginInitial());

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> login() async {
    emit(LoginLoading());

    final result = await repository.signIn(
      email: emailController.text,
      password: passwordController.text,
    );

    result.fold(
      (error) => emit(LoginError(error)),
      (user) => emit(LoginSuccess("Login Success")),
    );
  }

  // Navigation
  void goToForgotPassword(BuildContext context) {
    Navigator.pushReplacementNamed(context, AppRoute.forgetPass);
  }

  void goToSignUp(BuildContext context) {
    Navigator.pushReplacementNamed(context, AppRoute.signup);
  }

  void loginWithGoogle() {}
  void loginWithApple() {}

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    return super.close();
  }
}
