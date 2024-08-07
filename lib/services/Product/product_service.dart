// 📦 Package imports:
import 'package:dio/dio.dart';

// 🌎 Project imports:
import 'package:techshop_app/services/API/ApiService.dart';

class ProductService {
  final ApiService _apiService = ApiService(Dio());

  Future<Response> getProducts(
    int? page, {
    String? keyword,
    int? resPerPage,
    String? category,
    String? brand,
    String? sort,
    int? stock,
  }) async {
    try {
      final Map<String, dynamic> queryParameters = {
        if (resPerPage != null) 'resPerPage': resPerPage.toString(),
        if (keyword != null && keyword.isNotEmpty) 'keyword': keyword,
        if (category != null && category.isNotEmpty) 'category': category,
        if (brand != null && brand.isNotEmpty) 'brand': brand,
        if (sort != null && sort == 'price') 'sort': 'price',
        if (sort != null && sort == '-price') 'sort': '-price',
        if (stock != null) 'stock': stock.toString(),
      };
      final Response<dynamic> response = await _apiService
          .get('/product?page=$page', queryParameters: queryParameters);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> getProductBySlug(String slug) async {
    try {
      final response = await _apiService.get('/product/$slug');
      return response;
    } on Exception catch (e) {
      // ignore: avoid_print
      print(e);
      rethrow;
    }
  }

  Future<Map<String, dynamic>> createProduct(
      Map<String, dynamic> productData) async {
    final response = await _apiService.post('/product', data: productData);
    return response.data;
  }
}
