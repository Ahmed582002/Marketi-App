import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/features/Presentation/viewModel/cache/cache_helper.dart';
import 'package:store/features/Presentation/viewModel/cubit/onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit() : super(OnboardingInitial(0));

  final PageController pageController = PageController();
  int currentPage = 0;

  void next() {
    if (currentPage < 2) {
      currentPage++;
      pageController.animateToPage(
        currentPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
      emit(OnboardingChanged(currentPage));
    }
  }

  void previous() {
    if (currentPage > 0) {
      currentPage--;
      pageController.animateToPage(
        currentPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
      emit(OnboardingChanged(currentPage));
    }
  }

  void onPageChanged(int index) {
    currentPage = index;
    emit(OnboardingChanged(currentPage));
  }

  Future<void> skip(BuildContext context) async {
    await CacheHelper().saveData(key: "seenOnboarding", value: true);

    Navigator.pushReplacementNamed(context, "/login");
  }

  @override
  Future<void> close() {
    pageController.dispose();
    return super.close();
  }
}
