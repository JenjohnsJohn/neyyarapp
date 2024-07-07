import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../../domain/repositories/authentication_repository.dart';

class Logout {
  final AuthenticationRepository repository;

  Logout(this.repository);

  Future<Either<Failure, void>> call() async {
    return await repository.logout();
  }
}
