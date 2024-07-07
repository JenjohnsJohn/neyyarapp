part of 'course_list_bloc.dart';

abstract class CourseListState extends Equatable {
  const CourseListState();

  @override
  List<Object> get props => [];
}

class CourseListInitial extends CourseListState {}

class CourseListLoading extends CourseListState {}

class CourseListLoaded extends CourseListState {
  final List<Course> courses;

  const CourseListLoaded({required this.courses});

  @override
  List<Object> get props => [courses];
}

class CourseListError extends CourseListState {
  final String message;

  const CourseListError({required this.message});

  @override
  List<Object> get props => [message];
}
