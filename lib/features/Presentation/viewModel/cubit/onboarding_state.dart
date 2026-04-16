abstract class OnboardingState {}

class OnboardingInitial extends OnboardingState {
  final int currentPage;
  OnboardingInitial(this.currentPage);
}

class OnboardingChanged extends OnboardingState {
  final int currentPage;
  OnboardingChanged(this.currentPage);
}
