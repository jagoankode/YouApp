import 'package:flutter/material.dart';

// Custom text input widget matching the design specs
class CustomTextInput extends StatelessWidget {
  final String label;
  final TextEditingController? controller;
  final bool isPassword;
  final bool readOnly;
  final VoidCallback? onTap;
  final String? hintText;

  const CustomTextInput({
    Key? key,
    required this.label,
    this.controller,
    this.isPassword = false,
    this.readOnly = false,
    this.onTap,
    this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white.withOpacity(0.22), // Input background as per spec
      ),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        readOnly: readOnly,
        onTap: onTap,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(
            color: Colors.white38, // Label color as per spec (33% opacity)
          ),
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.white38),
          border: InputBorder.none,
        ),
      ),
    );
  }
}

// Custom text field without any border, only background color
class CustomTextFieldNoBorder extends StatelessWidget {
  final String label;
  final TextEditingController? controller;
  final bool isPassword;
  final bool readOnly;
  final VoidCallback? onTap;
  final String? hintText;

  const CustomTextFieldNoBorder({
    Key? key,
    required this.label,
    this.controller,
    this.isPassword = false,
    this.readOnly = false,
    this.onTap,
    this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white.withOpacity(0.22), // Input background as per spec
      ),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        readOnly: readOnly,
        onTap: onTap,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(
            color: Colors.white38, // Label color as per spec (33% opacity)
          ),
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.white38),
          border: InputBorder.none, // No border
          enabledBorder: InputBorder.none, // No border when enabled
          focusedBorder: InputBorder.none, // No border when focused
          disabledBorder: InputBorder.none, // No border when disabled
          contentPadding: EdgeInsets.zero, // Remove internal padding
        ),
      ),
    );
  }
}

// Custom button widget matching the design specs
class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;

  const CustomButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: const LinearGradient(
          colors: [Color(0xFF62CDCB), Color(0xFF4599DB)], // Button gradient as per spec
        ),
      ),
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: isLoading
            ? const CircularProgressIndicator(color: Colors.white)
            : Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
      ),
    );
  }
}

// Custom card widget for the design
class CustomCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final Color color;

  const CustomCard({
    Key? key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.color = const Color(0xFF1F4247), // secondary color
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: padding,
        child: child,
      ),
    );
  }
}

// App theme definition
class AppTheme {
  static ThemeData getTheme() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: const ColorScheme.dark(
        primary: Color(0xFF09141A), // primary color
        secondary: Color(0xFF1F4247), // secondary color
        tertiary: Color(0xFF62CDCB), // accent color
      ).copyWith(
        surface: const Color(0xFF09141A),
        background: const Color(0xFF09141A),
      ),
      scaffoldBackgroundColor: const Color(0xFF09141A),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: const TextStyle(color: Colors.white38),
        labelStyle: const TextStyle(color: Colors.white38),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFF62CDCB)),
          borderRadius: BorderRadius.circular(12),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white.withOpacity(0.22)),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}