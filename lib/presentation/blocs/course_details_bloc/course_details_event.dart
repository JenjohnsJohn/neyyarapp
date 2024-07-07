part of 'course_details_bloc.dart';

abstract class CourseDetailsEvent extends Equatable {
  const CourseDetailsEvent();

  @override
  List<Object> get props => [];
}

class GetCourseDetailsEvent extends CourseDetailsEvent {
  final String courseId;

  const GetCourseDetailsEvent({required this.courseId});
  @override
  List<Object> get props => [courseId];
}

class EnrollInCourseEvent extends CourseDetailsEvent {
  final String courseId;

  const EnrollInCourseEvent({required this.courseId});
  @override
  List<Object> get props => [courseId];
}
