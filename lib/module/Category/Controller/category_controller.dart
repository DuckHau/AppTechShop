// 📦 Package imports:
import 'package:dio/dio.dart';
import 'package:get/get.dart';

// 🌎 Project imports:
import 'package:techshop_app/services/API/ApiException.dart';
import 'package:techshop_app/services/Category/category_service.dart';
import '../../../models/category.dart';

class CategoryController extends GetxController {
  final _categoryService = CategoryService();
  Rx<Category> category = Rx<Category>(Category());
  Rx<RxStatus> status = Rx<RxStatus>(RxStatus.empty());

  void getCategories() async {
    Future.microtask(() => status.value = RxStatus.loading());
    try {
      await Future.delayed(Duration.zero, () async {
        final response = await _categoryService.getCategories();
        // print('API Response: ${response.data}');
        if (response.statusCode == 200) {
          category.value = Category.fromJson(response.data);
          // print('Parsed Category: ${category.value}');
          Future.microtask(() => status.value = RxStatus.success());
        }
      });
    } on DioException catch (e) {
      final ApiException apiException = ApiException.fromDioException(e);
      Future.microtask(
          () => status.value = RxStatus.error(apiException.toString()));
    }
    update();
  }

  void getCategoryBySlug(String slug) async {
    Future.microtask(() => status.value = RxStatus.loading());
    try {
      final response = await _categoryService.getCategoryBySlug(slug);
      if (response.statusCode == 200) {
        category.value = Category.fromJson(response.data);
        Future.microtask(() => status.value = RxStatus.success());
      }
    } on DioException catch (e) {
      final ApiException apiException = ApiException.fromDioException(e);
      Future.microtask(
          () => status.value = RxStatus.error(apiException.toString()));
    }
    update();
  }
}
