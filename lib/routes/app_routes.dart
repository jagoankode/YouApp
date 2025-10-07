import 'package:get/get.dart';
import '../views/login_page.dart';
import '../views/register_page.dart';
import '../views/interest_page.dart';
import '../views/about_page.dart';

class AppRoutes {
  static const login = '/login';
  static const register = '/register';
  static const interest = '/interest';
  static const about = '/about';

  static final pages = [
    GetPage(name: login, page: () => const LoginPage()),
    GetPage(name: register, page: () => const RegisterPage()),
    GetPage(name: interest, page: () => const InterestPage()),
    GetPage(name: about, page: () => const AboutPage()),
  ];
}
