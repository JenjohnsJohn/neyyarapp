import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../../domain/entities/course.dart';
import '../../domain/repositories/course_repository.dart';

class GetCoursesByCategory {
  final CourseRepository repository;

  GetCoursesByCategory(this.repository);

  Future<Either<Failure, List<Course>>> call(String category) async {
    return await repository.getCoursesByCategory(category);
  }
}
