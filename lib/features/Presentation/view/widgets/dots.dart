import 'package:flutter/material.dart';
import 'package:store/core/constants/color.dart';
import 'package:store/core/constants/onboarding_const.dart';

class Dots extends StatelessWidget {
  final int currentIndex;

  const Dots({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        myList.length,
        (index) => AnimatedContainer(
          margin: const EdgeInsets.only(right: 8),
          duration: const Duration(milliseconds: 500),
          width: currentIndex == index ? 30 : 7,
          height: 6,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
