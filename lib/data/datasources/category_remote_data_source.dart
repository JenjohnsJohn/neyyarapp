import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:neyyarapp/core/error/exceptions.dart';
import 'package:neyyarapp/data/models/category_model.dart';

abstract class CategoryRemoteDataSource {
  Future<List<CategoryModel>> getAllCategories();
}

class CategoryRemoteDataSourceImpl implements CategoryRemoteDataSource {
  final http.Client client;

  CategoryRemoteDataSourceImpl({required this.client});

  @override
  Future<List<CategoryModel>> getAllCategories() async {
    final response = await client.get(
      Uri.parse(
          'https://668a370b2c68eaf3211c3745.mockapi.io/api/v1/courses/categories'), // Replace with your actual API endpoint
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      print(jsonList);
      return jsonList.map((json) => CategoryModel.fromJson(json)).toList();
    } else {
      throw ServerException(); // Handle API errors
    }
  }
}
