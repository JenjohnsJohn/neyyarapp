import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../../domain/entities/course.dart';
import '../../domain/repositories/course_repository.dart';

class SearchCourses {
  final CourseRepository repository;

  SearchCourses(this.repository);

  Future<Either<Failure, List<Course>>> call(String query) async {
    // Add some basic input validation if needed (e.g., minimum query length)
    if (query.isEmpty) {
      return Left(InvalidInputFailure());
    }

    return await repository.searchCourses(query);
  }
}
