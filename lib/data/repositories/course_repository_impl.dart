import 'package:dartz/dartz.dart';
import 'package:neyyarapp/core/error/exceptions.dart';
import 'package:neyyarapp/core/error/failures.dart';
import 'package:neyyarapp/core/network/network_info.dart';
import 'package:neyyarapp/data/datasources/course_local_data_source.dart';
import 'package:neyyarapp/data/datasources/course_remote_data_source.dart';
import 'package:neyyarapp/domain/entities/course.dart';
import 'package:neyyarapp/domain/repositories/course_repository.dart';

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

  @override
  Future<Either<Failure, void>> enrollInCourse(String courseId) {
    // TODO: implement enrollInCourse
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<Course>>> getCoursesByCategory(String category) {
    // TODO: implement getCoursesByCategory
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<Course>>> getFeaturedCourses() async {
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
  Future<Either<Failure, List<Course>>> getMyCourses() async {
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
  Future<Either<Failure, List<Course>>> searchCourses(String query) {
    // TODO: implement searchCourses
    throw UnimplementedError();
  }

// Implement other methods from the CourseRepository interface (searchCourses, getCoursesByCategory, etc.)
}
