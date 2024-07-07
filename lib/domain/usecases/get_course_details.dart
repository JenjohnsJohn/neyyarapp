import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../../domain/entities/course.dart';
import '../../domain/repositories/course_repository.dart';

class GetCourseDetails {
  final CourseRepository repository;

  GetCourseDetails(this.repository);

  Future<Either<Failure, Course>> call(String courseId) async {
    return await repository.getCourseById(courseId);
  }
}
