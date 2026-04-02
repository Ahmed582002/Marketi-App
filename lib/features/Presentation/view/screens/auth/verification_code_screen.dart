import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';
import 'package:store/core/constants/color.dart';
import 'package:store/core/constants/images.dart';
import 'package:store/features/Presentation/view/widgets/custom_button.dart';
import 'package:store/features/Presentation/viewModel/cubit/auth/cubit/verification_code_cubit.dart';
import 'package:store/features/Presentation/viewModel/cubit/auth/state/verification_code_state.dart';

class VerificationCodeScreen extends StatelessWidget {
  const VerificationCodeScreen({super.key});

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
      body: BlocConsumer<VerificationCodeCubit, VerificationCodeState>(
        listener: (context, state) {
          if (state is VerificationCodeSuccess) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }

          if (state is VerificationCodeError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        builder: (context, state) {
          final cubit = context.read<VerificationCodeCubit>();

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const Spacer(),

                Center(
                  child: Image.asset(
                    AppImages.vercode,
                    height: MediaQuery.of(context).size.height * 0.35,
                  ),
                ),

                const SizedBox(height: 10),

                Text(
                  'Verification Code',
                  style: Theme.of(
                    context,
                  ).textTheme.displayLarge!.copyWith(fontSize: 26),
                ),

                const SizedBox(height: 15),

                Text(
                  textAlign: TextAlign.center,
                  'Please enter the 4 digit code sent to your \nemail address to verify your account.',
                  style: Theme.of(
                    context,
                  ).textTheme.displaySmall!.copyWith(fontSize: 14),
                ),

                const Spacer(),

                Pinput(
                  controller: cubit.codeController,
                  length: 4,
                  defaultPinTheme: PinTheme(
                    width: 60,
                    height: 60,
                    textStyle: Theme.of(context).textTheme.displayMedium!
                        .copyWith(fontSize: 18, color: AppColors.primary),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.primary),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),

                const Spacer(),

                state is VerificationCodeLoading
                    ? const CircularProgressIndicator()
                    : CustomButton(
                        text: "Verify Code",
                        onPressed: () {
                          cubit.verifyCode(context);
                        },
                      ),

                const Spacer(),

                GestureDetector(
                  onTap: () {
                    cubit.resendCode();
                  },
                  child: Text(
                    "Resend Code",
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(
                      fontSize: 14,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
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
