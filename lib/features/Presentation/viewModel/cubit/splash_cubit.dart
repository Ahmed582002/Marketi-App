import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/core/constants/routes.dart';
import 'package:store/features/Presentation/viewModel/cache/cache_helper.dart';
import 'package:store/features/Presentation/viewModel/cubit/splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial()) {
    navigate();
  }

  Future<void> navigate() async {
    await Future.delayed(const Duration(seconds: 3));

    final seenOnboarding =
        CacheHelper().getData(key: "seenOnboarding") ?? false;

    final token = CacheHelper().getData(key: "token");

    if (seenOnboarding) {
      if (token != null) {
        emit(SplashNavigate(AppRoute.mainScreen));
      } else {
        emit(SplashNavigate(AppRoute.login));
      }
    } else {
      emit(SplashNavigate(AppRoute.onboarding));
    }
  }
}
