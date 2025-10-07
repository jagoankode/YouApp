import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'routes/app_routes.dart';
import 'controllers/auth_controller.dart';

void main() {
  Get.put(AuthController()); // init controller
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Mock Auth App',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.deepPurple,
      ),
      initialRoute: AppRoutes.login,
      getPages: AppRoutes.pages,
      debugShowCheckedModeBanner: false,
    );
  }
}
