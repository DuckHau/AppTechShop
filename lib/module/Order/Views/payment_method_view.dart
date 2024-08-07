import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:techshop_app/constants/AppUrl.dart';

class PaymentMethodView extends StatelessWidget {
  final Function(String) onPaymentMethodSelected;

  const PaymentMethodView({super.key, required this.onPaymentMethodSelected});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chọn phương thức thanh toán'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          ListTile(
            title: Row(
              children: [
                Image.asset(
                  '${AppUrl.imageUrl}Order/COD.png',
                  width: 50,
                  height: 50,
                ),
                const SizedBox(width: 10),
                const Text('Thanh toán khi nhận hàng'),
              ],
            ),
            onTap: () {
              onPaymentMethodSelected('COD');
              Get.back();
            },
          ),
          ListTile(
            title: Row(
              children: [
                Image.asset(
                  '${AppUrl.imageUrl}Order/VNpay.png',
                  width: 50,
                  height: 50,
                ),
                const SizedBox(width: 10),
                const Text('Thanh toán qua VNPay'),
              ],
            ),
            onTap: () {
              onPaymentMethodSelected('VNpay');
              Get.back();
            },
          ),
          ListTile(
            title: Row(
              children: [
                Image.asset(
                  '${AppUrl.imageUrl}Order/vietqr.png',
                  width: 50,
                  height: 50,
                ),
                const SizedBox(width: 10),
                const Text('Thanh toán qua VietQR'),
              ],
            ),
            onTap: () {
              onPaymentMethodSelected('vietqr');
              Get.back();
            },
          ),
        ],
      ),
    );
  }
}
