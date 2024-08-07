// 📦 Package imports:
import 'package:dio/dio.dart';
import 'package:get/get.dart';

// 🌎 Project imports:
import 'package:techshop_app/models/brand.dart';
import 'package:techshop_app/services/API/ApiException.dart';
import 'package:techshop_app/services/Brand/brand_service.dart';

class BrandController extends GetxController {
  final BrandService _brandService = BrandService();
  Rx<Brand> brand = Rx<Brand>(Brand());
  Rx<RxStatus> status = Rx<RxStatus>(RxStatus.empty());

  @override
  void onInit() {
    super.onInit();
    getTopBrands();
  }

  void getTopBrands() async {
    status.value = RxStatus.loading();
    update();
    try {
      final response = await _brandService.getTopBrands();
      // print('API Response: ${response.data}');
      if (response.statusCode == 200) {
        brand.value = Brand.fromJson(response.data);
        // print('Parsed Category: ${brand.value}');
        status.value = RxStatus.success();
      }
    } on DioException catch (e) {
      final ApiException apiException = ApiException.fromDioException(e);
      status.value = RxStatus.error(apiException.toString());
    }
    update();
  }
}
