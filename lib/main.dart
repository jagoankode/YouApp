import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'routes/app_routes.dart';
import 'controllers/auth_controller.dart';
import 'widgets/custom_widgets.dart';

void main() {
  Get.put(AuthController()); // init controller
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'YouApp',
      theme: AppTheme.getTheme(),
      initialRoute: AppRoutes.about,
      getPages: AppRoutes.pages,
      debugShowCheckedModeBanner: false,
    );
  }
}
