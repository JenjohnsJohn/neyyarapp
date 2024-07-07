import 'package:dartz/dartz.dart';
import 'package:elearning_app/core/error/exceptions.dart';
import 'package:elearning_app/core/error/failures.dart';
import 'package:elearning_app/core/network/network_info.dart';
import 'package:elearning_app/data/datasources/course_local_data_source.dart';
import 'package:elearning_app/data/datasources/course_remote_data_source.dart';
import 'package:elearning_app/data/models/course_model.dart';
import 'package:elearning_app/domain/entities/course.dart';
import 'package:elearning_app/domain/repositories/course_repository.dart';

class CourseRepositoryImpl implements CourseRepository {
  final CourseRemoteDataSource remoteDataSource;
  final CourseLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  CourseRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Course>>> getAllCourses() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteCourses = await remoteDataSource.getAllCourses();
        localDataSource.cacheCourses(remoteCourses);
        return Right(remoteCourses);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localCourses = await localDataSource.getCachedCourses();
        return Right(localCourses);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Course>> getCourseById(String id) async {
    try {
      final localCourse = await localDataSource.getCachedCourseById(id);
      return Right(localCourse);
    } on CacheException {
      // Fetch from remote data source if cache is empty
    }

    if (await networkInfo.isConnected) {
      try {
        final remoteCourse = await remoteDataSource.getCourseById(id);
        // You can cache the course here if you want to
        return Right(remoteCourse);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }

// Implement other methods from the CourseRepository interface (searchCourses, getCoursesByCategory, etc.)
}
