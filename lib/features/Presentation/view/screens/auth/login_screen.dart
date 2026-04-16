import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/core/constants/color.dart';
import 'package:store/core/constants/images.dart';
import 'package:store/core/constants/routes.dart';
import 'package:store/features/Presentation/view/widgets/custom_button.dart';
import 'package:store/features/Presentation/view/widgets/custom_login_with_button.dart';
import 'package:store/features/Presentation/view/widgets/custom_textfield.dart';
import 'package:store/features/Presentation/viewModel/cubit/auth/cubit/login_cubit.dart';
import 'package:store/features/Presentation/viewModel/cubit/auth/state/login_state.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'ZENEX',
          style: Theme.of(context).textTheme.displayLarge!.copyWith(
            fontSize: 22,
            color: AppColors.primary,
          ),
        ),
      ),
      body: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));

            Navigator.pushReplacementNamed(context, AppRoute.home);
          } else if (state is LoginError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        builder: (context, state) {
          final cubit = context.read<LoginCubit>();

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                const Spacer(),

                Text(
                  'Welcome Back',
                  style: Theme.of(
                    context,
                  ).textTheme.displayLarge!.copyWith(fontSize: 24),
                ),

                const SizedBox(height: 20),

                Text(
                  'LogIn to your ZENEX account to continue.',
                  style: Theme.of(
                    context,
                  ).textTheme.displaySmall!.copyWith(fontSize: 14),
                ),

                const Spacer(),

                CustomTextField(
                  hintText: "Email",
                  prefixIcon: Icons.email,
                  controller: cubit.emailController,
                ),

                CustomTextField(
                  hintText: "Password",
                  isPassword: true,
                  prefixIcon: Icons.lock,
                  controller: cubit.passwordController,
                  onForgot: () {
                    cubit.goToForgotPassword(context);
                  },
                ),

                const Spacer(),

                state is LoginLoading
                    ? const CircularProgressIndicator()
                    : CustomButton(
                        text: "LogIn",
                        onPressed: () {
                          cubit.login();
                        },
                      ),

                const Spacer(),

                const Text(
                  "---------------- OR Continue with ----------------",
                ),

                const Spacer(),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CustomLoginWithButton(
                      onPressed: cubit.loginWithGoogle,
                      imagePath: AppImages.google2,
                      text: "  Google  ",
                    ),
                    CustomLoginWithButton(
                      onPressed: cubit.loginWithApple,
                      imagePath: AppImages.ios,
                      text: "   Apple   ",
                    ),
                  ],
                ),

                const Spacer(),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("New to ZENEX? "),
                    GestureDetector(
                      onTap: () {
                        cubit.goToSignUp(context);
                      },
                      child: const Text(
                        "Create account",
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),

                const Spacer(),
              ],
            ),
          );
        },
      ),
    );
  }
}
