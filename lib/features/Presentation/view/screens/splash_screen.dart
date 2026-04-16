import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/features/Presentation/viewModel/cubit/splash_cubit.dart';
import 'package:store/features/Presentation/viewModel/cubit/splash_state.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<SplashCubit, SplashState>(
        listener: (context, state) {
          if (state is SplashNavigate) {
            Navigator.pushReplacementNamed(context, state.route);
          }
        },
        child: Center(
          child: Image.asset(
            "assets/images/logo2.png",
            width: MediaQuery.of(context).size.width * 0.65,
          ),
        ),
      ),
    );
  }
}
