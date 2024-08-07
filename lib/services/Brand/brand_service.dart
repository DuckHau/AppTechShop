// 📦 Package imports:
import 'package:dio/dio.dart';

// 🌎 Project imports:
import 'package:techshop_app/services/API/ApiService.dart';

class BrandService {
  final ApiService _apiService = ApiService(Dio());

  Future<Response> getTopBrands() async {
    try {
      final Response<dynamic> response =
          await _apiService.get('/product/brands/top');
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
