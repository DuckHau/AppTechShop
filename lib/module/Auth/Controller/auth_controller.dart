// 📦 Package imports:
import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

// 🌎 Project imports:
import 'package:techshop_app/models/user.dart';
import 'package:techshop_app/module/Cart/Controller/cart_controller.dart';
import 'package:techshop_app/module/Order/Controller/order_controller.dart';
import 'package:techshop_app/services/API/ApiException.dart';
import 'package:techshop_app/services/Auth/auth_service.dart';

class AuthController extends GetxController {
  final AuthService _authService = AuthService();

  final _user = User().obs;
  User get user => _user.value;
  final _isLoggedIn = false.obs;
  bool get isLoggedIn => _isLoggedIn.value;
  Rx<RxStatus> status = Rx<RxStatus>(RxStatus.empty());

  @override
  void onInit() {
    super.onInit();
    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    _isLoggedIn.value = await _authService.isLoggedIn();
  }

  Future<bool> login(String email, String password) async {
    try {
      _user.value = await _authService.login(email, password);
      _isLoggedIn.value = true;
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> register(String fullname, String email, String password) async {
    try {
      _user.value = await _authService.register(fullname, email, password);
      _isLoggedIn.value = true;
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<void> logout() async {
    try {
      await _authService.logout();
      _user.value = User();
      _isLoggedIn.value = false;
      Get.find<CartController>().resetCart(); // Reset the cart state
      Get.find<OrderController>().resetOrder(); // Reset the order state
    } on Exception catch (e) {
      print(e);
    }
  }

  Future<String?> getToken() async {
    return _authService.getToken();
  }

  //user profile
  void getUserProfile() async {
    Future.microtask(() => status.value = RxStatus.loading());
    try {
      final response = await _authService.getUserProfile();
      if (response.statusCode == 200) {
        _user.value = User.fromJson(response.data);
        Future.microtask(() => status.value = RxStatus.success());
      }
    } on dio.DioException catch (e) {
      final ApiException apiException = ApiException.fromDioException(e);
      Future.microtask(
          () => status.value = RxStatus.error(apiException.toString()));
    }
    update();
  }

  //update user profile
  Future<void> updateUserProfile(String fullname, String email, String password,
      String phone, String address, XFile? avatar) async {
    Future.microtask(() => status.value = RxStatus.loading());
    try {
      final response = await _authService.updateUserProfile(
          fullname, email, password, phone, address, avatar);
      if (response.statusCode == 200) {
        _user.value = User.fromJson(response.data);
        Future.microtask(() => status.value = RxStatus.success());
      }
    } on dio.DioException catch (e) {
      final ApiException apiException = ApiException.fromDioException(e);
      Future.microtask(
          () => status.value = RxStatus.error(apiException.toString()));
    }
  }
}
