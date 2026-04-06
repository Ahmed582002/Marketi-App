import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/core/api/dio_consumer.dart';
import 'package:store/core/constants/routes.dart';
import 'package:store/features/Presentation/view/screens/auth/forget_password_screen.dart';
import 'package:store/features/Presentation/view/screens/auth/login_screen.dart';
import 'package:store/features/Presentation/view/screens/auth/new_password_screen.dart';
import 'package:store/features/Presentation/view/screens/home/brands_screen.dart';
import 'package:store/features/Presentation/view/screens/home/categories_screen.dart';
import 'package:store/features/Presentation/view/screens/home/home_dummy_screen.dart';
import 'package:store/features/Presentation/view/screens/home/main_screen.dart';
import 'package:store/features/Presentation/view/screens/home/product_details_screen.dart';
import 'package:store/features/Presentation/view/screens/onboarding_screen.dart';
import 'package:store/features/Presentation/view/screens/home/profile_screen.dart';
import 'package:store/features/Presentation/view/screens/auth/signup_screen.dart';
import 'package:store/features/Presentation/view/screens/splash_screen.dart';
import 'package:store/features/Presentation/view/screens/auth/verification_code_screen.dart';
import 'package:store/features/Presentation/viewModel/cubit/auth/cubit/forget_password_cubit.dart';
import 'package:store/features/Presentation/viewModel/cubit/auth/cubit/login_cubit.dart';
import 'package:store/features/Presentation/viewModel/cubit/auth/cubit/new_password_cubit.dart';
import 'package:store/features/Presentation/viewModel/cubit/auth/cubit/signup_cubit.dart';
import 'package:store/features/Presentation/viewModel/cubit/auth/cubit/verification_code_cubit.dart';
import 'package:store/features/Presentation/viewModel/cubit/home/cubit/home_cubit.dart';
import 'package:store/features/Presentation/viewModel/cubit/home/cubit/home_dummy_cubit.dart';
import 'package:store/features/Presentation/viewModel/cubit/home/cubit/product_details_cubit.dart';
import 'package:store/features/Presentation/viewModel/cubit/home/cubit/profile_cubit.dart';
import 'package:store/features/Presentation/viewModel/cubit/onboarding_cubit.dart';
import 'package:store/features/Presentation/viewModel/cubit/splash_cubit.dart';
import 'package:store/features/data/models/home/brand_model.dart';
import 'package:store/features/data/models/home/category_model.dart';
import 'package:store/features/data/repositories/home_repository.dart';
import 'package:store/features/data/repositories/user_repository.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoute.splashScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => SplashCubit(),
            child: const SplashScreen(),
          ),
        );

      case AppRoute.onboarding:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => OnboardingCubit(),
            child: const OnBordingScreen(),
          ),
        );

      case AppRoute.login:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) =>
                LoginCubit(UserRepository(api: DioConsumer(dio: Dio()))),
            child: const LoginScreen(),
          ),
        );

      case AppRoute.signup:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) =>
                SignupCubit(UserRepository(api: DioConsumer(dio: Dio()))),
            child: const SignupScreen(),
          ),
        );

      case AppRoute.forgetPass:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => ForgetPasswordCubit(),
            child: const ForgetPasswordScreen(),
          ),
        );

      case AppRoute.verCode:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => VerificationCodeCubit(),
            child: const VerificationCodeScreen(),
          ),
        );

      case AppRoute.newPass:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => NewPasswordCubit(),
            child: const NewPasswordScreen(),
          ),
        );

      case AppRoute.profile:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) =>
                ProfileCubit(UserRepository(api: DioConsumer(dio: Dio())))
                  ..getUser(),
            child: const ProfileScreen(),
          ),
        );

      case AppRoute.homeDummy:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => HomeDummyCubit(),
            child: const HomeDummyScreen(),
          ),
        );

      case AppRoute.mainScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) =>
                HomeCubit(HomeRepository(api: DioConsumer(dio: Dio())))
                  ..loadHome(),
            child: const MainScreen(),
          ),
        );

      case AppRoute.productDetails:
        final productId = settings.arguments as int;

        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => ProductDetailsCubit(
              HomeRepository(api: DioConsumer(dio: Dio())),
            )..getProduct(productId),
            child: ProductDetailsScreen(productId: productId),
          ),
        );

      case AppRoute.categories:
        final List<CategoryModel> categories =
            settings.arguments as List<CategoryModel>;

        return MaterialPageRoute(
          builder: (_) => CategoriesScreen(categories: categories),
        );

      case AppRoute.brands:
        final List<BrandModel> brands = settings.arguments as List<BrandModel>;

        return MaterialPageRoute(builder: (_) => BrandsScreen(brands: brands));

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(body: Center(child: Text("No route found"))),
        );
    }
  }
}
