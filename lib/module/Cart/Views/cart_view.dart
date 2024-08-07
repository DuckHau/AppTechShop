// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

// 🌎 Project imports:
import 'package:techshop_app/module/Auth/Controller/auth_controller.dart';
import 'package:techshop_app/module/Auth/Views/check_login_view.dart';
import 'package:techshop_app/module/Cart/Controller/cart_controller.dart';
import 'package:techshop_app/module/Cart/Views/cart_empty_view.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final CartController _cartController = Get.find<CartController>();
  final AuthController _authController = Get.find<AuthController>();

  @override
  void initState() {
    super.initState();
    _cartController.fetchCartItems();
  }

  void _incrementQuantity(String itemId, int currentQuantity) {
    _cartController.updateCartItemQuantity(itemId, currentQuantity + 1);
  }

  void _decrementQuantity(String itemId, int currentQuantity) {
    if (currentQuantity > 1) {
      _cartController.updateCartItemQuantity(itemId, currentQuantity - 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(
      init: _cartController,
      builder: (controller) {
        // Check login status
        if (!_authController.isLoggedIn) {
          return const CheckLoginView();
        }
        if (_cartController.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (_cartController.cartItems.isEmpty) {
          return const CartEmptyView();
        }
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Giỏ hàng',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            actions: [
              TextButton(
                onPressed: () {
                  _cartController.clearCart();
                },
                child: const Text(
                  'Xóa tất cả',
                ),
              ),
            ],
          ),
          body: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      FluentIcons.arrow_left_16_filled,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Vuốt sang trái để xóa sản phẩm',
                      style: TextStyle(
                          fontSize: 14, fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: Obx(() {
                  return ListView.builder(
                    itemCount: _cartController.cartItems.length,
                    itemBuilder: (context, index) {
                      final item = _cartController.cartItems[index];
                      final formatter = NumberFormat('#,###', 'vi_VN');
                      final value = item.cartItem!.price!;
                      final formatPrice = formatter.format(value * 1000000);
                      return Dismissible(
                        key: Key(item.cartItem!.sId!),
                        direction: DismissDirection.endToStart,
                        confirmDismiss: (direction) async {
                          return await CoolAlert.show(
                            context: context,
                            type: CoolAlertType.confirm,
                            title: "Xóa sản phẩm",
                            confirmBtnColor: Colors.red,
                            showCancelBtn: true,
                            text:
                                "Bạn có chắc chắn muốn xóa sản phẩm này khỏi giỏ hàng?",
                            confirmBtnText: "Đồng ý",
                            cancelBtnText: "Hủy",
                            onConfirmBtnTap: () {
                              _cartController
                                  .removeCartItem(item.cartItem!.sId!);
                            },
                            onCancelBtnTap: () {},
                          );
                        },
                        background: Container(
                          decoration: BoxDecoration(
                            color: Colors.red.withOpacity(0.3),
                            border: Border.all(
                              color: Colors.red,
                              width: 4,
                            ),
                            backgroundBlendMode: BlendMode.hardLight,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: const Icon(
                            FluentIcons.delete_16_filled,
                            color: Colors.red,
                            size: 35,
                          ),
                        ),
                        child: Card(
                          margin: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 16),
                          child: ListTile(
                            leading: CachedNetworkImage(
                              imageUrl: item.cartItem!.img!,
                              fadeInDuration: const Duration(milliseconds: 200),
                              fadeOutDuration:
                                  const Duration(milliseconds: 200),
                              placeholder: (context, url) => const Center(
                                child: CircularProgressIndicator(),
                              ),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                            title: Text(
                              item.cartItem!.name!,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    IconButton(
                                      icon: const Icon(
                                        FluentIcons.subtract_circle_32_filled,
                                        color:
                                            Color.fromARGB(255, 162, 95, 230),
                                        size: 35,
                                      ),
                                      onPressed: () {
                                        _decrementQuantity(item.cartItem!.sId!,
                                            item.cartItem!.quantity!);
                                      },
                                    ),
                                    Text(
                                      '${item.cartItem!.quantity}',
                                      style: const TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                    IconButton(
                                      icon: const Icon(
                                        FluentIcons.add_circle_32_filled,
                                        color:
                                            Color.fromARGB(255, 162, 95, 230),
                                        size: 35,
                                      ),
                                      onPressed: () {
                                        _incrementQuantity(item.cartItem!.sId!,
                                            item.cartItem!.quantity!);
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            trailing: Text(
                              '$formatPrice ₫',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }),
              ),
            ],
          ),
          bottomNavigationBar: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Tổng tiền hàng',
                        style: TextStyle(color: Colors.grey)),
                    Text(
                      NumberFormat.currency(locale: 'vi_VN', symbol: '₫')
                          .format(_cartController.totalPrice.toDouble()),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Phí vận chuyển',
                      style: TextStyle(color: Colors.grey),
                    ),
                    Text('30.000 ₫'),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Tổng thanh toán',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      NumberFormat.currency(locale: 'vi_VN', symbol: '₫')
                          .format(
                              (_cartController.totalPrice + 30000).toDouble()),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                TextField(
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.discount, color: Colors.green),
                    hintText: 'Nhập mã giảm giá',
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.arrow_forward,
                          color: Color.fromARGB(255, 162, 95, 230)),
                      onPressed: () {
                        //discount logic
                      },
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    // Checkout logic
                    Get.toNamed('/checkout');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 162, 95, 230),
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    minimumSize: const Size(double.infinity, 48),
                  ),
                  child: const Text(
                    'Mua hàng',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        );
      },
    );
  }
}
