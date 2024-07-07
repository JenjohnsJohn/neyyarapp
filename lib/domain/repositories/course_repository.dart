import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../../domain/entities/course.dart';

abstract class CourseRepository {
  Future<Either<Failure, List<Course>>> getAllCourses();
  Future<Either<Failure, Course>> getCourseById(String id);
  Future<Either<Failure, void>> enrollInCourse(String courseId);
  Future<Either<Failure, List<Course>>> getCoursesByCategory(String category);
  Future<Either<Failure, List<Course>>> getFeaturedCourses();
  Future<Either<Failure, List<Course>>> getMyCourses();
  Future<Either<Failure, List<Course>>> searchCourses(String query);
// Add more methods as needed (e.g., searchCourses, getCoursesByCategory)
}
