import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String name;
  final String email;
  final String? profilePictureUrl; // Optional

  // You can add more properties as needed (e.g., bio, enrolledCourses, completedCourses, etc.)

  const User({
    required this.id,
    required this.name,
    required this.email,
    this.profilePictureUrl,
  });

  @override
  List<Object?> get props => [id, name, email, profilePictureUrl];
}
