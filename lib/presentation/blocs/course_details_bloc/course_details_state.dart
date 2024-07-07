part of 'course_details_bloc.dart';

abstract class CourseDetailsState extends Equatable {
  const CourseDetailsState();

  @override
  List<Object> get props => [];
}

class CourseDetailsInitial extends CourseDetailsState {}

class CourseDetailsLoading extends CourseDetailsState {}

class CourseDetailsLoaded extends CourseDetailsState {
  final Course course;

  const CourseDetailsLoaded({required this.course});

  @override
  List<Object> get props => [course];
}

class CourseDetailsError extends CourseDetailsState {
  final String message;

  const CourseDetailsError({required this.message});

  @override
  List<Object> get props => [message];
}

class EnrollingInCourse extends CourseDetailsState {}

class EnrollmentSuccess extends CourseDetailsState {}

class EnrollmentError extends CourseDetailsState {
  final String message;

  const EnrollmentError({required this.message});
  @override
  List<Object> get props => [message];
}
