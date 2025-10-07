import 'package:get/get.dart';
import '../models/user_model.dart';
import '../routes/app_routes.dart';

class AuthController extends GetxController {
  var users = <UserModel>[].obs;
  var currentUser = Rxn<UserModel>();

  void register(String email, String password) {
    if (users.any((u) => u.email == email)) {
      Get.snackbar('Error', 'Email already registered');
      return;
    }
    users.add(UserModel(email: email, password: password));
    Get.snackbar('Success', 'Account created!');
    Get.offAllNamed(AppRoutes.login);
  }

  void login(String email, String password) {
    final user = users.firstWhereOrNull(
          (u) => u.email == email && u.password == password,
    );

    if (user == null) {
      Get.snackbar('Error', 'Invalid credentials');
    } else {
      currentUser.value = user;
      Get.offAllNamed(AppRoutes.interest);
    }
  }

  void logout() {
    currentUser.value = null;
    Get.offAllNamed(AppRoutes.login);
  }
}
