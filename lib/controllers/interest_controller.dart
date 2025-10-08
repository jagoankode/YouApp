import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import '../models/user_model.dart';

class InterestController extends GetxController {
  final authController = Get.find<AuthController>();

  void saveInterest(String interest) {
    final user = authController.currentUser.value;
    if (user != null) {
      final updated = UserModel(
        email: user.email,
        username: user.username,
        password: user.password,
        accessToken: user.accessToken,
        refreshToken: user.refreshToken,
        tokenType: user.tokenType,
        expiresIn: user.expiresIn,
        interest: interest,
      );
      authController.currentUser.value = updated;
      Get.snackbar('Success', 'Interest saved!');
      Get.back(); // Go back to the previous screen
    }
  }
}
