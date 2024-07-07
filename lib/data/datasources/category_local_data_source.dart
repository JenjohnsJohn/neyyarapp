import 'dart:convert';
import 'package:neyyarapp/core/error/exceptions.dart';
import 'package:neyyarapp/data/models/category_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class CategoryLocalDataSource {
  Future<List<CategoryModel>> getCachedCategories();
  Future<void> cacheCategories(List<CategoryModel> categoriesToCache);
}

const CACHED_CATEGORIES_LIST = 'CACHED_CATEGORIES_LIST';

class CategoryLocalDataSourceImpl implements CategoryLocalDataSource {
  final SharedPreferences sharedPreferences;

  CategoryLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<CategoryModel>> getCachedCategories() {
    final jsonString = sharedPreferences.getString(CACHED_CATEGORIES_LIST);
    if (jsonString != null) {
      final List<dynamic> jsonList = json.decode(jsonString);
      List<CategoryModel> categories =
          jsonList.map((i) => CategoryModel.fromJson(i)).toList();
      return Future.value(categories);
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheCategories(List<CategoryModel> categoriesToCache) {
    final List<Map<String, dynamic>> jsonList =
        categoriesToCache.map((category) => category.toJson()).toList();
    return sharedPreferences.setString(
        CACHED_CATEGORIES_LIST, json.encode(jsonList));
  }
}
