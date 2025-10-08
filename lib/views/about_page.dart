import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import '../controllers/profile_controller.dart';
import '../routes/app_routes.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    final profileController = Get.put(ProfileController());
    
    // Get profile data when the page is loaded
    profileController.getProfile();

    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
        backgroundColor: const Color(0xFF09141A), // primary color
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => authController.logout(),
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF09141A), Color(0xFF1F4247)], // primary to secondary
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Profile Image
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFF62CDCB), // Using the gradient color
                      width: 3,
                    ),
                  ),
                  child: ClipOval(
                    child: Container(
                      color: Colors.grey[300],
                      child: const Icon(
                        Icons.person,
                        size: 60,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Display Name - Wrapped only the Text widget that needs updating
                Builder(
                  builder: (context) {
                    return Obx(() => Text(
                      authController.currentProfile.value?.displayName ?? 
                      authController.currentUser.value?.username ?? 
                      'Guest User',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ));
                  }
                ),
                const SizedBox(height: 32),
                // About Card - Clickable
                Card(
                  color: const Color(0xFF1F4247), // secondary color
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: const Icon(
                      Icons.info,
                      color: Color(0xFF62CDCB),
                    ),
                    title: const Text(
                      'About',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: Colors.white70,
                    ),
                    onTap: () => Get.toNamed(AppRoutes.formAbout),
                  ),
                ),
                const SizedBox(height: 16),
                // Interest Card - Clickable
                Card(
                  color: const Color(0xFF1F4247), // secondary color
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: const Icon(
                      Icons.favorite,
                      color: Color(0xFF62CDCB),
                    ),
                    title: const Text(
                      'Interest',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: Colors.white70,
                    ),
                    onTap: () => Get.toNamed(AppRoutes.interest),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}