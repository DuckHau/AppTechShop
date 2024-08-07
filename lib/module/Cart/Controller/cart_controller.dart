// 📦 Package imports:
import 'package:dio/dio.dart';
import 'package:get/get.dart';

// 🌎 Project imports:
import 'package:techshop_app/models/cart.dart';
import 'package:techshop_app/module/Auth/Controller/auth_controller.dart';
import '../../../services/Cart/cart_service.dart';

class CartController extends GetxController with StateMixin<List<CartItems>> {
  var cartItems = List<CartItems>.empty(growable: true).obs;
  var totalItems = 0.obs;
  var totalPrice = 0.0.obs;
  var totalQuantity = 0.obs;
  final CartService _cartService = CartService();
  var isLoading = false.obs;

  void fetchCartItems() async {
    isLoading.value = true;
    try {
      final response = await _cartService.getCartItems();
      if (response.statusCode == 200) {
        final dataCart = response.data['cartItems'];
        List<CartItems> cartItemsList = dataCart
            .map<CartItems>((item) => CartItems.fromJson(item))
            .toList();
        cartItems.assignAll(cartItemsList);
        change(cartItems, status: RxStatus.success());
        totalItems.value = response.data['total_items'];
        totalPrice.value = double.parse(response.data['total_price']);
        totalQuantity.value = response.data['total_quantity'];
      } else {
        print('Error: Failed to fetch cart items');
      }
    } on DioException catch (e) {
      print('Error: Failed to fetch cart items: ${e.message}');
    }
    isLoading.value = false;
    update();
  }

  int getCartItemCount() {
    print('Fetching cart item count: ${cartItems.length}');
    return cartItems.length;
  }

  void addToCart(List<Map<String, dynamic>> cartItems) async {
    Get.find<AuthController>().checkLoginStatus();
    if (!Get.find<AuthController>().isLoggedIn) {
      Get.snackbar('Thông báo', 'Bạn phải đăng nhập để thêm vào giỏ hàng');
      return;
    }
    final data = {'cartItems': cartItems};
    final response = await _cartService.addToCart(data);
    if (response.statusCode == 201) {
      Get.snackbar('Thành công', 'Đã thêm vào giỏ hàng');
      fetchCartItems();
    } else {
      Get.snackbar('Error', 'Failed to add to cart');
    }
  }

  void updateCart(Map<String, dynamic> data) async {
    final response = await _cartService.updateCart(data);
    if (response.statusCode == 200) {
      Get.snackbar('Thành công', 'Đã cập nhật giỏ hàng');
      fetchCartItems();
    } else {
      Get.snackbar('Error', 'Failed to update cart');
    }
  }

  void updateCartItemQuantity(String productId, int newQuantity) async {
    if (newQuantity <= 0) {
      removeCartItem(productId);
      return;
    }
    final data = {'productId': productId, 'quantity': newQuantity};
    final response = await _cartService.updateCart(data);
    if (response.statusCode == 200) {
      fetchCartItems();
    } else {
      Get.snackbar('Error', 'Failed to update cart item quantity');
    }
  }

  void removeCartItem(String productId) async {
    final data = {'productId': productId};
    final response = await _cartService.removeCartItem(data);
    if (response.statusCode == 200) {
      fetchCartItems();
    } else {
      Get.snackbar('Error', 'Failed to remove cart item');
    }
  }

  void resetCart() {
    cartItems.clear();
    totalItems.value = 0;
    totalPrice.value = 0.0;
    totalQuantity.value = 0;
  }

  Future<void> clearCart() async {
    final response = await _cartService.clearCart();
    if (response.statusCode == 200) {
      Get.snackbar('Thành công', 'Đã xóa giỏ hàng');
      fetchCartItems();
    } else {
      Get.snackbar('Error', 'Failed to clear cart');
    }
  }
}
