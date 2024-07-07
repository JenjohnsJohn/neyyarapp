import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import 'package:elearning_app/domain/entities/user.dart';

abstract class AuthenticationRepository {
  Future<Either<Failure, User>> login(String email, String password);
  Future<Either<Failure, User>> signUp(
      String email, String password, String name);
  Future<Either<Failure, void>> logout();
  Future<Either<Failure, User>>
      checkAuthenticationStatus(); // Optional (can be in a separate repository if you prefer)
}
