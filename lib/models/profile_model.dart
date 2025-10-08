class ProfileModel {
  final String? displayName;
  final String? birthday;
  final String? horoscope;
  final String? zodiac;
  final int? height;
  final int? weight;
  final String? userId;

  const ProfileModel({
    this.displayName,
    this.birthday,
    this.horoscope,
    this.zodiac,
    this.height,
    this.weight,
    this.userId,
  });

  // Factory constructor to create a ProfileModel from a JSON object
  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      displayName: json['display_name'] ?? json['displayName'],
      birthday: json['birthday'],
      horoscope: json['horoscope'],
      zodiac: json['zodiac'],
      height: json['height'],
      weight: json['weight'],
      userId: json['id_user'] ?? json['userId'],
    );
  }

  // Method to convert the ProfileModel to a JSON object
  Map<String, dynamic> toJson() {
    return {
      'display_name': displayName,
      'birthday': birthday,
      'horoscope': horoscope,
      'zodiac': zodiac,
      'height': height,
      'weight': weight,
      'id_user': userId,
    };
  }
}