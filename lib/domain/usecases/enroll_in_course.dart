import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../../domain/repositories/course_repository.dart';

class EnrollInCourse {
  final CourseRepository repository;

  EnrollInCourse(this.repository);

  Future<Either<Failure, void>> call(String courseId) async {
    return await repository.enrollInCourse(courseId);
  }
}
