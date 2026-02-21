import 'package:get/get.dart';
import 'package:movieapps/app/modules/splash/initial_view.dart';
import '../modules/splash/splash_binding.dart';
import '../modules/splash/splash_view.dart';
import '../modules/onboarding/onboarding_binding.dart';
import '../modules/onboarding/onboarding_view.dart';
import 'app_routes.dart';
import '../modules/auth/sign_in_view.dart';
import '../modules/auth/auth_binding.dart';
import '../modules/auth/sign_up_view.dart';
import '../modules/home/home_view.dart';
import '../modules/home/home_binding.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: Routes.splash,
      page: () => const SplashView(),
      binding: SplashBinding(),
      transition: Transition.fadeIn,
    ),

    GetPage(
      name: Routes.onboarding,
      page: () => const OnboardingView(),
      binding: OnboardingBinding(),
    ),
    GetPage(
      name: Routes.signIn,
      page: () => SignInView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: Routes.signUp,
      page: () => SignUpView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: Routes.home,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(name: Routes.initial, page: () => const InitialView()),
  ];
}
