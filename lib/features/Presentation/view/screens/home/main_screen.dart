import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/core/constants/color.dart';
import 'package:store/features/Presentation/view/screens/home/brands_screen.dart';
import 'package:store/features/Presentation/view/screens/home/categories_screen.dart';
import 'package:store/features/Presentation/view/screens/home/home_dummy_screen.dart';
import 'package:store/features/Presentation/viewModel/cubit/home/cubit/main_cubit.dart';
import 'package:store/features/Presentation/viewModel/cubit/home/state/main_state.dart';
import 'package:store/features/Presentation/view/widgets/home/navbar.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MainCubit(),
      child: BlocBuilder<MainCubit, MainState>(
        builder: (context, state) {
          final cubit = context.read<MainCubit>();

          final screens = [
            const HomeDummyScreen(),
            const CategoriesScreen(),
            const BrandsScreen(),
            const Center(child: Text("Profile")),
          ];

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
            body: screens[cubit.currentIndex],

            bottomNavigationBar: CustomBottomNavBar(
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changeIndex(index);
              },
            ),
          );
        },
      ),
    );
  }
}
