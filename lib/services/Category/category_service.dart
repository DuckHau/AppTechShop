// 📦 Package imports:
import 'package:dio/dio.dart';

// 🌎 Project imports:
import '../API/ApiService.dart';

class CategoryService {
  final ApiService _apiService = ApiService(Dio());

  Future<Response> getCategories() async {
    try {
      final Response<dynamic> response = await _apiService.get('/category');
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> getCategoryBySlug(String slug) async {
    try {
      final response = await _apiService.get('/category/$slug');
      return response.data['data'];
    } on Exception catch (e) {
      // ignore: avoid_print
      print(e);
      rethrow;
    }
  }

  Future<Map<String, dynamic>> createCategory(
      Map<String, dynamic> categoryData) async {
    final response = await _apiService.post('/category', data: categoryData);
    return response.data;
  }

  Future<Map<String, dynamic>> updateCategory(
      Map<String, dynamic> categoryData) async {
    final response = await _apiService.put('/category', data: categoryData);
    return response.data;
  }

  Future<Map<String, dynamic>> deleteCategory(String id) async {
    final response = await _apiService.delete('/category/$id');
    return response.data;
  }
}
