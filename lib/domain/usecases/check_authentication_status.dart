import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/authentication_repository.dart';

class CheckAuthenticationStatus {
  final AuthenticationRepository repository;

  CheckAuthenticationStatus(this.repository);

  Future<Either<Failure, User>> call() async {
    return await repository.checkAuthenticationStatus();
  }
}
