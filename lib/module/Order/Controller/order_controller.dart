// 📦 Package imports:
import 'package:dio/dio.dart';
import 'package:get/get.dart';

// 🌎 Project imports:
import 'package:techshop_app/models/order.dart';
import 'package:techshop_app/module/Auth/Controller/auth_controller.dart';
import 'package:techshop_app/services/API/ApiException.dart';
import 'package:techshop_app/services/Order/order_service.dart';

class OrderController extends GetxController {
  final OrderService orderService = Get.put(OrderService());
  final AuthController authController = Get.find<AuthController>();
  RxList<Data> orders = RxList<Data>();
  Rx<Data?> orderDetail = Rx<Data?>(null);
  // Rx<bool> isLoading = Rx<bool>(false);
  Rx<RxStatus> status = Rx<RxStatus>(RxStatus.empty());

  // @override
  // void onInit() {
  //   super.onInit();
  //   if (authController.isLoggedIn) {
  //     getOrder();
  //   }
  // }

  Future<void> getOrder({String? orderStatus}) async {
    Future.microtask(() => status.value = RxStatus.loading());
    try {
      final response = await orderService.getOrders(orderStatus: orderStatus);
      if (response.statusCode == 200) {
        if (response.data is List) {
          orders.value = response.data.map((e) => Order.fromJson(e)).toList();
        } else {
          final orderData = Order.fromJson(response.data);
          orders.value = orderData.data ?? [];
        }
        Future.microtask(() => status.value = RxStatus.success());
      } else {
        throw Exception('Failed to get order');
      }
    } on DioException catch (e) {
      final ApiException apiException = ApiException.fromDioException(e);
      Future.microtask(
          () => status.value = RxStatus.error(apiException.toString()));
      print(e);
    }
    update();
  }

  Future<void> getOrderDetail(String orderId) async {
    Future.microtask(() => status.value = RxStatus.loading());
    print('Fetching order details for orderId: $orderId');
    try {
      final response = await orderService.getOrderDetail(orderId);
      if (response.statusCode == 200 && response.data != null) {
        final orderData = response.data['data']['order'];
        orderDetail.value = Data.fromJson(orderData);
        Future.microtask(() => status.value = RxStatus.success());
        print('Order details fetched successfully');
      } else {
        throw Exception('Failed to get order detail');
      }
    } on DioException catch (e) {
      final ApiException apiException = ApiException.fromDioException(e);
      Future.microtask(
          () => status.value = RxStatus.error(apiException.toString()));
      print(e);
    }
    update();
  }

  Future<Map<String, String>> createPaymentLink(int amount) async {
    Future.microtask(() => status.value = RxStatus.loading());
    try {
      final response = await orderService.createPaymentLink(amount);
      final url = response['checkoutUrl'];
      final orderCode = response['orderCode'];
      if (url != null && orderCode != null) {
        Future.microtask(() => status.value = RxStatus.success());
      }
      return {'url': url!, 'orderCode': orderCode!};
    } on DioException catch (e) {
      final ApiException apiException = ApiException.fromDioException(e);
      Future.microtask(
          () => status.value = RxStatus.error(apiException.toString()));
      rethrow;
    }
  }

  Future<void> handlePaymentResult(String orderId, String url) async {
    if (url.contains('order-success')) {
      await orderService.updatePaymentStatus(orderId, 'completed');
    } else if (url.contains('order-failed')) {
      await orderService.updatePaymentStatus(orderId, 'cancelled');
    }
  }

  Future<void> addOrder(Map<String, dynamic> orderData) async {
    Future.microtask(() => status.value = RxStatus.loading());
    try {
      final response = await orderService.addOrder(orderData);
      if (response['success']) {
        Future.microtask(() => status.value = RxStatus.success());
        print('Order added successfully: ${response['order']}');
      } else {
        print('Failed to add order');
      }
    } on DioException catch (e) {
      final ApiException apiException = ApiException.fromDioException(e);
      Future.microtask(
          () => status.value = RxStatus.error(apiException.toString()));
      print(e);
    }
  }

  //vnpay
  Future<String> vnpayPayment(int orderId, int amount, String bankCode) async {
    return await orderService.vnpayPayment(orderId, amount, bankCode);
  }

  void resetOrder() {
    orders.clear();
    orderDetail.value = null;
  }
}
