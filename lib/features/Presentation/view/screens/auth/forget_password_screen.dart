import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/core/constants/color.dart';
import 'package:store/core/constants/images.dart';
import 'package:store/features/Presentation/view/widgets/custom_button.dart';
import 'package:store/features/Presentation/view/widgets/custom_textfield.dart';
import 'package:store/features/Presentation/viewModel/cubit/auth/cubit/forget_password_cubit.dart';
import 'package:store/features/Presentation/viewModel/cubit/auth/state/forget_password_state.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

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
      body: BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
        listener: (context, state) {
          if (state is ForgetPasswordSuccess) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));

            context.read<ForgetPasswordCubit>().goToVerificationCode(context);
          }

          if (state is ForgetPasswordError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        builder: (context, state) {
          final cubit = context.read<ForgetPasswordCubit>();

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const Spacer(),

                Center(
                  child: Image.asset(
                    AppImages.forgetpass,
                    height: MediaQuery.of(context).size.height * 0.35,
                  ),
                ),

                const SizedBox(height: 10),

                Text(
                  'Forgot Password',
                  style: Theme.of(
                    context,
                  ).textTheme.displayLarge!.copyWith(fontSize: 26),
                ),

                const SizedBox(height: 15),

                Text(
                  textAlign: TextAlign.center,
                  'Please enter your email address to \nreceive a verification code',
                  style: Theme.of(
                    context,
                  ).textTheme.displaySmall!.copyWith(fontSize: 14),
                ),

                const Spacer(),

                CustomTextField(
                  hintText: "Email",
                  controller: cubit.emailController,
                ),

                const SizedBox(height: 10),

                state is ForgetPasswordLoading
                    ? const CircularProgressIndicator()
                    : CustomButton(
                        text: "Send Code",
                        onPressed: () {
                          cubit.sendCode(context);
                        },
                      ),

                const Spacer(),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Remember your password? ",
                      style: Theme.of(
                        context,
                      ).textTheme.displaySmall!.copyWith(fontSize: 14),
                    ),
                    GestureDetector(
                      onTap: () {
                        cubit.goToLogin(context);
                      },
                      child: Text(
                        "LogIn",
                        style: Theme.of(context).textTheme.displaySmall!
                            .copyWith(
                              fontSize: 14,
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
