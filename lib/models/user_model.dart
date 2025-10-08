class UserModel {
  final String email;
  final String username;
  final String password;
  final String? accessToken;
  final String? refreshToken;
  final String? tokenType;
  final int? expiresIn;
  final String? interest;

  const UserModel({
    required this.email,
    required this.username,
    required this.password,
    this.accessToken,
    this.refreshToken,
    this.tokenType,
    this.expiresIn,
    this.interest,
  });
}