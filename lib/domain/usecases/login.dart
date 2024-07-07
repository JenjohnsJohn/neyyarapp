import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/authentication_repository.dart';

class Login {
  final AuthenticationRepository repository;

  Login(this.repository);

  Future<Either<Failure, User>> call(String email, String password) async {
    // Input validation (optional but recommended)
    if (email.isEmpty || password.isEmpty) {
      return Left(InvalidInputFailure());
    }

    return await repository.login(email, password);
  }
}
