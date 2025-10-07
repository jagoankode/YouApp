import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('About')),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            'Mock Flutter App\nBuilt with GetX & Material 3\n© 2025 Your Name',
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
