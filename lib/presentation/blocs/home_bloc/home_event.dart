part of 'home_bloc.dart';

@immutable
abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class FetchCategories extends HomeEvent {
  @override
  List<Object> get props => [];
}

class FetchFeaturedCourses extends HomeEvent {
  @override
  List<Object> get props => [];
}

class FetchMyCourses extends HomeEvent {
  @override
  List<Object> get props => [];
}

class CategorySelected extends HomeEvent {
  final String categoryId;

  const CategorySelected({required this.categoryId});
  @override
  List<Object> get props => [categoryId];
}
