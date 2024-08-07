// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:get/get.dart';
import 'package:techshop_app/Routes/app_pages.dart';

// 🌎 Project imports:
import 'package:techshop_app/constants/AppUrl.dart';
import '../Controller/brand_controller.dart';

class BrandView extends StatelessWidget {
  final _brandController = Get.find<BrandController>();
  BrandView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (_brandController.status.value.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (_brandController.status.value.isError) {
          return const Center(
            child: Text('Error'),
          );
        } else {
          return Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                for (int i = 0;
                    i < _brandController.brand.value.data!.length;
                    i++)
                  Column(children: [
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(
                          Routes.PRODUCT,
                          arguments: {
                            'brand': _brandController.brand.value.data![i]
                          },
                        );
                        // print(_brandController.brand.value.data![i].toString());
                      },
                      child: Column(
                        children: [
                          ClipOval(
                            child: Image.asset(
                              '${AppUrl.imageUrl}${_brandController.brand.value.data![i]}.png',
                              height: 50,
                              width: 50,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Text(_brandController.brand.value.data![i]),
                        ],
                      ),
                    ),
                  ]),
              ],
            ),
          );
        }
      },
    );
  }
}
