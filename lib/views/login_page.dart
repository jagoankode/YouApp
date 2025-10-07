import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import '../routes/app_routes.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final emailC = TextEditingController();
    final passC = TextEditingController();
    final authC = Get.find<AuthController>();

    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(controller: emailC, decoration: const InputDecoration(labelText: 'Email')),
            const SizedBox(height: 12),
            TextField(controller: passC, decoration: const InputDecoration(labelText: 'Password'), obscureText: true),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => authC.login(emailC.text, passC.text),
              child: const Text('Login'),
            ),
            TextButton(
              onPressed: () => Get.toNamed(AppRoutes.register),
              child: const Text('Register here'),
            ),
            TextButton(
              onPressed: () => Get.toNamed(AppRoutes.about),
              child: const Text('About App'),
            ),
          ],
        ),
      ),
    );
  }
}
