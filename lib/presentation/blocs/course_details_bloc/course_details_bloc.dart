import 'dart:async';
import 'package:bloc/bloc.dart';
import '../../../core/error/failures.dart';
import '../../../domain/entities/course.dart';
import '../../../domain/usecases/enroll_in_course.dart';
import '../../../domain/usecases/get_course_details.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'course_details_event.dart';
part 'course_details_state.dart';

class CourseDetailsBloc extends Bloc<CourseDetailsEvent, CourseDetailsState> {
  final GetCourseDetails _getCourseDetails;
  final EnrollInCourse _enrollInCourse;

  CourseDetailsBloc({
    required GetCourseDetails getCourseDetails,
    required EnrollInCourse enrollInCourse,
  })  : _getCourseDetails = getCourseDetails,
        _enrollInCourse = enrollInCourse,
        super(CourseDetailsInitial()) {
    on<GetCourseDetailsEvent>(_onGetCourseDetails);
    on<EnrollInCourseEvent>(_onEnrollInCourse);
  }

  Future<void> _onGetCourseDetails(
      GetCourseDetailsEvent event, Emitter<CourseDetailsState> emit) async {
    emit(CourseDetailsLoading());
    final failureOrCourse = await _getCourseDetails(event.courseId);
    emit(failureOrCourse.fold(
      (failure) => CourseDetailsError(message: _mapFailureToMessage(failure)),
      (course) => CourseDetailsLoaded(course: course),
    ));
  }

  Future<void> _onEnrollInCourse(
      EnrollInCourseEvent event, Emitter<CourseDetailsState> emit) async {
    emit(EnrollingInCourse());
    final failureOrSuccess = await _enrollInCourse(event.courseId);
    emit(failureOrSuccess.fold(
      (failure) => EnrollmentError(message: _mapFailureToMessage(failure)),
      (_) {
        // On successful enrollment, refresh the course details
        add(GetCourseDetailsEvent(courseId: event.courseId));
        return EnrollmentSuccess();
      },
    ));
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return 'Server Error';
      case CacheFailure:
        return 'Cache Error';
      case CourseNotFoundFailure:
        return 'Course Not Found';
      default:
        return 'Unexpected Error';
    }
  }
}
