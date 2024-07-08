import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:neyyarapp/core/error/exceptions.dart';
import 'package:neyyarapp/data/models/course_model.dart';

abstract class CourseRemoteDataSource {
  Future<List<CourseModel>> getAllCourses();
  Future<CourseModel> getCourseById(String id);
// Add more methods as needed (e.g., searchCourses, getCoursesByCategory)
}

class CourseRemoteDataSourceImpl implements CourseRemoteDataSource {
  final http.Client client;

  CourseRemoteDataSourceImpl({required this.client});

  @override
  Future<List<CourseModel>> getAllCourses() async {
    final response = await client.get(
      Uri.parse(
          'https://668a370b2c68eaf3211c3745.mockapi.io/api/v1/courses/courses'), // Replace with your actual API endpoint
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      // final jsonData = json.decode(response.body);

      final List<dynamic> jsonList = json.decode(response.body);

      return jsonList
          .map((coursesJson) => CourseModel.fromJson(coursesJson))
          .toList();
    } else {
      throw ServerException(); // Handle API errors (e.g., 404, 500)
    }
  }

  @override
  Future<CourseModel> getCourseById(String id) async {
    final response = await client.get(
      Uri.parse('https://api.example.com/courses'),
      headers: {
        'Content-Type': 'application/json',
        'x-api-key': '9758bf97501341a9acec995e8b9b256f'
      },
    );

    if (response.statusCode == 200) {
      print("object");
      final Map<String, dynamic> jsonData = json.decode(response.body);
      final List<dynamic> coursesJson =
          jsonData['data'] as List<dynamic>; // Extract the 'data' list

      // final List<dynamic> jsonList = json.decode(response.body);

      return CourseModel.fromJson(coursesJson.first);
    } else {
      throw ServerException();
    }
  }
}
