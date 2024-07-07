import 'package:dartz/dartz.dart';
import 'package:neyyarapp/core/error/exceptions.dart';
import 'package:neyyarapp/core/error/failures.dart';
import 'package:neyyarapp/core/network/network_info.dart';
import 'package:neyyarapp/data/datasources/category_local_data_source.dart';
import 'package:neyyarapp/data/datasources/category_remote_data_source.dart';
import 'package:neyyarapp/domain/entities/category.dart';
import 'package:neyyarapp/domain/repositories/category_repository.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryRemoteDataSource remoteDataSource;
  final CategoryLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  CategoryRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Category>>> getCategories() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteCategories = await remoteDataSource.getAllCategories();
        localDataSource.cacheCategories(remoteCategories);
        return Right(remoteCategories);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localCategories = await localDataSource.getCachedCategories();
        return Right(localCategories);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
