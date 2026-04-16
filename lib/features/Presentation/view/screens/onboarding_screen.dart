import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/core/constants/color.dart';
import 'package:store/features/Presentation/view/widgets/custom_button.dart';
import 'package:store/features/Presentation/view/widgets/dots.dart';
import 'package:store/features/Presentation/view/widgets/pageview.dart';
import 'package:store/features/Presentation/viewModel/cubit/onboarding_cubit.dart';
import 'package:store/features/Presentation/viewModel/cubit/onboarding_state.dart';

class OnBordingScreen extends StatelessWidget {
  const OnBordingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<OnboardingCubit>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "ZENEX",
          style: Theme.of(context).textTheme.displayLarge!.copyWith(
            color: AppColors.primary,
            fontSize: 25,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => cubit.skip(context),
            child: const Text("Skip", style: TextStyle(color: AppColors.text)),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Expanded(
              flex: 10,
              child: MyPageView(
                controller: cubit.pageController,
                onPageChanged: cubit.onPageChanged,
              ),
            ),

            const Spacer(),

            Expanded(
              flex: 3,
              child: BlocBuilder<OnboardingCubit, OnboardingState>(
                builder: (context, state) {
                  final page = cubit.currentPage;

                  return Column(
                    children: [
                      Dots(currentIndex: page),

                      const SizedBox(height: 20),

                      CustomButton(
                        text: page == 2 ? "Get Started" : "Next",
                        onPressed: () {
                          if (page == 2) {
                            cubit.skip(context);
                          } else {
                            cubit.next();
                          }
                        },
                      ),

                      TextButton(
                        onPressed: cubit.previous,
                        child: Text(
                          "Back",
                          style: Theme.of(
                            context,
                          ).textTheme.displaySmall!.copyWith(fontSize: 15),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
