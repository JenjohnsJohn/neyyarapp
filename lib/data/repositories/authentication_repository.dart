import 'package:dartz/dartz.dart';
import 'package:neyyarapp/domain/entities/user.dart';
import '../../core/error/failures.dart';

abstract class AuthenticationRepository {
  Future<Either<Failure, User>> login(String email, String password);
  Future<Either<Failure, User>> signUp(
      String email, String password, String name);
  Future<Either<Failure, void>> logout();
  Future<Either<Failure, User>> checkAuthenticationStatus();
}
