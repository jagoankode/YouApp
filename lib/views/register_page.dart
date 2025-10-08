import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import '../routes/app_routes.dart';
import '../widgets/custom_widgets.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final emailC = TextEditingController();
    final usernameC = TextEditingController();
    final passC = TextEditingController();
    final confirmPassC = TextEditingController();
    final authC = Get.find<AuthController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Account'),
        backgroundColor: const Color(0xFF09141A), // primary color
        foregroundColor: Colors.white,
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
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Create Your Account',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 48),
                CustomTextFieldNoBorder(
                  label: 'Email',
                  controller: emailC,
                ),
                const SizedBox(height: 16),
                CustomTextFieldNoBorder(
                  label: 'Username',
                  controller: usernameC,
                ),
                const SizedBox(height: 16),
                CustomTextFieldNoBorder(
                  label: 'Password',
                  controller: passC,
                  isPassword: true,
                ),
                const SizedBox(height: 16),
                CustomTextFieldNoBorder(
                  label: 'Confirm Password',
                  controller: confirmPassC,
                  isPassword: true,
                ),
                const SizedBox(height: 32),
                Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    gradient: const LinearGradient(
                      colors: [Color(0xFF62CDCB), Color(0xFF4599DB)], // Button gradient as per spec
                    ),
                  ),
                  child: Obx(() => 
                    ElevatedButton(
                      onPressed: authC.isAuth.value 
                          ? null 
                          : () {
                              if (passC.text != confirmPassC.text) {
                                Get.snackbar('Error', 'Passwords do not match');
                                return;
                              }
                              authC.register(emailC.text, usernameC.text, passC.text);
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: authC.isAuth.value
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text(
                              'Register',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                TextButton(
                  onPressed: () => Get.toNamed(AppRoutes.login),
                  child: const Text(
                    'Already have an account? Sign In',
                    style: TextStyle(
                      color: Colors.white,
                      decoration: TextDecoration.underline,
                    ),
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
