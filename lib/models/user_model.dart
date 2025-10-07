class UserModel {
  final String email;
  final String password;
  final String? interest;

  UserModel({
    required this.email,
    required this.password,
    this.interest,
  });
}