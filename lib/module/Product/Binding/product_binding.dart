// 🐦 Flutter imports:
import 'package:flutter/widgets.dart';

// 📦 Package imports:
import 'package:get/get.dart';

// 🌎 Project imports:
import 'package:techshop_app/module/Brand/Controller/brand_controller.dart';
import 'package:techshop_app/module/Cart/Controller/cart_controller.dart';
import 'package:techshop_app/module/Category/Controller/category_controller.dart';
import 'package:techshop_app/module/Product/Controller/product_controller.dart';
import 'package:techshop_app/services/Product/product_service.dart';

class ProductBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BrandController>(() => BrandController());
    Get.lazyPut<CategoryController>(() => CategoryController());
    Get.lazyPut<ScrollController>(() => ScrollController());
    Get.lazyPut<ProductService>(() => ProductService());
    Get.lazyPut<ProductController>(() => ProductController());
    Get.lazyPut<CartController>(() => CartController());
  }
}
