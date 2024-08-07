// 📦 Package imports:
import 'package:dio/dio.dart';

// 🌎 Project imports:
import '../API/ApiService.dart';

class CartService {
  final ApiService _apiService = ApiService(Dio());

  Future<Response> addToCart(Map<String, dynamic> data) async {
    try {
      Response response = await _apiService.post('/cart/addToCart', data: data);
      return response;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<Response> getCartItems() async {
    try {
      Response response = await _apiService.get('/cart/getCartItems');
      return response;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<Response> updateCart(Map<String, dynamic> data) async {
    try {
      Response response = await _apiService.put('/cart/updateCart', data: data);
      return response;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<Response> removeCartItem(Map<String, dynamic> data) async {
    try {
      Response response =
          await _apiService.post('/cart/removeCartItem', data: data);
      return response;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  //clear cart
  Future<Response> clearCart() async {
    try {
      Response response = await _apiService.delete('/cart/clearCart');
      return response;
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
