import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:store/core/constants/routes.dart';
import 'package:store/core/stripe/stripe_keys.dart';
import 'package:store/features/Presentation/viewModel/cache/cache_helper.dart';
import 'package:store/core/constants/theme.dart';
import 'package:store/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper().init();
  Stripe.publishableKey = StripeKeys.publishableKey;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ZENEX Store',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: AppRouter.generateRoute,
      initialRoute: AppRoute.splashScreen,
    );
  }
}
