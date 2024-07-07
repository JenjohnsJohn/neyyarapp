import 'dart:convert';
import 'package:elearning_app/core/error/exceptions.dart';
import 'package:elearning_app/data/models/category_model.dart';
import 'package:http/http.dart' as http;

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
          'https://api.example.com/categories'), // Replace with your actual API endpoint
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => CategoryModel.fromJson(json)).toList();
    } else {
      throw ServerException(); // Handle API errors
    }
  }
}
