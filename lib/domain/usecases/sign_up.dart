import 'package:dartz/dartz.dart';
import 'package:neyyarapp/core/error/failures.dart';
import 'package:neyyarapp/data/repositories/authentication_repository.dart';
import 'package:neyyarapp/domain/entities/user.dart';

class SignUp {
  final AuthenticationRepository repository;

  SignUp(this.repository);

  Future<Either<Failure, User>> call(
      String email, String password, String name) async {
    // Optional input validation (e.g., check for valid email format, password strength, etc.)
    // if (!EmailValidator.validate(email)) {
    //   return Left(InvalidEmailFailure());
    // }
    // ... other validation logic
    return await repository.signUp(email, password, name);
  }
}
