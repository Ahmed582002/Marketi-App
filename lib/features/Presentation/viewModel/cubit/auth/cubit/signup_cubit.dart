import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/core/constants/routes.dart';
import 'package:store/features/Presentation/viewModel/cubit/auth/state/signup_state.dart';
import 'package:store/features/data/repositories/user_repository.dart';

class SignupCubit extends Cubit<SignupState> {
  final UserRepository repository;

  SignupCubit(this.repository) : super(SignupInitial());

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  Future<void> signup() async {
    emit(SignupLoading());

    final result = await repository.signUp(
      name: nameController.text,
      phone: phoneController.text,
      email: emailController.text,
      password: passwordController.text,
      confirmPassword: confirmPasswordController.text,
    );

    result.fold(
      (error) => emit(SignupError(error)),
      (user) => emit(SignupSuccess("Account Created Successfully")),
    );
  }

  void signupWithGoogle() {}

  void signupWithApple() {}

  void goToLogin(BuildContext context) {
    Navigator.pushReplacementNamed(context, AppRoute.login);
  }

  @override
  Future<void> close() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    return super.close();
  }
}
