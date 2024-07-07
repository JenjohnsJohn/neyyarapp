import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:neyyarapp/domain/repositories/category_repository.dart';
import 'package:neyyarapp/domain/repositories/course_repository.dart';
import '../../../domain/entities/course.dart';
import '../../../domain/entities/category.dart';
import '../../../domain/usecases/get_categories.dart';
import '../../../domain/usecases/get_featured_courses.dart';
import '../../../domain/usecases/get_my_courses.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetCategories _getCategories;
  final GetFeaturedCourses _getFeaturedCourses;
  final GetMyCourses _getMyCourses;

  HomeBloc({
    required GetCategories getCategories,
    required GetFeaturedCourses getFeaturedCourses,
    required GetMyCourses getMyCourses,
    required CategoryRepository categoryRepository,
    required CourseRepository courseRepository,
  })  : _getCategories = getCategories,
        _getFeaturedCourses = getFeaturedCourses,
        _getMyCourses = getMyCourses,
        super(HomeLoading()) {
    on<FetchCategories>(_onFetchCategories);
    on<FetchFeaturedCourses>(_onFetchFeaturedCourses);
    on<FetchMyCourses>(_onFetchMyCourses);
    // ... Add more event handlers as needed (e.g., for filtering, searching)
  }

  Future<void> _onFetchCategories(
      FetchCategories event, Emitter<HomeState> emit) async {
    final failureOrCategories = await _getCategories();
    failureOrCategories.fold(
      (failure) => emit(HomeError(message: failure.message)),
      (categories) => emit(HomeLoaded(
        categories: categories,
        featuredCourses: [], // Clear featured courses when changing categories
        myCourses: state is HomeLoaded ? (state as HomeLoaded).myCourses : [],
      )),
    );
  }

  Future<void> _onFetchFeaturedCourses(
      FetchFeaturedCourses event, Emitter<HomeState> emit) async {
    final failureOrCourses =
        await _getFeaturedCourses(); // Execute the use case
    failureOrCourses.fold(
      (failure) => emit(HomeError(message: failure.message)),
      (courses) => emit(HomeLoaded(
        featuredCourses: courses,
        categories: state is HomeLoaded ? (state as HomeLoaded).categories : [],
        myCourses: state is HomeLoaded ? (state as HomeLoaded).myCourses : [],
      )),
    );
  }

  Future<void> _onFetchMyCourses(
      FetchMyCourses event, Emitter<HomeState> emit) async {
    final failureOrCourses = await _getMyCourses(); // Execute the use case
    failureOrCourses.fold(
      (failure) => emit(HomeError(message: failure.message)),
      (courses) => emit(HomeLoaded(
        myCourses: courses,
        categories: state is HomeLoaded ? (state as HomeLoaded).categories : [],
        featuredCourses:
            state is HomeLoaded ? (state as HomeLoaded).featuredCourses : [],
      )),
    );
  }
}
