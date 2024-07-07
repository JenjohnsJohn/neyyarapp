import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../../domain/entities/course.dart';

abstract class CourseRepository {
  Future<Either<Failure, List<Course>>> getAllCourses();
  Future<Either<Failure, Course>> getCourseById(String id);
// Add more methods as needed (e.g., searchCourses, getCoursesByCategory)
}
