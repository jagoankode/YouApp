import 'token_model.dart';
import 'profile_model.dart';

class LoginResponseModel {
  final bool isError;
  final String message;
  final LoginData? data;

  LoginResponseModel({
    required this.isError,
    required this.message,
    this.data,
  });

  // Factory constructor to create a LoginResponseModel from a JSON object
  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      isError: json['is_error'] ?? json['isError'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null ? LoginData.fromJson(json['data']) : null,
    );
  }

  // Method to convert the LoginResponseModel to a JSON object
  Map<String, dynamic> toJson() {
    return {
      'is_error': isError,
      'message': message,
      'data': data?.toJson(),
    };
  }
}

class LoginData {
  final ProfileModel? user;
  final TokenModel? tokens;

  LoginData({
    this.user,
    this.tokens,
  });

  // Factory constructor to create a LoginData from a JSON object
  factory LoginData.fromJson(Map<String, dynamic> json) {
    return LoginData(
      user: json['user'] != null ? ProfileModel.fromJson(json['user']) : null,
      tokens: json['tokens'] != null ? TokenModel.fromJson(json['tokens']) : null,
    );
  }

  // Method to convert the LoginData to a JSON object
  Map<String, dynamic> toJson() {
    return {
      'user': user?.toJson(),
      'tokens': tokens?.toJson(),
    };
  }
}