import 'package:get/get.dart';

import '../modules/about_screen/bindings/about_screen_binding.dart';
import '../modules/about_screen/views/about_screen_view.dart';
import '../modules/edit_screen/bindings/edit_screen_binding.dart';
import '../modules/edit_screen/views/edit_screen_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/splash_screen/bindings/splash_screen_binding.dart';
import '../modules/splash_screen/views/splash_screen_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH_SCREEN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH_SCREEN,
      page: () => const SplashScreenView(),
      binding: SplashScreenBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_SCREEN,
      page: () => const EditScreenView(),
      binding: EditScreenBinding(),
    ),
    GetPage(
      name: _Paths.ABOUT_SCREEN,
      page: () => const AboutScreenView(),
      binding: AboutScreenBinding(),
    ),
  ];
}
