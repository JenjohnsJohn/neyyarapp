import 'package:dartz/dartz.dart';
import '../../core/error/exceptions.dart';
import '../../core/error/failures.dart';
import '../../core/network/network_info.dart';
import '../../data/datasources/authentication_remote_data_source.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/authentication_repository.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final NetworkInfo networkInfo;
  final AuthenticationRemoteDataSource authenticationRemoteDataSource;

  AuthenticationRepositoryImpl({
    required this.networkInfo,
    required this.authenticationRemoteDataSource,
  });

  @override
  Future<Either<Failure, User>> login(String email, String password) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteUser =
            await authenticationRemoteDataSource.login(email, password);
        return Right(remoteUser);
      } on ServerException {
        return Left(ServerFailure());
      } on AuthenticationException {
        return Left(InvalidCredentialsFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, User>> signUp(
      String email, String password, String name) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteUser =
            await authenticationRemoteDataSource.signUp(email, password, name);
        return Right(remoteUser);
      } on ServerException {
        return Left(ServerFailure());
      } on EmailAlreadyInUseException {
        return Left(EmailAlreadyInUseFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, User>> checkAuthenticationStatus() {
    // TODO: implement checkAuthenticationStatus
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }

// ... (implement other methods like logout, checkAuthenticationStatus)
}
