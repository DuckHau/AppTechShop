// 🎯 Dart imports:
import 'dart:convert';

// 📦 Package imports:
import 'package:dio/dio.dart';

// 🌎 Project imports:
import 'package:techshop_app/services/API/ApiService.dart';

class OrderService {
  final ApiService _apiService = ApiService(Dio());

  Future<Map<String, dynamic>> createOrder(
      Map<String, dynamic> orderData) async {
    final response = await _apiService.post('/order', data: orderData);
    return response.data;
  }

  //get orders
  Future<Response> getOrders({String? orderStatus}) async {
    try {
      final response = await _apiService.get('/order/me/order',
          queryParameters:
              orderStatus != null ? {'orderStatus': orderStatus} : null);
      return response;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  //get order detail
  Future<Response> getOrderDetail(String orderId) async {
    try {
      final response =
          await _apiService.get('/order/get-order-detail/$orderId');
      return response;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<Map<String, String>> createPaymentLink(int amount) async {
    const returnUrl = 'app://techshopflutter/checkout/order-success';
    const cancelUrl = 'app://techshopflutter/checkout/order-failed';

    try {
      final response = await _apiService.post('/order/create',
          data: jsonEncode(<String, dynamic>{
            'orderCode': DateTime.now().millisecondsSinceEpoch,
            'amount': amount,
            'description': 'Order #${DateTime.now().millisecondsSinceEpoch}',
            'returnUrl': returnUrl,
            'cancelUrl': cancelUrl,
          }));
      print("Thanh toán: ${response.data['data']['checkoutUrl']}");
      if (response.statusCode == 200) {
        return {
          'checkoutUrl': response.data['data']['checkoutUrl'],
          'orderCode': response.data['data']['orderCode'].toString()
        };
      } else {
        throw Exception('Failed to create payment link');
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.unknown) {
        print('CORS error: ${e.message}');
      }
      rethrow;
    }
  }

  Future<void> updatePaymentStatus(String orderId, String paymentStatus) async {
    try {
      final response =
          await _apiService.put('/order/update-payment-status/$orderId', data: {
        'paymentStatus': paymentStatus,
      });
      if (response.statusCode != 200) {
        throw Exception('Failed to update payment status');
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  //add order
  Future<Map<String, dynamic>> addOrder(Map<String, dynamic> orderData) async {
    try {
      final response =
          await _apiService.post('/order/add-order', data: orderData);
      print("Thêm đơn hàng: ${response.data}");
      return response.data;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  //vnpay

  Future<String> vnpayPayment(int orderId, int amount, String bankCode) async {
    try {
      final response = await _apiService.post(
        '/order/create_payment_url',
        data: {
          'orderId': orderId,
          'amount': amount,
          'bankCode': bankCode,
        },
        options: Options(
          validateStatus: (status) {
            return status! < 500; // Accept all status codes below 500
          },
        ),
      );
      if (response.statusCode == 302) {
        return response.headers['location']?.first ?? '';
      } else {
        throw Exception('Failed to create VNPay payment URL');
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
