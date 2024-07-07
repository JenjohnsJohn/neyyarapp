part of 'course_list_bloc.dart';

abstract class CourseListEvent extends Equatable {
  const CourseListEvent();

  @override
  List<Object> get props => [];
}

class FetchCourses extends CourseListEvent {}

class FilterCoursesByCategory extends CourseListEvent {
  final String category;

  const FilterCoursesByCategory({required this.category});

  @override
  List<Object> get props => [category];
}

class SearchCoursesEvent extends CourseListEvent {
  final String query;

  const SearchCoursesEvent({required this.query});
  @override
  List<Object> get props => [query];
}
