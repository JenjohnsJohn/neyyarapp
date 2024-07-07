import 'package:neyyarapp/domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required super.id,
    required super.name,
    required super.email,
    super.profilePictureUrl,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      profilePictureUrl: json[
          'profile_picture_url'], // Adjust if your API uses a different key
      // ... map other properties as needed
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'profile_picture_url': profilePictureUrl,
      // ... map other properties as needed
    };
  }
}
