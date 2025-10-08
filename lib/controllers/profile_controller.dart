import 'package:get/get.dart';
import '../models/profile_model.dart';
import '../services/api_service.dart';
import '../controllers/auth_controller.dart';

class ProfileController extends GetxController {
  final authController = Get.find<AuthController>();
  var profile = Rxn<ProfileModel>();
  var isLoading = false.obs;

  // Get current user's profile
  Future<void> getProfile() async {
    if (authController.currentUser.value?.username == null) {
      Get.snackbar('Error', 'User not authenticated');
      return;
    }
    
    try {
      isLoading.value = true;
      // We can use the userId from the stored profile or get it differently
      // For now, using the stored profile data
      if (authController.currentProfile.value?.userId != null) {
        final profileData = await ApiService.getProfile(authController.currentProfile.value!.userId!);
        profile.value = profileData;
        authController.currentProfile.value = profileData;
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to get profile: ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }

  // Update profile
  Future<void> updateProfile({
    String? displayName,
    String? birthday,
    String? horoscope,
    String? zodiac,
    int? height,
    int? weight,
  }) async {
    if (authController.currentUser.value?.username == null) {
      Get.snackbar('Error', 'User not authenticated');
      return;
    }
    
    try {
      isLoading.value = true;
      
      final response = await ApiService.updateProfile(
        displayName ?? profile.value?.displayName ?? '',
        birthday ?? profile.value?.birthday ?? '',
        horoscope ?? profile.value?.horoscope ?? '',
        zodiac ?? profile.value?.zodiac ?? '',
        height ?? profile.value?.height ?? 0,
        weight ?? profile.value?.weight ?? 0,
      );
      
      if (!response.isError) {
        Get.snackbar('Success', response.message);
        // Update the local profile data
        profile.value = ProfileModel(
          displayName: displayName ?? profile.value?.displayName,
          birthday: birthday ?? profile.value?.birthday,
          horoscope: horoscope ?? profile.value?.horoscope,
          zodiac: zodiac ?? profile.value?.zodiac,
          height: height ?? profile.value?.height,
          weight: weight ?? profile.value?.weight,
          userId: profile.value?.userId,
        );
        authController.currentProfile.value = profile.value;
        Get.back(); // Go back to the previous screen
      } else {
        Get.snackbar('Error', response.message);
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to update profile: ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }

  // Create profile
  Future<void> createProfile({
    required String userId,
    required String displayName,
    required String birthday,
    required String horoscope,
    required String zodiac,
    required int height,
    required int weight,
  }) async {
    try {
      isLoading.value = true;
      
      final response = await ApiService.createProfile(
        userId,
        displayName,
        birthday,
        horoscope,
        zodiac,
        height,
        weight,
      );
      
      if (!response.isError) {
        Get.snackbar('Success', response.message);
        // Update the local profile data
        profile.value = ProfileModel(
          displayName: displayName,
          birthday: birthday,
          horoscope: horoscope,
          zodiac: zodiac,
          height: height,
          weight: weight,
          userId: userId,
        );
        authController.currentProfile.value = profile.value;
        Get.back(); // Go back to the previous screen
      } else {
        Get.snackbar('Error', response.message);
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to create profile: ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }
}