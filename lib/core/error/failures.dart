import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message; // Optional error message

  const Failure({this.message = ''});

  @override
  List<Object> get props => [message];
}

// General failures
class ServerFailure extends Failure {
  const ServerFailure({String message = 'Server Failure'})
      : super(message: message);
}

class CacheFailure extends Failure {
  const CacheFailure({String message = 'Cache Failure'})
      : super(message: message);
}

class NetworkFailure extends Failure {
  const NetworkFailure({String message = 'No Internet Connection'})
      : super(message: message);
}

// Authentication-specific failures
class AuthenticationFailure extends Failure {
  const AuthenticationFailure({String message = 'Authentication Failed'})
      : super(message: message);
}

class InvalidCredentialsFailure extends Failure {
  const InvalidCredentialsFailure(
      {String message = 'Invalid Email or Password'})
      : super(message: message);
}

// Course-specific failures
class CourseNotFoundFailure extends Failure {
  const CourseNotFoundFailure({String message = 'Course not found'})
      : super(message: message);
}

class EnrollmentFailure extends Failure {
  const EnrollmentFailure({String message = 'Enrollment Failed'})
      : super(message: message);
}

// Category-specific failures
class CategoryNotFoundFailure extends Failure {
  const CategoryNotFoundFailure({String message = 'Category not found'})
      : super(message: message);
}

// ... Add more specific failure types as needed
