import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../../domain/entities/course.dart';
import '../../domain/repositories/course_repository.dart';

class GetFeaturedCourses {
  final CourseRepository repository;

  GetFeaturedCourses(this.repository);

  Future<Either<Failure, List<Course>>> call() async {
    return await repository.getFeaturedCourses();
  }
}
