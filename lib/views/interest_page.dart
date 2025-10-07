import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/interest_controller.dart';
import '../controllers/auth_controller.dart';
import '../routes/app_routes.dart';

class InterestPage extends StatelessWidget {
  const InterestPage({super.key});

  @override
  Widget build(BuildContext context) {
    final interestC = TextEditingController();
    final interestController = Get.put(InterestController());
    final authC = Get.find<AuthController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Interest'),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () => Get.toNamed(AppRoutes.about),
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: authC.logout,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: interestC, decoration: const InputDecoration(labelText: 'Enter your interest')),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => interestController.saveInterest(interestC.text),
              child: const Text('Save Interest'),
            ),
            const SizedBox(height: 20),
            Obx(() {
              final user = authC.currentUser.value;
              return Text(
                user?.interest == null
                    ? 'No interest saved yet.'
                    : 'Your interest: ${user!.interest}',
                style: const TextStyle(fontSize: 16),
              );
            }),
          ],
        ),
      ),
    );
  }
}
