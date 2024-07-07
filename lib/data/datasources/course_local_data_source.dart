import 'dart:convert';
import 'package:elearning_app/core/error/exceptions.dart';
import 'package:elearning_app/data/models/course_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:meta/meta.dart';

abstract class CourseLocalDataSource {
  /// Gets the cached [CourseModel]s from local storage.
  ///
  /// Throws [CacheException] if no cached data is present.
  Future<List<CourseModel>> getCachedCourses();
  Future<CourseModel> getCachedCourseById(String id);
  Future<void> cacheCourses(List<CourseModel> coursesToCache);
}

const CACHED_COURSES_LIST = 'CACHED_COURSES_LIST';
const CACHED_COURSE_PREFIX = 'CACHED_COURSE_';

class CourseLocalDataSourceImpl implements CourseLocalDataSource {
  final SharedPreferences sharedPreferences;

  CourseLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<CourseModel>> getCachedCourses() {
    final jsonString = sharedPreferences.getString(CACHED_COURSES_LIST);
    if (jsonString != null) {
      final List<dynamic> jsonList = json.decode(jsonString);
      List<CourseModel> courses =
          jsonList.map((i) => CourseModel.fromJson(i)).toList();
      return Future.value(courses);
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheCourses(List<CourseModel> coursesToCache) {
    final List<Map<String, dynamic>> jsonList =
        coursesToCache.map((course) => course.toJson()).toList();
    return sharedPreferences.setString(
        CACHED_COURSES_LIST, json.encode(jsonList));
  }

  @override
  Future<CourseModel> getCachedCourseById(String id) {
    final jsonString = sharedPreferences.getString('$CACHED_COURSE_PREFIX$id');
    if (jsonString != null) {
      return Future.value(CourseModel.fromJson(json.decode(jsonString)));
    } else {
      throw CacheException();
    }
  }
}
