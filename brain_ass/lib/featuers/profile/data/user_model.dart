import 'dart:developer';

class UserModel {
  final String name;
  final String email;
  final String? image;

  UserModel({
    required this.name,
    required this.email,
    this.image,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
  log("fromJson data: $json"); // ✅ مؤقتاً
  return UserModel(
    name: json['name']?.toString() ?? '',
    email: json['email']?.toString() ?? '',
    image: json['image']?.toString(),
  );
}
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'image': image,
    };
  }
}