import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/core/constants/color.dart';
import 'package:store/core/constants/images.dart';
import 'package:store/features/Presentation/view/widgets/custom_button.dart';
import 'package:store/features/Presentation/view/widgets/custom_login_with_button.dart';
import 'package:store/features/Presentation/view/widgets/custom_textfield.dart';
import 'package:store/features/Presentation/viewModel/cubit/auth/cubit/signup_cubit.dart';
import 'package:store/features/Presentation/viewModel/cubit/auth/state/signup_state.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

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
      body: BlocConsumer<SignupCubit, SignupState>(
        listener: (context, state) {
          if (state is SignupSuccess) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));

            Navigator.pushReplacementNamed(context, "/login");
          }

          if (state is SignupError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        builder: (context, state) {
          final cubit = context.read<SignupCubit>();

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ListView(
              children: [
                const SizedBox(height: 20),

                Center(
                  child: Text(
                    'Begin your journey',
                    style: Theme.of(
                      context,
                    ).textTheme.displayLarge!.copyWith(fontSize: 20),
                  ),
                ),

                const SizedBox(height: 10),

                Text(
                  textAlign: TextAlign.center,
                  'Create your ZENEX account to start \nshopping.',
                  style: Theme.of(
                    context,
                  ).textTheme.displaySmall!.copyWith(fontSize: 14),
                ),

                const SizedBox(height: 20),

                CustomTextField(
                  hintText: "Name",
                  controller: cubit.nameController,
                ),

                CustomTextField(
                  hintText: "Phone",
                  controller: cubit.phoneController,
                ),

                CustomTextField(
                  hintText: "Email",
                  controller: cubit.emailController,
                ),

                CustomTextField(
                  hintText: "Password",
                  isPassword: true,
                  controller: cubit.passwordController,
                ),

                CustomTextField(
                  hintText: "Confirm Password",
                  isPassword: true,
                  controller: cubit.confirmPasswordController,
                ),

                const SizedBox(height: 15),

                state is SignupLoading
                    ? const Center(child: CircularProgressIndicator())
                    : CustomButton(
                        text: "SignUp",
                        onPressed: () {
                          cubit.signup();
                        },
                      ),

                const SizedBox(height: 30),

                const Center(
                  child: Text(
                    "---------------- OR Continue with ----------------",
                  ),
                ),

                const SizedBox(height: 30),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CustomLoginWithButton(
                      text: "  Google  ",
                      onPressed: cubit.signupWithGoogle,
                      imagePath: AppImages.google2,
                    ),
                    CustomLoginWithButton(
                      text: "  Apple  ",
                      onPressed: cubit.signupWithApple,
                      imagePath: AppImages.ios,
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account? ",
                      style: Theme.of(
                        context,
                      ).textTheme.displaySmall!.copyWith(fontSize: 13),
                    ),
                    GestureDetector(
                      onTap: () {
                        cubit.goToLogin(context);
                      },
                      child: Text(
                        "LogIn",
                        style: Theme.of(context).textTheme.displaySmall!
                            .copyWith(
                              fontSize: 13,
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),
              ],
            ),
          );
        },
      ),
    );
  }
}
