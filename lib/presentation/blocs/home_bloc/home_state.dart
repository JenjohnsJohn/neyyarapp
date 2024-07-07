part of 'home_bloc.dart';

@immutable
abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeLoading extends HomeState {
  @override
  List<Object> get props => [];
}

class HomeLoaded extends HomeState {
  final List<Category> categories;
  final List<Course> featuredCourses;
  final List<Course> myCourses;

  const HomeLoaded({
    this.categories = const [],
    this.featuredCourses = const [],
    this.myCourses = const [],
  });

  @override
  List<Object> get props => [categories, featuredCourses, myCourses];
}

class HomeError extends HomeState {
  final String message;

  const HomeError({required this.message});

  @override
  List<Object> get props => [message];
}
