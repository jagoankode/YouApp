import 'package:get/get.dart';
import '../models/user_model.dart';
import '../models/profile_model.dart';
import '../routes/app_routes.dart';
import '../services/api_service.dart';
import '../models/login_response_model.dart';

class AuthController extends GetxController {
  var currentUser = Rxn<UserModel>();
  var currentProfile = Rxn<ProfileModel>();
  var isAuth = false.obs;

  // Register a new user
  Future<void> register(String email, String username, String password) async {
    try {
      LoginResponseModel response = await ApiService.register(email, username, password);
      
      if (!response.isError) {
        Get.snackbar('Success', response.message);
        Get.offAllNamed(AppRoutes.login);
      } else {
        Get.snackbar('Error', response.message);
      }
    } catch (e) {
      Get.snackbar('Error', 'Registration failed: ${e.toString()}');
    }
  }

  // Login user
  Future<void> login(String identifier, String password) async {
    try {
      LoginResponseModel response = await ApiService.login(identifier, password);
      
      if (!response.isError && response.data != null) {
        // Store user information
        UserModel user = UserModel(
          email: identifier,
          username: identifier, // This will be updated after getting user details
          password: password,
          accessToken: response.data!.tokens!.accessToken,
          refreshToken: response.data!.tokens!.refreshToken,
          tokenType: response.data!.tokens!.tokenType,
          expiresIn: response.data!.tokens!.expiresIn,
        );
        
        currentUser.value = user;
        currentProfile.value = response.data!.user;
        isAuth.value = true;
        
        Get.snackbar('Success', response.message);
        Get.offAllNamed(AppRoutes.about);
      } else {
        Get.snackbar('Error', response.message);
      }
    } catch (e) {
      Get.snackbar('Error', 'Login failed: ${e.toString()}');
    }
  }

  // Logout user
  Future<void> logout() async {
    try {
      await ApiService.removeToken();
      currentUser.value = null;
      currentProfile.value = null;
      isAuth.value = false;
      Get.offAllNamed(AppRoutes.login);
    } catch (e) {
      Get.snackbar('Error', 'Logout failed: ${e.toString()}');
    }
  }
}
