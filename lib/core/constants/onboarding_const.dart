import 'package:flutter/material.dart';
import 'package:store/core/constants/images.dart';
import 'package:store/features/data/models/onboarding_model.dart';

List<AppModel> myList = [
  AppModel(
    title: "Welcome to ZENEX",
    body:
        "Discover a world of endless \npossibilities with our curated \ncollections and seamless shopping \nexperience.",
    image: Image.asset(AppImages.onBoardingImageOne),
  ),
  AppModel(
    title: "Easy to Buy",
    body:
        "Find the perfect item that suits your \nstyle and complete your collection with \njust a few intuitive taps.",
    image: Image.asset(AppImages.onBoardingImageTwo),
  ),
  AppModel(
    title: "Wonderful User Experience",
    body:
        "Start exploring now and experience the \npeak of curated digital commerce, \ndesigned for your lifestyle.",
    image: Image.asset(AppImages.onBoardingImageThree),
  ),
];
