import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/login_response_model.dart';
import '../models/profile_model.dart';

class ApiService {
  static const String baseUrl = 'https://your-api-base-url.com/api'; // Replace with your actual API URL
  static const String registerEndpoint = '$baseUrl/register';
  static const String loginEndpoint = '$baseUrl/login';
  static const String createProfileEndpoint = '$baseUrl/createProfile';
  static const String getProfileEndpoint = '$baseUrl/getProfile';
  static const String updateProfileEndpoint = '$baseUrl/updateProfile';
  static const String viewMessagesEndpoint = '$baseUrl/viewMessages';
  static const String sendMessageEndpoint = '$baseUrl/sendMessage';

  // Store the access token in shared preferences
  static Future<void> saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('access_token', token);
  }

  // Get the access token from shared preferences
  static Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('access_token');
  }

  // Remove the access token from shared preferences
  static Future<void> removeToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('access_token');
  }

  // Register a new user
  static Future<LoginResponseModel> register(String email, String username, String password) async {
    final response = await http.post(
      Uri.parse(registerEndpoint),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      return LoginResponseModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to register user');
    }
  }

  // Login user
  static Future<LoginResponseModel> login(String identifier, String password) async {
    final response = await http.post(
      Uri.parse(loginEndpoint),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'identifier': identifier,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final result = LoginResponseModel.fromJson(jsonDecode(response.body));
      
      // Save the access token if login is successful
      if (result.data?.tokens?.accessToken != null) {
        await saveToken(result.data!.tokens!.accessToken);
      }
      
      return result;
    } else {
      throw Exception('Failed to login user');
    }
  }

  // Create user profile
  static Future<LoginResponseModel> createProfile(
    String userId,
    String displayName,
    String birthday,
    String horoscope,
    String zodiac,
    int height,
    int weight,
  ) async {
    final token = await getToken();
    
    final response = await http.post(
      Uri.parse(createProfileEndpoint),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(<String, dynamic>{
        'id_user': userId,
        'display_name': displayName,
        'birthday': birthday,
        'horoscope': horoscope,
        'zodiac': zodiac,
        'height': height,
        'weight': weight,
      }),
    );

    if (response.statusCode == 200) {
      return LoginResponseModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create profile');
    }
  }

  // Get user profile
  static Future<ProfileModel> getProfile(String userId) async {
    final token = await getToken();
    
    final response = await http.get(
      Uri.parse('$getProfileEndpoint?id_user=$userId'),
      headers: <String, String>{
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['is_error'] == false && data['data'] != null) {
        return ProfileModel.fromJson(data['data']);
      } else {
        throw Exception(data['message'] ?? 'Failed to get profile');
      }
    } else {
      throw Exception('Failed to get profile');
    }
  }

  // Update user profile
  static Future<LoginResponseModel> updateProfile(
    String displayName,
    String birthday,
    String horoscope,
    String zodiac,
    int height,
    int weight,
  ) async {
    final token = await getToken();
    
    final response = await http.put(
      Uri.parse(updateProfileEndpoint),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(<String, dynamic>{
        'display_name': displayName,
        'birthday': birthday,
        'horoscope': horoscope,
        'zodiac': zodiac,
        'height': height,
        'weight': weight,
      }),
    );

    if (response.statusCode == 200) {
      return LoginResponseModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update profile');
    }
  }

  // Get messages for a user
  static Future<dynamic> viewMessages(String receiverId) async {
    final token = await getToken();
    
    final response = await http.get(
      Uri.parse('$viewMessagesEndpoint?receiver_id=$receiverId'),
      headers: <String, String>{
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to get messages');
    }
  }

  // Send a message to a user
  static Future<dynamic> sendMessage(String receiverId, String message) async {
    final token = await getToken();
    
    final response = await http.post(
      Uri.parse(sendMessageEndpoint),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(<String, String>{
        'receiver_id': receiverId,
        'message': message,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to send message');
    }
  }
}