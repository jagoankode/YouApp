import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:you_app/views/login_page.dart';
import 'package:you_app/controllers/auth_controller.dart';

void main() {
  testWidgets('LoginPage UI Test', (WidgetTester tester) async {
    // Initialize the AuthController before testing
    Get.put(AuthController());
    
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      GetMaterialApp(
        home: LoginPage(),
      ),
    );

    // Verify that the login screen has the correct title (AppBar title specifically)
    expect(find.byType(AppBar), findsOneWidget);
    
    // Verify that the email and password text fields exist
    expect(find.byType(TextField), findsNWidgets(2));

    // Verify that the login button exists (we know there's a login button by text)
    expect(find.text('Login'), findsNWidgets(2)); // AppBar title + button text

    // Verify that the register link exists
    expect(find.text('Don\'t have an account? Sign Up'), findsOneWidget);
  });
}