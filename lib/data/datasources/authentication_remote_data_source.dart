import 'dart:convert';
import 'package:neyyarapp/data/models/user_model.dart';

import '../../core/error/exceptions.dart';
import 'package:http/http.dart' as http;

abstract class AuthenticationRemoteDataSource {
  Future<UserModel> login(String email, String password);
  Future<UserModel> signUp(String email, String password, String name);
// Add more methods as needed (e.g., forgotPassword, verifyEmail)
}

class AuthenticationRemoteDataSourceImpl
    implements AuthenticationRemoteDataSource {
  final http.Client client;

  AuthenticationRemoteDataSourceImpl({required this.client});

  @override
  Future<UserModel> login(String email, String password) async {
    final response = await client.post(
      Uri.parse('https://api.example.com/login'),
      // Replace with your actual API endpoint
      body: json.encode({'email': email, 'password': password}),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return UserModel.fromJson(json.decode(response.body));
    } else if (response.statusCode == 401) {
      throw AuthenticationException();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<UserModel> signUp(String email, String password, String name) async {
    final response = await client.post(
      Uri.parse('https://api.example.com/signup'),
      // Replace with your actual API endpoint
      body: json.encode({'email': email, 'password': password, 'name': name}),
      // Adjust based on your API
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 201) {
      // Successful sign up usually returns 201
      return UserModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException(); // Or another appropriate exception
    }
  }
}
