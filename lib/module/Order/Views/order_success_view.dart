// 🐦 Flutter imports:
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:techshop_app/Routes/app_pages.dart';

// 🌎 Project imports:
import 'package:techshop_app/constants/AppUrl.dart';

class OrderSuccessView extends StatelessWidget {
  const OrderSuccessView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[100],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: Container(
              color: const Color.fromARGB(255, 162, 95, 230),
              child: Center(
                child: Image.asset(
                  '${AppUrl.imageUrl}Order/order_success.png',
                  height: 400,
                  width: 400,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 24.0),
                  const Text(
                    'Đặt hàng thành công',
                    style: TextStyle(
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  const Text(
                    'Sản phẩm của bạn sẽ được giao đến trong 2-3 ngày kể từ khi đặt hàng',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: () {
                      Get.toNamed(Routes.DASHBOARD, arguments: 2);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 162, 95, 230),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100.0),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32.0, vertical: 25.0),
                      minimumSize: const Size(double.infinity, 40.0),
                      maximumSize: const Size(double.infinity, 100.0),
                    ),
                    child: const Text(
                      'Xem chi tiết đơn đặt hàng',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
