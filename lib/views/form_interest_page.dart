import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/interest_controller.dart';
import '../controllers/auth_controller.dart';

class FormInterestPage extends StatelessWidget {
  const FormInterestPage({super.key});

  @override
  Widget build(BuildContext context) {
    final interestController = Get.find<InterestController>();
    final authController = Get.find<AuthController>();
    
    final interestC = TextEditingController(text: authController.currentUser.value?.interest ?? '');
    
    // Sample interest suggestions
    final List<String> interestSuggestions = [
      'Technology', 'Sports', 'Music', 'Travel', 'Photography', 
      'Cooking', 'Reading', 'Gaming', 'Art', 'Science',
      'Nature', 'Fitness', 'Movies', 'Fashion', 'Animals',
      'Dancing', 'Writing', 'History', 'Politics', 'Business'
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Interest'),
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
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const Text(
                  'What are your interests?',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 32),
                
                // Interest input with autocomplete
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white.withOpacity(0.22), // Input background as per spec
                  ),
                  child: Autocomplete<String>(
                    optionsBuilder: (TextEditingValue textEditingValue) {
                      if (textEditingValue.text.isEmpty) {
                        return const Iterable<String>.empty();
                      }
                      return interestSuggestions.where((String option) {
                        return option.toLowerCase().contains(
                              textEditingValue.text.toLowerCase());
                      });
                    },
                    onSelected: (String selection) {
                      interestC.text = selection;
                    },
                    fieldViewBuilder: (context, textEditingController, focusNode, onFieldSubmitted) {
                      return TextField(
                        controller: textEditingController,
                        focusNode: focusNode,
                        onEditingComplete: onFieldSubmitted,
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          labelText: 'Interest',
                          labelStyle: TextStyle(
                            color: Colors.white38, // Label color as per spec (33% opacity)
                          ),
                          border: InputBorder.none,
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 32),
                
                // Save Button
                Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    gradient: const LinearGradient(
                      colors: [Color(0xFF62CDCB), Color(0xFF4599DB)], // Button gradient as per spec
                    ),
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      interestController.saveInterest(interestC.text);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Save Interest',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
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