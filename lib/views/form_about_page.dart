import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/profile_controller.dart';
import '../controllers/auth_controller.dart';
import '../utils/zodiac_utils.dart';
import '../widgets/custom_widgets.dart';

class FormAboutPage extends StatelessWidget {
  const FormAboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final profileController = Get.find<ProfileController>();
    final authController = Get.find<AuthController>();
    
    // Initialize text controllers with existing profile data
    final displayNameC = TextEditingController(text: authController.currentProfile.value?.displayName ?? '');
    final birthdayC = TextEditingController(text: authController.currentProfile.value?.birthday ?? '');
    final heightC = TextEditingController(text: authController.currentProfile.value?.height?.toString() ?? '');
    final weightC = TextEditingController(text: authController.currentProfile.value?.weight?.toString() ?? '');
    
    // Gender selection
    final genderC = TextEditingController();
    final List<String> genderOptions = ['Male', 'Female', 'Other'];
    String? selectedGender = authController.currentProfile.value?.displayName != null 
        ? (authController.currentProfile.value?.displayName?.contains('Male') == true 
            ? 'Male' 
            : (authController.currentProfile.value?.displayName?.contains('Female') == true ? 'Female' : 'Other')) 
        : null;
    
    // Zodiac selection
    final zodiacC = TextEditingController(text: authController.currentProfile.value?.zodiac ?? '');
    final List<String> zodiacOptions = [
      'aries', 'taurus', 'gemini', 'cancer', 'leo', 'virgo', 
      'libra', 'scorpio', 'sagittarius', 'capricorn', 'aquarius', 'pisces'
    ];
    
    // Horoscope will be calculated based on birthday
    String? horoscopeValue = authController.currentProfile.value?.horoscope ?? 
                             (birthdayC.text.isNotEmpty ? ZodiacUtils.getHoroscope(birthdayC.text) : null);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Profile'),
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
                // Display Name
                CustomTextFieldNoBorder(
                  label: 'Display Name',
                  controller: displayNameC,
                ),
                const SizedBox(height: 16),
                
                // Gender
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white.withOpacity(0.22), // Input background as per spec
                  ),
                  child: Obx(() => DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      isExpanded: true,
                      hint: const Text(
                        'Select Gender',
                        style: TextStyle(color: Colors.white38),
                      ),
                      value: selectedGender,
                      onChanged: (String? value) {
                        selectedGender = value;
                        genderC.text = value ?? '';
                      },
                      items: genderOptions.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: const TextStyle(color: Colors.white),
                          ),
                        );
                      }).toList(),
                    ),
                  )),
                ),
                const SizedBox(height: 16),
                
                // Birthday
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white.withOpacity(0.22), // Input background as per spec
                  ),
                  child: TextField(
                    controller: birthdayC,
                    readOnly: true,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      labelText: 'Birthday',
                      labelStyle: TextStyle(
                        color: Colors.white38, // Label color as per spec (33% opacity)
                      ),
                      border: InputBorder.none,
                      suffixIcon: Icon(
                        Icons.calendar_today,
                        color: Colors.white38,
                      ),
                    ),
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now(),
                        builder: (context, child) {
                          return Theme(
                            data: Theme.of(context).copyWith(
                              colorScheme: const ColorScheme.light(
                                primary: Color(0xFF62CDCB), // Primary color for date picker
                              ),
                            ),
                            child: child!,
                          );
                        },
                      );
                      if (pickedDate != null) {
                        String formattedDate = "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
                        birthdayC.text = formattedDate;
                        
                        // Calculate horoscope and zodiac based on the selected date
                        horoscopeValue = ZodiacUtils.getHoroscope(formattedDate);
                        zodiacC.text = ZodiacUtils.getZodiacSign(formattedDate);
                      }
                    },
                  ),
                ),
                const SizedBox(height: 16),
                
                // Horoscope (read-only, calculated from birthday)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white.withOpacity(0.22), // Input background as per spec
                  ),
                  child: TextField(
                    readOnly: true,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      labelText: 'Horoscope',
                      labelStyle: const TextStyle(
                        color: Colors.white38, // Label color as per spec (33% opacity)
                      ),
                      border: InputBorder.none,
                      hintText: horoscopeValue ?? 'Will be calculated from birthday',
                      hintStyle: TextStyle(
                        color: horoscopeValue != null ? Colors.white : Colors.white38,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                
                // Zodiac with autocomplete
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
                      return zodiacOptions.where((String option) {
                        return option.toLowerCase().contains(
                              textEditingValue.text.toLowerCase());
                      });
                    },
                    onSelected: (String selection) {
                      zodiacC.text = selection;
                    },
                    fieldViewBuilder: (context, textEditingController, focusNode, onFieldSubmitted) {
                      return TextField(
                        controller: textEditingController,
                        focusNode: focusNode,
                        onEditingComplete: onFieldSubmitted,
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          labelText: 'Zodiac',
                          labelStyle: TextStyle(
                            color: Colors.white38, // Label color as per spec (33% opacity)
                          ),
                          border: InputBorder.none,
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 16),
                
                // Height
                CustomTextFieldNoBorder(
                  label: 'Height (cm)',
                  controller: heightC,
                  hintText: 'Enter height in cm',
                ),
                const SizedBox(height: 16),
                
                // Weight
                CustomTextFieldNoBorder(
                  label: 'Weight (kg)',
                  controller: weightC,
                  hintText: 'Enter weight in kg',
                ),
                const SizedBox(height: 32),
                
                // Update Button
                Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    gradient: const LinearGradient(
                      colors: [Color(0xFF62CDCB), Color(0xFF4599DB)], // Button gradient as per spec
                    ),
                  ),
                  child: 
                    ElevatedButton(
                      onPressed: profileController.isLoading.value 
                          ? null 
                          : () {
                              profileController.updateProfile(
                                displayName: displayNameC.text,
                                birthday: birthdayC.text,
                                horoscope: horoscopeValue,
                                zodiac: zodiacC.text,
                                height: int.tryParse(heightC.text),
                                weight: int.tryParse(weightC.text),
                              );
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Obx(() => 
                        profileController.isLoading.value
                            ? const CircularProgressIndicator(color: Colors.white)
                            : const Text(
                                'Update Profile',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
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