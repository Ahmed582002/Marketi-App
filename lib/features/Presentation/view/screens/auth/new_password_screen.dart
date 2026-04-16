import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/core/constants/color.dart';
import 'package:store/core/constants/images.dart';
import 'package:store/features/Presentation/view/widgets/custom_button.dart';
import 'package:store/features/Presentation/view/widgets/custom_textfield.dart';
import 'package:store/features/Presentation/viewModel/cubit/auth/cubit/new_password_cubit.dart';
import 'package:store/features/Presentation/viewModel/cubit/auth/state/new_password_state.dart';

class NewPasswordScreen extends StatelessWidget {
  const NewPasswordScreen({super.key});

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
      body: BlocBuilder<NewPasswordCubit, NewPasswordState>(
        builder: (context, state) {
          final cubit = context.read<NewPasswordCubit>();

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ListView(
              children: [
                Center(
                  child: Image.asset(
                    AppImages.newpass,
                    height: MediaQuery.of(context).size.height * 0.4,
                  ),
                ),

                Center(
                  child: Text(
                    'Create New Password',
                    style: Theme.of(
                      context,
                    ).textTheme.displayLarge!.copyWith(fontSize: 26),
                  ),
                ),

                SizedBox(height: MediaQuery.of(context).size.height * 0.025),

                Text(
                  textAlign: TextAlign.center,
                  'New password must be different from last \npassword',
                  style: Theme.of(
                    context,
                  ).textTheme.displaySmall!.copyWith(fontSize: 14),
                ),

                SizedBox(height: MediaQuery.of(context).size.height * 0.025),

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

                SizedBox(height: MediaQuery.of(context).size.height * 0.025),

                CustomButton(
                  text: "Save Password",
                  onPressed: () {
                    cubit.savePassword(context);
                  },
                ),

                SizedBox(height: MediaQuery.of(context).size.height * 0.025),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Having trouble? ",
                      style: Theme.of(
                        context,
                      ).textTheme.displaySmall!.copyWith(fontSize: 13),
                    ),
                    GestureDetector(
                      onTap: () {
                        cubit.contactSupport();
                      },
                      child: Text(
                        "Contact Support",
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

                SizedBox(height: MediaQuery.of(context).size.height * 0.025),
              ],
            ),
          );
        },
      ),
    );
  }
}
