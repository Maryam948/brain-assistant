class UserModel {
  final String name;
  final String email;
  final String password;
  final String? image;
  UserModel({
    required this.name,
    required this.email,
    required this.password,
    this.image,
  });
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      email: json['email'],
      password: json['password'],
      image:
          json['image'] ??
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR0_XPfyUZJugz5lXkm0DUtAkpjRw367tcFig&s',
    );
  }
  Map<String, dynamic> tojson() {
    return {'email': email, 'password': password, 'name': name, 'image': image};
  }
}
