import 'package:dartz/dartz.dart';
import 'package:elearning_app/core/error/exceptions.dart';
import 'package:elearning_app/core/error/failures.dart';
import 'package:elearning_app/core/network/network_info.dart';
import 'package:elearning_app/data/datasources/category_local_data_source.dart';
import 'package:elearning_app/data/datasources/category_remote_data_source.dart';
import 'package:elearning_app/domain/entities/category.dart';
import 'package:elearning_app/domain/repositories/category_repository.dart';

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
