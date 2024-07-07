import 'dart:async';
import 'package:bloc/bloc.dart';
import '../../../core/error/failures.dart';
import '../../../domain/entities/course.dart';
import '../../../domain/usecases/get_courses_by_category.dart';
import '../../../domain/usecases/search_courses.dart';
import '../../../domain/usecases/get_all_courses.dart';
import 'package:equatable/equatable.dart';

part 'course_list_event.dart';
part 'course_list_state.dart';

class CourseListBloc extends Bloc<CourseListEvent, CourseListState> {
  final GetAllCourses getAllCourses;
  final GetCoursesByCategory getCoursesByCategory;
  final SearchCourses searchCourses;

  CourseListBloc(
      {required this.getAllCourses,
      required this.getCoursesByCategory,
      required this.searchCourses})
      : super(CourseListInitial()) {
    on<FetchCourses>(_onFetchCourses);
    on<FilterCoursesByCategory>(_onFilterCoursesByCategory);
    on<SearchCoursesEvent>(_onSearchCourses);
  }

  Future<void> _onFetchCourses(
      FetchCourses event, Emitter<CourseListState> emit) async {
    emit(CourseListLoading()); // Indicate loading state
    final failureOrCourses = await getAllCourses();
    emit(failureOrCourses.fold(
      (failure) => CourseListError(message: _mapFailureToMessage(failure)),
      (courses) => CourseListLoaded(courses: courses),
    ));
  }

  Future<void> _onFilterCoursesByCategory(
      FilterCoursesByCategory event, Emitter<CourseListState> emit) async {
    emit(CourseListLoading()); // Indicate loading state
    final failureOrCourses = await getCoursesByCategory(event.category);
    emit(failureOrCourses.fold(
      (failure) => CourseListError(message: _mapFailureToMessage(failure)),
      (courses) => CourseListLoaded(courses: courses),
    ));
  }

  Future<void> _onSearchCourses(
      SearchCoursesEvent event, Emitter<CourseListState> emit) async {
    emit(CourseListLoading()); // Indicate loading state
    final failureOrCourses = await searchCourses(event.query);
    emit(failureOrCourses.fold(
      (failure) => CourseListError(message: _mapFailureToMessage(failure)),
      (courses) => CourseListLoaded(courses: courses),
    ));
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return 'Server Error';
      case CacheFailure:
        return 'Cache Error';
      default:
        return 'Unexpected Error';
    }
  }
}
