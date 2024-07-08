import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String name;
  final String email;
  final String? profilePictureUrl; // Optional

  const User({
    required this.id,
    required this.name,
    required this.email,
    this.profilePictureUrl,
  });

  @override
  List<Object?> get props => [id, name, email, profilePictureUrl];
}
