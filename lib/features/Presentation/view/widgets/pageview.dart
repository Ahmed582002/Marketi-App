import 'package:flutter/material.dart';
import 'package:store/core/constants/onboarding_const.dart';

class MyPageView extends StatelessWidget {
  final PageController controller;
  final Function(int) onPageChanged;

  const MyPageView({
    super.key,
    required this.controller,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: controller,
      onPageChanged: onPageChanged,
      itemCount: myList.length,
      itemBuilder: (context, index) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(flex: 12, child: Center(child: myList[index].image!)),
          Expanded(
            flex: 2,
            child: Text(
              myList[index].title!,
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.displayLarge!.copyWith(fontSize: 25),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            flex: 3,
            child: Text(
              myList[index].body!,
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.displaySmall!.copyWith(fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }
}
