// 📦 Package imports:
import 'package:get/get.dart';

// 🌎 Project imports:
import 'package:techshop_app/module/Auth/Controller/auth_controller.dart';
import 'package:techshop_app/module/Brand/Controller/brand_controller.dart';
import 'package:techshop_app/module/Cart/Controller/cart_controller.dart';
import 'package:techshop_app/module/Category/Controller/category_controller.dart';
import 'package:techshop_app/module/Dashboard/Controller/dashboard_controller.dart';
import 'package:techshop_app/module/Order/Controller/order_controller.dart';
import 'package:techshop_app/module/Product/Controller/product_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() => AuthController());
    Get.lazyPut<BrandController>(() => BrandController());
    Get.lazyPut<CategoryController>(() => CategoryController());
    Get.lazyPut<ProductController>(() => ProductController());
    Get.lazyPut<CartController>(() => CartController());
    Get.lazyPut<OrderController>(() => OrderController());
    Get.lazyPut<DashboardController>(() => DashboardController());
  }
}
