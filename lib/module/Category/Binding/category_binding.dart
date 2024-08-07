// 📦 Package imports:
import 'package:get/get.dart';

// 🌎 Project imports:
import 'package:techshop_app/module/Category/Controller/category_controller.dart';
import 'package:techshop_app/services/Category/category_service.dart';

class CategoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CategoryService>(() => CategoryService());
    Get.lazyPut<CategoryController>(() => CategoryController());
  }
}
