import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../../domain/entities/user.dart';

abstract class AuthenticationRepository {
  // Login
  Future<Either<Failure, User>> login(String email, String password);

  // Signup
  Future<Either<Failure, User>> signUp(
      String email, String password, String name);

  // Logout
  Future<Either<Failure, void>> logout();

  // Check Authentication Status (Optional)
  Future<Either<Failure, User>> checkAuthenticationStatus();
}
